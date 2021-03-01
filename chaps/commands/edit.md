# edit
---

#### 用途

`edit`是一个命令行交互环境，该命令会加载当前ab文件内的资源对象，然后可以通过`lua`代码来查看和修改内存中的资源对象。

#### 参数

|参数|缩写|描述|
|:-|:-:|:-|
|--type|-t|设置该命令加载的资源类型ID，默认为`0`，表示加载所有类型的资源|

#### 示例

```bash
abtool edit bundle/common_actcenter_act_91_bg-ziyuanfanbei_1.assetbundle
```

![](edit/edit.png)

