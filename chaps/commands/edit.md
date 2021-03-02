# edit
---

#### 用途

`edit`是一个命令行交互环境，该命令会加载当前ab文件内的资源对象，然后可以通过lua代码来查看和修改内存中的资源对象。

#### 参数

|参数|缩写|描述|
|:-|:-:|:-|
|--type|-t|设置该命令加载的资源类型ID，默认为`0`，表示加载所有类型的资源|

该命令支持的如下交互命令：
1. lua
   
    通过`lua`子命令可以执行lua代码，并且预设以下几个全局变量：
    + archive

        `archive`绑定了当前交互中的`assetbundle::AssetBundleArchive`对象

    + file

        `file`绑定了当前`archive`对象中最后一个`assetbundle::SerializedFile`对象

    + directory

        `directory`绑定了`assetbundle::DirectoryInfo`对象，如果`archive`里面包含多个序列化文件对象，可以通过方法`directory:load([path])`进行文件指针切换

2. save

    通过`save`子命令可以保存当前内存中的ab文件

其他lua绑定接口可以查看以下两个文件：
1. `abtool/luatypes.cpp`

    该文件绑定了与`assetbundle::AssetBundleArchive`和`assetbundle::SerializedFile`有关的数据结构以及接口。

2. `abtool/assetbundles/unity/luatypes.cpp`
   
   该文件绑定了所有Unity资源对象的数据结构。

#### 示例

```bash
abtool edit bundle/common_actcenter_act_91_bg-ziyuanfanbei_1.assetbundle
```

![](edit/edit.png)

