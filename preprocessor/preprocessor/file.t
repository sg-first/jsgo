function writeCode(code,filepath)
    文件删除(filepath)
    var hand=文件创建(filepath,"rw")
    文件写入字符(hand,code)
    文件关闭(hand)
end


function generateIndex(projectname,usejsgo)
    var str="<html>\r\n<title>"
    str=字符串拼接(str,projectname)
    str=字符串拼接(str,"</title>\r\n<body>\r\n")
    if(usejsgo)
        str=字符串拼接(str,"<script language=\"JavaScript\" src=\"jsgo.js\"></script>\r\n")
    end
    if(requireList!=null)
        for(var i = 0; i < 数组大小(requireList); i++)
            str=字符串拼接(str,"<script language=\"JavaScript\" src=\"")
			str=字符串拼接(str,requireList[i])
            str=字符串拼接(str,"\"></script>\r\n")
        end
    end
    str=字符串拼接(str,"<script language=\"JavaScript\" src=\"main.js\"></script>\r\n")
    str=字符串拼接(str,"</body>\r\n</html>\r\n")
    var hand=文件创建(字符串拼接(makepath,"index.htm"),"rw")
    文件写入字符(hand,str)
    文件关闭(hand)
end