function output(context)
{
    document.write(context+"<br/>");
}

function getPath()
{
    var lcal= location.href;
    var ary=lcal.split("/");
    lcal="";
    for(var i=3;i<ary.length-1;i++)
    {lcal+=ary[i]+"/";}
    return lcal;
}

function outpic(path)
{
	document.write("<body><img src='"+path+"'></body>"+"<br/>");
}

function wrap(path)
{
	document.write("<br/>");
}

function msgbox(context)
{
	alert(context);
}

function conbox(context)
{
    return confirm(context);
}

function input(inform)
{
	return prompt(inform);
}

function exitPage()
{
	window.close();
}