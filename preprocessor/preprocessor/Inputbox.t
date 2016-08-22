var Dname
var Dval

function judgeInput(defineVal,defineName,isPath=false) //看看参数是不是输入请求,如果是就处理一下
    if (defineVal=="#input")
        if(isPath)
            return Input(字符串拼接("path:",defineName))
        else
            return Input(defineName)
        end
    end
    return defineVal
end

function Input(dname)
    Dname=dname
    控件模态窗口("Inputbox") //阻塞
    return Dval
end

功能 确定_点击()
    Dval=编辑框获取文本("编辑框","Inputbox")
    控件关闭子窗口("Inputbox",0)
结束

功能 Inputbox_初始化()
    标签设置文本("宏名",Dname,"Inputbox")
结束

功能 确认定义_热键()
    确定_点击()
结束
