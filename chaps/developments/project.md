# 项目架构
---

abtool工程可以分为一下几个模块

1. 资源解析
   1. `AssetBundleArchive`解析
   2. `SerializedFile`解析
2. 代码生成
   1. 数据结构
   2. 对象方法
      + 数据编码
      + 数据解码
      + 对象打印
   3. LUA绑定
3. 命令封装
   1. 参数解析
   2. 生命周期
4. 文件系统

![](project/project.svg)

其中`资源解析`和`代码生成`是比较固定的模块，绝大部分情况下不需要手动修改，所以后面章节不对此过多涉猎。

