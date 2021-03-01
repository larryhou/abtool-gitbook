# savextl
---


#### 用途

`savextl`扫描并收集`SerializedFile`的`metadata`数据里面提取ab间依赖关系，并把相应的数据缓存到当前目录的`externals.xtl`文件，主要为`cmpxtl`命令提供基础数据。

#### 参数

|参数|缩写|描述|
|:-|:-:|:-|
|--artifact|-a|文件的存储路径，默认：`externals.xtl`|

`savextl`每次运行时会自动通过`-a`指定的路径读取文件保存路径，并把二次运行得到的数据与缓存数据进行合并，然后在运行结束后把最终的数据存储到参数`-a`指定的路径。

#### 示例

```bash
# 假设ab资源的文件名为*.ab，请根据实际文件名做适当修改
find . -iname '*.ab' | xargs abtool savextl
```

