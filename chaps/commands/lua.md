# lua
---

#### 用途

由于`abtool`预置丰富的`lua`类型绑定，通过该命令允许你在不修改源码的情况下做一些个性化的任务。

#### 参数

|参数|缩写|描述|
|:-|:-:|:-|
|--type|-t|设置该命令加载的资源类型ID，默认为`0`，表示加载所有类型的资源|
|--file|-f|`lua`脚本路径，默认：`abtool.lua`|

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