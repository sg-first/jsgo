var path
var makepath
var isCopy
var requireList

function PRequire(str,newcode)
    str=deleteSpace(str)
    
    var codepath
    var len=字符串分割(str,"#require ",codepath)
    
    if (len!=1) //确认这句是require语句
        var newfilecode=PCodeFile(codepath[1]) //处理被require的代码文本
        if(isCopy)
            newcode=字符串拼接(newcode,newfilecode)
            return newcode
        else
            数组追加元素(requireList,codepath[1])
            writeCode(newfilecode,字符串拼接(makepath,codepath[1]))
            return newcode
        end
    end
    //不是require语句,直接接入即可
    return 字符串拼接(newcode,str)
end

function PCodeFile(codepath)
    var newcode=""
    var codefile=文件打开(字符串拼接(path,codepath))
    if(codefile<=0)
        messagebox("没有找到引用的文件","jsgo Preprocessor")
        exit()
    end
    
    //Pass1
    循环(!文件是否结尾(codefile))
        newcode=PRequire(文件读一行(codefile),newcode)
    结束
    文件关闭(codefile)
    
    return newcode
end

功能 preprocessor_初始化()
    path=系统获取工作路径()
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
    else
        isCopy=false
        requireList=array()
    end
    //预处理代码
    var maincode=PCodeFile("main.js")
    //写入生成完毕的js文件
    writeCode(maincode,字符串拼接(makepath,"main.js"))
    //生成主页
    
结束
