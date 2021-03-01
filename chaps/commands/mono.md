# mono
---

#### 用途

`mono`命令扫描`MonoBehaviour`脚本使用分布，并把相应的扫描结果缓存到当前目录的`monoscripts.ms`文件。

#### 参数

|参数|缩写|描述|
|:-|:-:|:-|
|--artifact|-a|缓存文件路径，默认：`monoscripts.ms`|
|--verbose|-v|更多日志开关|

#### 示例

```
find . -iname '*.pak' | xargs abtool mono
```

再次运行该命令时可以简化为，当前模式下会自动加载`monoscripts.ms`文件，并打印相关信息，如下。
![](../cases/compare/mono.png)

+ 第一列：序号
+ 第二列：`MonoBehaviour`的完整类定义名，其中冒号`:`前的部分是命令空间，后半部分为类名
+ 第三列：该类实例化的次数，在`GameObject`上添加一次组件算作一次实例化
+ 第四列：引用该类的ab资源文件数量
+ 第五列：引用该类的ab资源文件总大小，按字节数显示
+ 第六列：引用该类的ab资源文件总大小，安文本化显示
+ 第七列：该类的指纹`Hash128`

