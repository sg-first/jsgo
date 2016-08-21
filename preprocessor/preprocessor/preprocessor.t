var path
var makepath
var isCopy
var requireList


function prepro(str,newcode)
    str=deleteComment(str)
    str=deleteSpace(str)
    
    if (字符串查找(str,"#require ")!=-1) //确认这句是require语句
        var codepath
        字符串分割(str,"#require ",codepath)
        var newfilecode=PCodeFile(codepath[1]) //处理被require的代码文本
        if(isCopy)
            newfilecode=retplus(newfilecode)
            return 字符串拼接(newcode,newfilecode)
        else
            数组追加元素(requireList,codepath[1])
            writeCode(newfilecode,字符串拼接(makepath,codepath[1]))
            return newcode
        end
    end
    
    if (字符串查找(str,"#define ")!=-1) //确认这句是define语句
        var codepath
        字符串分割(str,"#define ",codepath)
        字符串分割(codepath[1]," ",codepath)
        var defineName=codepath[0]
        var defineVal=codepath[1]
        if (defineVal=="#input") //检查是否是输入请求,处理一下
            defineVal=Input(defineName)
        end
        return 字符串替换(newcode,defineName,defineVal)
    end
    //不是require语句,直接接入即可
    str=retplus(str)
    return 字符串拼接(newcode,str)
end


function PCodeFile(codepath)
    var newcode=""
    var code=文件读取内容(字符串拼接(path,codepath))
    var ary
    
    字符串分割(code,"\r\n",ary)
    for(var i = 0; i < 数组大小(ary); i++)
        newcode=prepro(ary[i],newcode)
    end
    
    return newcode
end


功能 preprocessor_初始化()
    path=系统获取工作路径()
    
    运行热键_热键()
结束


功能 运行热键_热键()
    var inipath=字符串拼接(path,"makefile.ini")
    //创建构建文件夹
    var name=文件读配置("project","name",inipath)
    makepath=字符串拼接(path,字符串拼接("build-",name))
    文件夹删除(makepath)
    文件夹创建(makepath)
    makepath=字符串拼接(makepath,"\\")
    //确认require方式
    if(文件读配置("build","isCopy",inipath)=="true")
        isCopy=true
        requireList=null
    else
        isCopy=false
        requireList=array()
    end
    //预处理代码
    var maincode=PCodeFile("main.js")
    //写入生成完毕的js文件
    writeCode(maincode,字符串拼接(makepath,"main.js"))
    //生成主页
    if(文件读配置("build","useJsgo",inipath)=="true")
        generateIndex(name,true)
    else
        generateIndex(name,false)
    end
    //拷贝资源
    文件夹创建(字符串拼接(makepath,"res"))
    文件夹拷贝(字符串拼接(path,"res"),makepath)
    //打开网页
    if(文件读配置("build","runInPre",inipath)=="false")
        命令(字符串拼接(makepath,"index.htm"),true)
    else
        
    end
结束
