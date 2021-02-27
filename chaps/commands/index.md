# 第三章 命令详解
---

截止文档撰写日起已有20多个内置命令，它们均是在解决资源问题过程中逐渐增加和完善的，具有很强的实用性。

#### 颜色高亮
大部分命令运行过程中输出到终端的日志都是有颜色样式的，这个设计主要是根据信息的重要性做不同的高亮突出显示，方便在日志里面找到有用的信息。当然，也强烈建议你把终端设置为黑色背景样式，不然颜色显示会比较奇怪，因为黑色背景为终端显示样式的调试环境。

![](color.png)

然而，在有些情况下，我们需要对工具输出的日志做进一步分析，这个时候我们是不希望有颜色高亮的，因为这些颜色都是通过[颜色控制符](https://misc.flogisoft.com/bash/tip_colors_and_formatting)[^1]实现的，这会让日志里面多出一些方括号`[`的字符，如下图显示看起来比较杂乱，有可能会让下游的分析工具产生不符合预期的结果。

![](color-raw.png)

不过工程根目录里的`nocolor.cpp`的小工具可以轻松去掉终端的颜色样式，该工具含代码格式只有26行C++代码，非常轻量高效。

```c++
#include <iostream>
#include <string>

int main(int argc, char* argv[]) 
{
    std::string pipe;
    while (std::getline(std::cin, pipe))
    {
        auto cursor = pipe.begin();
        for (auto iter = pipe.begin(); iter != pipe.end(); iter++)
        {
            if (*iter == '\e' && *(iter+1) == '[')
            {
                ++iter; // [
                ++iter; // d
                ++iter; // m
                if (*iter != 'm') { ++iter; }
                continue;
            }

            *cursor++ = *iter;
        }
        *cursor = 0;
        std::cout << pipe.data() << std::endl;
    }
    return 0;
}
```

可以通过如下终端命令快速编译。

```bash
clang++ -std=c++11 nocolor.cpp -o/usr/local/bin/nocolor
```

使用起来也十分方便，只需命令末尾追加管道。

```bash
abtool list doc/resources/android/quickstart.ab | nocolor
```

![](nocolor.png)

#### 帮助系统

abtool内置了简单的帮助系统，可以帮助我们快速了解命令功能以及参数，比如可以通过`abtool help`查看所有命令。

```
$ abtool help
abtool COMMAND file ...
Commands:
  abname       : 通过SF路径从*.obj文件解析ab名字
  cmpmono      : 比对mono命令生成的*.ms文件并生成脚本变更报告
  cmpref       : 对比saveobj命令生成的*.obj文件并分析对象引用
  cmpxtl       : 比对external命令生成的*.xtl文件并生成ab依赖变更报告
  dump         : 生成文本格式的对象数据
  edit         : 进入交互编辑模式
  external     : 收集AB外部依赖信息
  gencpp       : 从AB文件提取TypeTree并生成C++序列化代码
  getref       : 获取资源引用
  gtt          : 从序列化的TypeTree文件生成C++代码
  help         : 获取帮助信息
  list         : 查看进包资源
  lua          : 运行LUA脚本
  missing      : 扫描资源引用丢失
  mono         : 扫描MonoScript脚本使用信息
  rename       : 根据AssetBundle::m_Name还原文件名
  resolve      : 通过SF路径以及m_PathID信息从*.obj文件获取实体资源信息
  rmtree       : 剔除TypeTree信息
  savefbx      : 扫描Mesh资源并保存为*.fbx文件
  saveobj      : 保存对象数据
  saveta       : 保存TextAsset资源
  savetex      : 保存Texture2D资源
  savetree     : 保存TypeTree二进制数据
  scanref      : 检查资源引用的对象类型是否匹配
  scantex      : 扫描非标准格式的贴图
  size         : 生成对象大小简报
  test         : 序列化正确性测试
  textize      : 文本化序列化文件并保存文件
```

abtool命令采用了一致的参数传参设计，可以通过`abtool [command] --help`查看参数含义，
```
$ abtool savefbx --help
  -r  --axis-rotate-enabled  rotate model 90 degrees by axis-X counter-clockwise [FLAG]
  -o  --output      *.fbx output path [OPTIONAL](default=__fbx)
  -w  --rewritable  rewrite local file if it exists [FLAG]
  -s  --skeleton-enabled  include skeleton info in exporation [FLAG]
```

* `[FLAG]`表示当前参数为功能开关并且参数没有参数值
* `[OPTIONAL]`表示当前参数为可选参数并有默认值，例如`default=__fbx`
* 其他类型的参数为必选参数，也即是参数名和参数值必须设置正确，否则会运行崩溃

在本章节只会对一些常用的命令做详细的说明，但不代表abtool只有这些内置命令。

[^1]: https://misc.flogisoft.com/bash/tip_colors_and_formatting


