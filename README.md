# 简介
---

#### 愿景

abtool旨在提供基于Unity资源封装格式`AssetBundle`的C++开发框架以及预置工具集合，方便针对资源做**任意**的检测、编辑以及资源问题定位。

#### 开发背景

笔者2020年初加入使命召唤手游项目，这是一款偏向内容运营的高品质手机游戏，有非常多的ab资源，从笔者加入项目时的1G左右增加到现在的5G左右，未来可以预期持续的增长。伴随着资源量的增加，资源相关的崩溃、显示问题越来越多，定位解决这些问题是一个常态化的工作。

笔者的工作内容主要是负责版本以及资源发布，在abtool出现之前定位这些问题非常困难，特别是资源引起的游戏崩溃问题，困难主要表现为：

1. 需要稳定的重现方法，通常需要花很多时间去摸索
2. 需要增加运行时调试信息来辅助判断，甚至需要真机调试，通常需要重新构建

处理这类问题遇到最大的麻烦是：**即使解决了崩溃，你仍然无法确定是否还有其他类似的资源崩溃问题**。我们有7000个左右的ab文件，排查所有的资源问题犹如大海捞针，每次发版本都是战战兢兢、如履薄冰，并且经常通宵攻坚，但也不总是有效，这种情况下只能延迟版本发布。

鉴于笔者丰富的工具开发经验，经历几次通宵后，笔者决定通过工具化寻求突破，最终的开发进度以及使用效果也是十分喜人，截止文档撰写日起已有20多个内置命令，它们均是在解决资源问题过程中逐渐增加和完善的，具有很强的实用性。当然，通过后续的章节了解熟悉后，你也可以轻易开发出专属于你的工具命令。

#### 文档更新

如果你需要访问最新的文档内容，建议你[查阅在线文档版本](https://larryhou.github.io/abtool-gitbook/)[^1]，或者手动[下载当前文档的最新版本](https://larryhou.github.io/abtool-gitbook/book.pdf)[^2]。

由于文档撰写比较匆忙，难免有所谬误，请多包涵。同时，也欢迎大家[Fork](https://github.com/larryhou/abtool-gitbook/fork)笔者的[文档仓库](https://github.com/larryhou/abtool-gitbook/)[^3]并提交相应的PR，让我们一起来完善它，感激不尽！

[^1]: https://larryhou.github.io/abtool-gitbook/
[^2]: https://larryhou.github.io/abtool-gitbook/book.pdf
[^3]: https://github.com/larryhou/abtool-gitbook/
