var Dname
var Dval

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
