var thread

function getHref(id)
    var ary
    id=strcat("id:",id)
    strsplit(webhtmlget("浏览器","href",id,"web"),"_PIO",ary)
    return ary[1]
end

function waitEnd()
    while(getHref("PIOend")!="true")
        sleep(100)
    end
    output("处理运行结果")
    var context=getHref("PIO")
    context=strreplace(context,"_endl","\r\n")
    output("写入结果")
    var outFile=filereadini("PIO","outFile",inipath)
    outFile=strcat(path,outFile)
    filedelete(outFile)
    writeCode(context,outFile)
    var subProgram=filereadini("PIO","subProgram",inipath)
    if(subProgram!="null")
        output("调用预制文件")
        openprocess(strcat(path,subProgram))
    end
    output("-----finish: 运行结束-----")
    
    if(isHide)
        mainExit()
    else
        controlclosewindow("web",0)
    end
end


function run()
    var width=cint(filereadini("PIO","width",inipath))
    var height=cint(filereadini("PIO","height",inipath))
    
    var handl=controlopenwindow("web")
    windowsetsize(handl,width,height)
    var webhandl=controlgethandle("浏览器","web")
    windowsetsize(webhandl,width,height)
    
    var winwidth,winheight
    sysgetscreen(winwidth,winheight)
    var x=(winwidth-width)/2
    var y=(winheight-height)/2
    windowsetpos(handl,x,y)
    
    output("-----start: 开始监视执行-----")
    webgo("浏览器",strcat(makepath,"index.htm"),"web")
    thread=threadbegin("waitEnd",null)
end

function web_销毁()
    threadclose(thread)
end
