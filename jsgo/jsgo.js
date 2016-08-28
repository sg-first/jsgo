var jsgoPrivate=
{
    isEmpty:function(par, val)
    {
        if (par===undefined)
        {return val;}
        return par;
    }
}

function output(content,endl)
{
    enel=jsgoPrivate.isEmpty(endl,true);
    if(enel)
    {
        document.write(content+"<br/>");
    }
    else
    {
        document.write(content);
    }
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

function wrap()
{
	document.write("<br/>");
}

function msgbox(content)
{
	alert(content);
}

function selbox(content)
{
    return confirm(content);
}

function input(inform)
{
	return prompt(inform);
}

function exitPage()
{
	window.close();
}
