# lua
---

#### 用途

由于`abtool`预置丰富的`lua`类型绑定，通过该命令允许你在不修改源码的情况下做一些个性化的任务。

#### 参数

|参数|缩写|描述|
|:-|:-:|:-|
|--type|-t|设置该命令加载的资源类型ID，默认为`0`，表示加载所有类型的资源|
|--file|-f|`lua`脚本路径，默认：`abtool.lua`|

通过该命令可以执行lua脚本文件，并且在脚本中可以访问如下几个全局变量：
+ archive

    `archive`绑定了当前lua脚本处理中的`assetbundle::AssetBundleArchive`对象

+ file

    `file`绑定了当前lua脚本处理中的`assetbundle::SerializedFile`对象

+ directory

    `directory`绑定了`assetbundle::DirectoryInfo`对象，如果需要访问`archive`中其他文件对象，可以通过方法`directory:load([path])`进行文件加载

其他lua绑定接口可以查看以下两个文件：
1. `abtool/luatypes.cpp`

    该文件绑定了与`assetbundle::AssetBundleArchive`和`assetbundle::SerializedFile`有关的数据结构以及接口。

2. `abtool/assetbundles/unity/luatypes.cpp`
   
   该文件绑定了所有Unity资源对象的数据结构。

#### 示例

```bash
abtool lua artresource_environment_scene_logicmesh_small_checkerboard.god
```

```lua
so = file:find(7397932659350227505)
file:dump_object(7397932659350227505)
ptr = castMaterial(so.object) -- std::shared_ptr<Material>
mat = ptr:get() -- Material*
mat.m_Shader.m_PathID = 0
mat.m_Shader.m_FileID = 0
file:dump_object(7397932659350227505)
builder = assetbundle.ArchiveFileBuilder(archive) -- assetbundle::ArchiveFileBuilder
builder:save("hijack/artresource_environment_scene_logicmesh_small_checkerboard.god")
```