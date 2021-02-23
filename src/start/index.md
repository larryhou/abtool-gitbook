```c++
void TestCodingCommand::test(std::shared_ptr<assetbundle::SerializedFile> file, ArchiveStream &source)
{
    std::fstream output;
    output.open("__test.pakdat", std::ios::out | std::ios::binary);
    
    ArchiveStream stream(&output, false);
    file->header.encode(stream);
    test(output, source);
    
    stream.little_endian = file->header.endianess == 0;
    
    stream.write_string(file->version);
    stream.write(file->platform);
    stream.write(file->type_tree_enabled);
    test(output, source);
    
    stream.write(static_cast<int32_t>(file->types.size()));
    test(output, source);
    for (auto iter = file->types.begin(); iter != file->types.end(); iter++)
    {
        iter->encode(stream);
        test(output, source);
    }
    
    stream.write(static_cast<int32_t>(file->objects.size()));
    test(output, source);
    for (auto iter = file->objects.begin(); iter != file->objects.end(); iter++)
    {
        stream.alignp();
        test(output, source);
        iter->encode(stream);
        test(output, source);
    }
    
    stream.write(static_cast<int32_t>(file->script_types.size()));
    test(output, source);
    for (auto iter = file->script_types.begin(); iter != file->script_types.end(); iter++)
    {
        iter->encode(stream);
        test(output, source);
    }
    
    stream.write(static_cast<int32_t>(file->externals.size()));
    test(output, source);
    for (auto iter = file->externals.begin(); iter != file->externals.end(); iter++)
    {
        iter->encode(stream);
        test(output, source);
    }
    
    stream.write_string(file->information);
    test(output, source);
    
    if (stream.tellp() < SerializedFile::kMetadataAllocation)
    {
        stream.write_alignment(SerializedFile::kMetadataAllocation - stream.tellp());
    }
    else
    {
        stream.alignp(16);
    }
    test(output, source);
}
```