function writeCode(code,filepath)
    var hand=filecreate(filepath,"rw")
    filewrite(hand,code)
    fileclose(hand)
end

function copyCode(name)
    filecopy(strcat(path,name),strcat(makepath,name))
end

function generateIndex(projectname)
    var str="<html>\r\n<title>"
    str=strcat(str,projectname)
    str=strcat(str,"</title>\r\n<body>\r\n")
    if(usePIO)
        str=strcat(str,"<a id=\"PIO\" name=\"PIO\" href=\"_PIO\">PIO</a><br>\r\n")
        str=strcat(str,"<a id=\"PIOend\" name=\"PIOend\" href=\"_PIO\">PIOend</a><br>\r\n")
        copyCode("PIO.js")
        str=strcat(str,"<script language=\"JavaScript\" src=\"PIO.js\"></script>\r\n")
    end
    if(useJsgo)
        copyCode("jsgo.js")
        str=strcat(str,"<script language=\"JavaScript\" src=\"jsgo.js\"></script>\r\n")
    end
    if(requireList!=null)
        for(var i = 0; i < arraysize(requireList); i++)
            str=strcat(str,"<script language=\"JavaScript\" src=\"")
            str=strcat(str,requireList[i])
            str=strcat(str,"\"></script>\r\n")
        end
    end
    str=strcat(str,"<script language=\"JavaScript\" src=\"main.js\"></script>\r\n")
    str=strcat(str,"</body>\r\n</html>\r\n")
    var hand=filecreate(strcat(makepath,"index.htm"),"rw")
    filewrite(hand,str)
    fileclose(hand)
end

function readFile(filePath)
    var pa=strreplace(filePath,"Relative:\\",path)
    var con=filereadex(pa)
    return con
end

function readBoolINI(section,entry)
    if(filereadini(section,entry,inipath)=="true")
        return true
    else
        return false
    end
end