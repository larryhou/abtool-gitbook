-- 通过m_PathID查找SerializedObject对象
trace('原始材质球')
so = file:find(7397932659350227505)
-- 打印原始材质
file:dump_object(7397932659350227505)
-- 类型转换
ptr = castMaterial(so.object) -- std::shared_ptr<Material>
-- 获取材质球对象引用
mat = ptr:get() -- Material*
-- 设置材质的Shader为空引用
mat.m_Shader.m_PathID = 0
mat.m_Shader.m_FileID = 0
-- 打印修改后材质
trace('修改后材质球')
file:dump_object(7397932659350227505)
-- 保存当前修改
builder = assetbundle.ArchiveFileBuilder(archive) -- assetbundle::ArchiveFileBuilder
builder:save("hijack/artresource_environment_scene_logicmesh_small_checkerboard.god")
