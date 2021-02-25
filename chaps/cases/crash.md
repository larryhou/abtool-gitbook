# 资源引发崩溃
---

一般情况下资源导致游戏崩溃并不多见，随着游戏资源量的增加以及构建时间的增加，就会需要用到Unity的ab增量编译，但是如果增量编译过程中发生了Unity闪退或者系统崩溃，那么就有很大几率导致编译出来的资源出问题，并且Unity下次构建时也无法自我修复。

举个例子，我们项目的ab资源增加到3G的时候遇到一次比较严重的由热更资源引发的崩溃，由于每次崩溃的时机各有不同，定位起来非常困难，最后通过一个能够稳定复现的崩溃定位到是资源引发的崩溃，具体原因是：材质球A引用的贴图T在另外一个ab文件里面，但是通过材质球A的引用路径去加载后得到的是一个另外一个材质球B资源，可以理解为材质球A的贴图指针位置不是贴图T，那么通过材质球A的贴图指针尝试访问贴图T的时候就崩溃了。然后根据这个特征，笔者开发了`scanref`工具，它的作用是扫描所有的引用了材质球、贴图、Mesh的对象，然后通过引用路径找到目标资源对象，并校验目标资源的类型是否跟预期一致。

![](crash/scanref.png)

图中的日志是什么含义呢？那是纯正的崩溃的味道！
```
T archive:/cab-935fbd22f82316cda48c391a5d38e03b/cab-935fbd22f82316cda48c391a5d38e03b i:4 expect=Mesh:43 actual=Texture2D:28
```
针对其中一行日志简单解释下，`archive:/`开头一串文本是ab里面`SerializedFile`的路径，可以用来寻址。资源`dynamic/module/role_bundle_08!7!forcedownload!cod_models$avatar$seal6_003_bluewhite.pak`里面id为`767`的`SkinnedMeshRenderer`对象拥有一个外部资源指针`PPtr<Mesh>`，指向另外一个ab资源文件(`archive:/cab-935fbd22f82316cda48c391a5d38e03b/cab-935fbd22f82316cda48c391a5d38e03b`)中索引为`m_PathID=4`的对象，但是目标引用路径的资源其实是个`Texture2D`对象。

> 上述`SkinnedMeshRenderer`数据文本展开显示

```c++
<SkinnedMeshRenderer:137> id=767
    m_GameObject:PPtr<GameObject>
        m_FileID = 0
        m_PathID = 169
    m_Enabled:bool = 1
    m_CastShadows:uint8_t = 1
    m_ReceiveShadows:uint8_t = 1
    m_ReceiveNoSSShadows:uint8_t = 0
    m_DynamicShadows:uint8_t = 1
    m_MotionVectors:uint8_t = 2
    m_LightProbeUsage:uint8_t = 1
    m_ReflectionProbeUsage:uint8_t = 3
    m_LightmapIndex:uint16_t = 65535
    m_LightmapIndexDynamic:uint16_t = 65535
    m_LightmapTilingOffset:Vector4f
        x:float = 1
        y:float = 1
        z:float = 0
        w:float = 0
    m_Materials:vector<PPtr<Material>>
        [0]:PPtr<Material>
            m_FileID = 0
            m_PathID = 3
    m_StaticBatchInfo:StaticBatchInfo
        firstSubMesh:uint16_t = 0
        subMeshCount:uint16_t = 0
    m_StaticBatchRoot:PPtr<Transform>
        m_FileID = 0
        m_PathID = 0
    m_ProbeAnchor:PPtr<Transform>
        m_FileID = 0
        m_PathID = 0
    m_LightProbeVolumeOverride:PPtr<GameObject>
        m_FileID = 0
        m_PathID = 0
    m_SortingLayerID:int32_t = 0
    m_SortingLayer:int16_t = 0
    m_SortingOrder:int16_t = 0
    m_Quality:int32_t = 0
    m_UpdateWhenOffscreen:bool = 0
    m_SkinnedMotionVectors:bool = 0
    m_Mesh:PPtr<Mesh>
        m_FileID = 4
        m_PathID = 4
    m_Bones:vector<PPtr<Transform>>
        [0]:PPtr<Transform>
            m_FileID = 0
            m_PathID = 703
    m_BlendShapeWeights:vector<float>
    m_RootBone:PPtr<Transform>
        m_FileID = 0
        m_PathID = 703
    m_AABB:AABB
        m_Center:Vector3f
            x:float = -0.145836
            y:float = 0.0210291
            z:float = 0.00812059
        m_Extent:Vector3f
            x:float = 0.109583
            y:float = 0.15261
            z:float = 0.10819
    m_DirtyAABB:bool = 0
```

> 通过引用路径找到的资源却是`Texture2D`对象

![](crash/notmesh.png)

把`Texture2D`对象强转成`Mesh`对象赋值给`SkinnedMeshRenderer`对象，最终就会导致崩溃。庆幸的现在可以通过`abtool scanref`扫描游戏的所有资源，30秒就可以扫描3G左右的ab资源，可以说非常效率。

```
find . -iname '*.pak' | xargs abtool scanref
```

`scanref`会把扫描数据存到当前目录的`assets.ref`文件，下次运行的时候`scanref`会自动读取缓存文件`assets.ref`，这样不用再次扫描ab资源就可以快速得到相同的结果，直接把耗时降到2秒。

```
abtool scanref
```

上面的操作还只是发现资源问题，其实我们更想知道这样的问题如何解决，根据问题的严重性有两种解决方法：
1. 如果只有少量ab资源存在引用问题，那么可以把扫描出来的ab资源从构建机的输出目录删掉，下次构建时Unity会修复这些资源；
2. 如果有很多ab资源都存在引用问题，可以通过ab资源回退的方式来解决，前提是每次构建后都归档了相应的ab资源。具体操作是，下载历史构建的ab资源，运行`abtool scanref`找到一个没有资源引用问题的资源版本，然后用这个版本的ab资源替换构建机上的ab资源，并重新运行一次ab打包流程。

到现在为止，我们知道如何通过abtool发现资源问题，也拥有解决问题的方法，但是相信大家依然会有疑问：资源崩溃问题是如何产生的？

就上面`SkinnedMeshRenderer`错误引用`Texture2D`的例子来说，可以解释为：由于依赖关系变更，A和B两个ab资源都需要重新打包，但是ab资源B打包完成后，由于意外原因导致Unity打包流程中断，本来应该被重新打包的A资源，因为Unity的闪退而被忽略打包，所以A保持为老资源状态并引用了一个错误的资源，并且下次构建的时候Unity也无法识别这种异常情况。

