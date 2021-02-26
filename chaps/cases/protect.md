# 资源防护
---

通过资源逆向案例我们见识了abtool强大的资源反编译能力，但是这个时候我们不应该兴奋，而是应该无比忧虑才对：因为第三方工具可以在没有项目仓库权限的情况下轻易获取游戏资源，这些都是项目团队日夜攻坚、长时间累积优化的结果，如果被用于非法目的，对游戏是非常不利的。问题来了：既然ab资源如此容易破解，那么该如何保护游戏资产？

#### 打包ab资源时关掉TypeTree

我们先来看下ab打包接口

```csharp
public static AssetBundleManifest BuildAssetBundles(
    string outputPath,
    AssetBundleBuild[] builds,
    BuildAssetBundleOptions assetBundleOptions,
    BuildTarget targetPlatform);
```

第三个枚举参数`BuildAssetBundleOptions`用来控制ab的打包行为，其中枚举值`DisableWriteTypeTree`可以关闭TypeTree。
```csharp
/// <summary>
///   <para>Do not include type information within the AssetBundle.</para>
/// </summary>
DisableWriteTypeTree = 8,
```

由于abtool绝大部分功能都基于TypeTree，那是不是关闭TypeTree资源就安全了？没那么简单！TypeTree是由Unity生成，换句话说，如果拿到相同版本的Unity也是可以轻易获取TypeTree的，在这种情况下，关掉TypeTree的意义仅仅是防止了破解`MonoBehaviour`，防护等级是很弱的！换句话说，如果你用了Unity公开发行的版本（标准版），那么你的的游戏资产完全是在裸奔的！

#### 修改关键资源序列化

如果你的项目有源码，那么可以把一些关键资源的序列化字段改一下。比如`Texture2D`这个资源类型，它的数据结构大致如下

```c++
struct Texture2D: public Object {
    std::string m_Name;  // 1
    int32_t m_ForcedFallbackFormat;  // 2
    bool m_DownscaleFallback;  // 3
    int32_t m_Width;  // 4
    int32_t m_Height;  // 5
    int32_t m_CompleteImageSize;  // 6
    int32_t m_TextureFormat;  // 7
    int32_t m_MipCount;  // 8
    bool m_IsReadable;  // 9
    int32_t m_ImageCount;  // 10
    int32_t m_TextureDimension;  // 11
    GLTextureSettings m_TextureSettings;  // 12
    int32_t m_LightmapFormat;  // 13
    int32_t m_ColorSpace;  // 14
    TypelessData m_TexData;  // 15
    StreamingInfo m_StreamData;  // 16
};
```

在资源对象序列化过程中，`string`/`map`/`set`/`vector`等数据类型均被当做数组来处理：先用4字节存储数组长度，然后按顺序存储数组元素，对于`string`它的数组元素类型是`char`。基于此，我们可以在标准版的Unity源码里面做一些微小改动，比如把上述类型序列化顺序交换位置，或者在这些字段的序列化之前写入一个很大的整形，这样通过标准版Unity反编译资源就会导致崩溃或者无限循环。该保护措施的本质是修改资源类型的数据结构，使其与标准版Unity生成TypeTree产生差异，从而导致通过标准版Unity破解资源的方法失效。

#### 修改`AssetBundleArchive`存储结构

每个ab资源在Unity里面会都会通过一个`AssetBundleArchive`容器来存储，它的作用是压缩资源对象数据并提供文件寻址功能，并没有什么特别的，如果你的项目有源码完全可以自行设计一个实现类似功能的资源容器，比如王者荣耀、原神等游戏做了类似的设计。

#### 修改`SerializedFile`存储结构

除了定制资源容器，还可以通过修改容器内资源的存储方式，比如修改`SerializedFile`的metadata数据的组织方式。

#### 加密

如果觉得上述源码修改过于复杂，那么可以对ab文件做二进制的加密，也可以选择对其部分内容做加密，前提是不要有过多运行时开销，比如LOL手游做了类似的设计。



