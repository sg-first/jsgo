function require(path)
{
	document.write("<script language='javascript' src='"+path+"'></" + "script>")
}

function output(context)
{
	document.write(context+"<br/>");
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

function input(inform)
{
	return prompt(inform);
}

function exitPage()
{
	window.close();
}
