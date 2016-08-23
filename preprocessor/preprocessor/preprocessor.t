﻿var path
var makepath
var inipath
var isCopy
var requireList
var isExternal
var isHide
var useJsgo
var usePIO

var isError

function mainExit()
    exit()
end

function output(str)
    if(!isHide)
        str=字符串拼接(str,"\r\n")
        编辑框设置文本("处理输出",字符串拼接(编辑框获取文本("处理输出"),str))
    end
end

function mistake(str)
    if(!isHide)
        str=字符串拼接("-----error: ",str)
        output(字符串拼接(str,"-----"))
        isError=true
    end
end


function prepro(str,newcode)
    str=deleteComment(str)
    str=deleteSpace(str)
    var codepath
    
    if (字符串查找(str,"#require ")!=-1) //确认这句是require语句
        字符串分割(str,"#require ",codepath)
        if(codepath[0]!="")
            mistake("无法识别的#require语句")
        end
        var newfilecode=PCodeFile(codepath[1]) //处理被require的代码文本
        if(isError)
            return
        end
        if(isCopy)
            output("添加引用代码到原代码文本")
            newfilecode=retplus(newfilecode)
            return 字符串拼接(newcode,newfilecode)
        else
            output("添加引用代码到引用表")
            数组追加元素(requireList,codepath[1])
            writeCode(newfilecode,字符串拼接(makepath,codepath[1]))
            return newcode
        end
    end
    
    if (字符串查找(str,"#define ")!=-1) //确认这句是define语句
        字符串分割(str,"#define ",codepath)
        if(codepath[0]!="")
            mistake("无法识别的#define语句")
        end
        字符串分割(codepath[1]," ",codepath)
        var defineName=codepath[0]
        var defineVal=codepath[1]
        
        if(defineVal=="#read") //判定是否是读取
            var readPar=codepath[2]
            defineVal=judgeInput(readPar,defineName,true) //要么用户输入,要么保持原样
            output("读取文件")
            defineVal=readFile(defineVal)
        end
        
        defineVal=judgeInput(defineVal,defineName) //判定是否是输入
        output("展开宏")
        return 字符串替换(newcode,defineName,defineVal)
    end
    //不是require语句,直接接入即可
    str=retplus(str)
    return 字符串拼接(newcode,str)
end


function PCodeFile(codepath)
    output(字符串拼接("预处理文件",codepath))
    var newcode=""
    var code=文件读取内容(字符串拼接(path,codepath))
    var ary
    
    字符串分割(code,"\r\n",ary)
    for(var i = 0; i < 数组大小(ary); i++)
        newcode=prepro(ary[i],newcode)
        if(isError)
            return
        end
    end
    
    output(字符串拼接(codepath,"预处理完成"))
    return newcode
end


功能 preprocessor_初始化()
    path=系统获取工作路径()
    inipath=字符串拼接(path,"makefile.ini")
    isHide=readBoolINI("run","hide")
    if(isHide)
        运行热键_热键()
    end
结束


功能 运行热键_热键()
    output("-----start: 开始构建-----")
    isError=false
    output("创建构建文件夹")
    var name=文件读配置("project","name",inipath)
    makepath=字符串拼接(path,字符串拼接("build-",name))
    文件夹删除(makepath)
    文件夹创建(makepath)
    makepath=字符串拼接(makepath,"\\")
    output("确认require方式")
    if(文件读配置("build","isCopy",inipath)=="true")
        isCopy=true
        requireList=null
    else
        isCopy=false
        requireList=array()
    end
    output("确认是否外部读取宏体")
    defineNum=1 //注意,不是从零开始
    isExternal=readBoolINI("define","external")
    output("开始预处理代码")
    var maincode=PCodeFile("main.js")
    output("生成main.js")
    writeCode(maincode,字符串拼接(makepath,"main.js"))
    if(isError)
        return
    end
    //生成主页,如果配置选项里选择不生成主页,isCopy为false将无法运行
    useJsgo=readBoolINI("build","useJsgo")
    usePIO=readBoolINI("PIO","usePIO")
    if(文件读配置("build","generateIndex",inipath)=="true")
        output("生成主页")
        generateIndex(name)
    else
        output("拷贝主页")
        copyCode("index.htm")
    end
    output("拷贝资源")
    文件夹创建(字符串拼接(makepath,"res"))
    文件夹拷贝(字符串拼接(path,"res"),makepath)
    output("-----finish: 开始运行-----")
    if(!usePIO)
        命令(字符串拼接(makepath,"index.htm"),true)
        if(isHide)
            exit()
        end
    else
        run()
        if(isHide)
            var mainhandl=窗口获取自我句柄()
            窗口隐藏(mainhandl)
        end
    end
结束


功能 预处理运行_点击()
    运行热键_热键()
结束
