# saveobj
---

#### 用途

`saveobj`提取资源对象的简要信息并默认保存到当前cd目录的`objects.obj`文件，主要为`getref`、`cmpref`、`resolve`、`abname`等命令提供基础数据。

#### 参数

|参数|缩写|描述|
|:-|:-:|:-|
|--artifact|-a|文件的存储路径，默认：`objects.obj`|

`saveobj`每次运行时会自动通过`-a`指定的路径读取文件保存路径，并把二次运行得到的数据与缓存数据进行合并，然后在运行结束后把最终的数据存储到参数`-a`指定的路径。

#### 示例

```bash
# 假设ab资源的文件名为*.ab，请根据实际文件名做适当修改
find . -iname '*.ab' | xargs abtool saveobj
```

