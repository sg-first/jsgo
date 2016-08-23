var Dname
var Dval
var defineNum

function judgeInput(defineVal,defineName,isPath=false) //看看参数是不是输入请求,如果是就处理一下
    if (defineVal=="#input")
        if(isExternal)
            output("读取宏体")
            defineVal=filereadini("define",cstring(defineNum),inipath)
            defineNum=defineNum+1
            return defineVal
        else
            output("请输入宏体")
            if(isPath)
                return Input(strcat("path:",defineName))
            else
                return Input(defineName)
            end
        end
    end
    return defineVal
end

function Input(dname)
    Dname=dname
    controldomodal("Inputbox") //阻塞
    return Dval
end

function 确定_点击()
    Dval=editgettext("编辑框","Inputbox")
    controlclosewindow("Inputbox",0)
end

function Inputbox_初始化()
    staticsettext("宏名",Dname,"Inputbox")
end

function 确认定义_热键()
    确定_点击()
end
