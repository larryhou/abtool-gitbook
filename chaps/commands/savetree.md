# savetree
---

#### 用途

`savetree`可以从`SerializedFile`的`metadata`数据区提取资源对象的类型`TypeTree`，并把二进制`TypeTree`数据保存到当前目录。

#### 参数

|参数|缩写|描述|
|:-|:-:|:-|
|--artifact|-a|指定缓存文件的存储路径，默认：`types.tte`|

`savetree`每次运行时会自动通过`-a`指定的路径读取缓存配置，并把二次运行得到的数据与缓存数据进行合并，然后在运行结束后把最终的数据存储到参数`-a`指定的路径。

如果你的项目工程没有包含所有abtool运行所需的必要资源类型，那么可以用你的Unity软件新建一个工程，然后导入`QuickStart.unitypackage`，并通过Editor菜单`abtool/Build Asset Bundles`生成对应平台的ab文件`quickstart.ab`，之后通过`savetree`第一次生成`types.tte`，进而在此基础上扫描你的项目ab资源，这样最终得到的`TypeTree`数据文件就不会缺少相关类型信息了。

#### 示例

```bash
# 假设ab资源的文件名为*.ab，请根据实际文件名做适当修改
find . -iname '*.ab' | xargs abtool savetree
```
