function strIsSpace(str)
    var length=strlen(str)
    for(var i = 0; i <= length; i++)
        var char=strleft(str,1)
        if(char!=" ")
            return false
        end
        str=strcut(str,1,true)
    end
    return true
end


function retplus(str) //就是换行？
    if(str==""||strIsSpace(str))
        return ""
    else
        return strcat(str,"\r\n")
    end
end


function deleteSpace(str)
    var isSpace=false
    var isQuotes=false
    var newstr=""
    var length=strlen(str)
    
    for(var i = 0; i <= length; i++)
        var char=strleft(str,1)
        
        if(isQuotes) //前一个字符是引号
            
            if(char=="\"")//是反引号,出状态
                isQuotes=false
            end
            //无论是否是反引号,都拼接
            str=strcut(str,1,true)
            newstr=strcat(newstr,char)
            continue
            
        else
            
            if(char=="\"") //前一个不是引号就先检查这个是否是引号
                isQuotes=true
                str=strcut(str,1,true)
                newstr=strcat(newstr,char)
                continue
            end
            
            //确认跟引号没关系了才检查空格
            if(char==" ")
                if(isSpace) //要是前一个是空格这个就忽略
                    str=strcut(str,1,true)
                    continue
                end
                isSpace=true
                str=strcut(str,1,true)
                newstr=strcat(newstr,char)
                continue
            end
            
            //和空格引号都没关系,直接拼接即可
            isSpace=false
            str=strcut(str,1,true)
            newstr=strcat(newstr,char)
            
        end
    end
    return newstr
end


function findAndDelete(str,findcontext,front=true)
    var find=strfind(str,findcontext)
    if(find!=-1)
        if(front)
            return strleft(str,find)
        else
            return strright(str,strlen(str)-find-strlen(findcontext))
        end
    end
    return str
end


function deleteMulComment(str)
    var findL=strfind(str,"/*")
    if(findL!=-1)
        var commentL=strright(str,strlen(str)-findL-strlen("/*")) // /*右边的内容
        var str2="" //注释结束后的字符
        var findR=strfind(commentL,"*/")
        if(findR!=-1)  //存在就有后边，否则就前边一段
            str2=strright(commentL,strlen(commentL)-findR-strlen("*/"))  // */之后的内容
        end
        //处理完成，最后拼接
        var str1=strleft(str,findL)  //注释结束前的字符
        str=strcat(str1,str2)  //前后拼装
    end
    return str
end
