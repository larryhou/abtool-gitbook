# cmpxtl
---

#### 用途

`cmpxtl`通过对比两个`externals.xtl`文件生成ab依赖变化报告。

#### 参数

|参数|缩写|描述|
|:-|:-:|:-|
|--source|-s|`externals.xtl`基线文件|
|--destination|-d|`externals.xtl`对比文件|

#### 示例

```bash
abtool cmpxtl -s iMSDK_CN_Android_108_AssetBundle/externals.xtl -d iMSDK_CN_Android_145_AssetBundle/externals.xtl 
```

![](cmpxtl/cmpxtl.png)

如上所示，每行日志的开头都有一个特殊符号，含义分别如下：
- `-`：表示当前ab文件的外部依赖数量减少
- `+`：表示当前ab文件的外部依赖数量增加
- `±`：表示当前ab文件的外部依赖有增加也有减少
- `≠`：表示当前ab文件对比前后外部依赖列表集合相同，但是排列顺序不同
