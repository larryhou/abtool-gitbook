# saveta
---

#### 用途

`saveta`命令扫描ab文件里面所有`TextAsset`资源对象并保存到当前cd目录的`__textassets`目录。该命令首先通过容器`AssetBundle::m_Container`尝试还原二进制文件的原始后缀，如果未找到任何匹配则使用`dat`作为文件后缀保存。

```c++
struct AssetBundle: public Object {
    std::string m_Name;  // 1
    std::vector<PPtr<struct Object>> m_PreloadTable;  // 2
    std::multimap<std::string,AssetInfo> m_Container;  // 3
    AssetInfo m_MainAsset;  // 4
    uint32_t m_RuntimeCompatibility;  // 5
    std::string m_AssetBundleName;  // 6
    std::vector<std::string> m_Dependencies;  // 7
    bool m_IsStreamedSceneAssetBundle;  // 8
    int32_t m_ExplicitDataLayout;  // 9
    int32_t m_PathFlags;  // 10
    std::map<std::string,std::string> m_SceneHashes;  // 11
};
```


#### 参数

|参数|缩写|描述|
|:-|:-:|:-|
|--output|-o|文件输出目录，默认：`__textassets`|

#### 示例

```
abtool saveta Android/dataconfig.god 
```

![](saveta/saveta.png)

