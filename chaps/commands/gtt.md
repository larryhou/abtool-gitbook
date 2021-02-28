# gtt
---

#### 用途

`gtt`可以把`savetree`命令生成类型数据`types.tte`转换成格式工整的`C++`代码，分别对应一下工程代码。

* `abtool/assetbundles/unity/types.hpp`：定义资源类型数据结构
* `abtool/assetbundles/unity/types.cpp`：实现资源对象序列化
* `abtool/assetbundles/unity/luatypes.cpp`：实现资源类型的lua绑定
* `abtool/assetbundles/unity/textize.cpp`：实现资源对象`dump`方法，用来打印对象信息
* `abtool/assetbundles/unity/compare.cpp`：实现对象比对逻辑

#### 参数

|参数|缩写|描述|
|:-|:-:|:-|
|--artifact|-a|二进制类型文件路径，默认：`types.tte`|
|--limit|-l|限定类定义数量，避免生成过多代码，默认：`400`|
|--output|-o|代码输出路径，默认：`__types`|

#### 示例

```bash
abtool gtt -a types.tte -o abtool/assetbundles/unity
```
