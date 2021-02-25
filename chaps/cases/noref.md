# 资源引用丢失
---

在增量编译过程中如果Unity闪退了，除了会产生导致崩溃的问题资源，也会导致一些不那么严重、但是非常奇怪的渲染结果：屏幕渲染出现紫块或者渲染效果异常，通过`scanref`也可以发现这样的问题，如下日志里面还有`missing`标记。

```
archive:/cab-f8642b11cae21bfbe1fac93206d98fba/cab-f8642b11cae21bfbe1fac93206d98fba dynamic/module/vehiclesskin_bundle_52_02!7!forcedownload!cod_models$vehicles$tank$5!2.pak
    - archive:/cab-12279edb29aa918860d5fb88556056ca/cab-12279edb29aa918860d5fb88556056ca i:4 missing
```

#### 屏幕紫块

假如ab资源A引用的材质球M在另外一个ab文件B里面，由于M的打包配置变化导致它应该打包到ab资源C里面，但是由于Unity闪退B和C被正常打包而A没有被正常打包，这种情况下A资源尝试去B资源里面加载M，但是M已经从B里面移除并打包到了C里面，从而出现材质球加载失败的问题，就会出现紫块。


#### 渲染异常


