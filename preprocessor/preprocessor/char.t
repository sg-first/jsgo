function deleteSpace(str)
    var isSpace=false
    var isQuotes=false
    var newstr=""
    var length=字符串长度(str)
    
    for(var i = 0; i <= length; i++)
        var char=字符串截取左侧(str,1)
        
        if(isQuotes) //前一个字符是引号
            
            if(char=="\"")//是反引号,出状态
                isQuotes=false
			end
            //无论是否是反引号,都拼接
            str=字符串移除(str,1,true)
            newstr=字符串拼接(newstr,char)
			continue
            
        else
            
			if(char=="\"") //前一个不是引号就先检查这个是否是引号
				isQuotes=true
				str=字符串移除(str,1,true)
                newstr=字符串拼接(newstr,char)
				continue
			end
            
            //确认跟引号没关系了才检查空格
            if(char==" ")
                if(isSpace) //要是前一个是空格这个就忽略
                    str=字符串移除(str,1,true)
                    continue
                end
                isSpace=true
                str=字符串移除(str,1,true)
                newstr=字符串拼接(newstr,char)
				continue
            end
            
            //和空格引号都没关系,直接拼接即可
            isSpace=false
            str=字符串移除(str,1,true)
            newstr=字符串拼接(newstr,char)
            
        end
	end
	return newstr
end