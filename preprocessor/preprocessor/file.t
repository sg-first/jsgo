function writeCode(code,filepath)
    文件删除(filepath)
    var hand=文件创建(filepath,"rw")
    文件写入字符(hand,code)
    文件关闭(hand)
end