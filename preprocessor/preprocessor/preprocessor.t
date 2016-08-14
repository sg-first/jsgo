var path
var code

function PRequire(str)
    str=deleteSpace(str)
    str=1
end

功能 preprocessor_初始化()
    path=系统获取工作路径()
	var codefile=文件打开(字符串拼接(path,"main.js"))
    
    if(codefile<=0)
        messagebox("没有找到main.js","jsgo Preprocessor")
    end
    
	//Pass1
	循环(!文件是否结尾(codefile))
		PRequire(文件读一行(codefile))
	结束
    
结束
