# cmpref
---

#### 用途

`cmpref`通过对比两个`objects.obj`文件生成资源引用变化报告。

#### 参数

|参数|缩写|描述|
|:-|:-:|:-|
|--source|-s|`objects.obj`基线文件|
|--destination|-d|`objects.obj`对比文件|

#### 示例

```bash
abtool cmpref -s iMSDK_CN_Android_108_AssetBundle/objects.obj -d iMSDK_CN_Android_145_AssetBundle/objects.obj
```

![](cmpref/cmpref.png)

日志前后各有一个标志位，可以按照下面规则归类
* `S`开头表示当前前ab文件内的资源槽位`m_PathID`发生了重新分配，末尾标记为`(*)`
* `P`开头表示资源对象指针变了，末尾标分以下几种情况
    + `(=)`表示资源路径相同，但是`m_PathID`变了
    + `(#)`表示资源路径相同，但是所属的ab文件变了
    + `(+)`表示资源路径变了
* `M`开头表示资源对象指针在第二个`objects.obj`文件置空了，末尾标记为`(?)`

