var path
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
        str=strcat(str,"\r\n")
        editsettext("处理输出",strcat(editgettext("处理输出"),str))
    end
end

function mistake(str)
    if(!isHide)
        str=strcat("-----error: ",str)
        output(strcat(str,"-----"))
        isError=true
    end
end


function prepro(str,newcode)
    str=deleteComment(str)
    str=deleteSpace(str)
    var codepath
    
    if (strfind(str,"#require ")!=-1) //确认这句是require语句
        strsplit(str,"#require ",codepath)
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
            return strcat(newcode,newfilecode)
        else
            output("添加引用代码到引用表")
            arraypush(requireList,codepath[1])
            writeCode(newfilecode,strcat(makepath,codepath[1]))
            return newcode
        end
    end
    
    if (strfind(str,"#define ")!=-1) //确认这句是define语句
        strsplit(str,"#define ",codepath)
        if(codepath[0]!="")
            mistake("无法识别的#define语句")
        end
        strsplit(codepath[1]," ",codepath)
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
        return strreplace(newcode,defineName,defineVal)
    end
    //不是require语句,直接接入即可
    str=retplus(str)
    return strcat(newcode,str)
end


function PCodeFile(codepath)
    output(strcat("预处理文件",codepath))
    var newcode=""
    var code=filereadex(strcat(path,codepath))
    var ary
    
    strsplit(code,"\r\n",ary)
    for(var i = 0; i < arraysize(ary); i++)
        newcode=prepro(ary[i],newcode)
        if(isError)
            return
        end
    end
    
    output(strcat(codepath,"预处理完成"))
    return newcode
end


function preprocessor_初始化()
    path=sysgetcurrentpath()
    inipath=strcat(path,"makefile.ini")
    isHide=readBoolINI("run","hide")
    if(isHide)
        运行热键_热键()
    end
end


function 运行热键_热键()
    output("-----start: 开始构建-----")
    isError=false
    output("创建构建文件夹")
    var name=filereadini("project","name",inipath)
    makepath=strcat(path,strcat("build-",name))
    folderdelete(makepath)
    foldercreate(makepath)
    makepath=strcat(makepath,"\\")
    output("确认require方式")
    if(filereadini("build","isCopy",inipath)=="true")
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
    writeCode(maincode,strcat(makepath,"main.js"))
    if(isError)
        return
    end
    //生成主页,如果配置选项里选择不生成主页,isCopy为false将无法运行
    useJsgo=readBoolINI("build","useJsgo")
    usePIO=readBoolINI("PIO","usePIO")
    if(filereadini("build","generateIndex",inipath)=="true")
        output("生成主页")
        generateIndex(name)
    else
        output("拷贝主页")
        copyCode("index.htm")
    end
    output("拷贝资源")
    foldercreate(strcat(makepath,"res"))
    foldercopy(strcat(path,"res"),makepath)
    output("-----finish: 开始运行-----")
    if(!usePIO)
        cmd(strcat(makepath,"index.htm"),true)
        if(isHide)
            exit()
        end
    else
        run()
        if(isHide)
            var mainhandl=windowgetmyhwnd()
            windowhide(mainhandl)
        end
    end
end


function 预处理运行_点击()
    运行热键_热键()
end
