var PIOPrivate=
{
    addText:function(element,str)
    {
        var a=document.getElementsByTagName("a");
        for(var i=0;i< a.length;i++)
        {
            if(a[i].innerHTML==element)
            {
                a[i].href=a[i].href+str;
            }
        }
    }
}

function Pout(str,endl,out)
{
    endl=jsgoPrivate.isEmpty(endl,false);
    out=jsgoPrivate.isEmpty(out,true);
    if(endl)
        PIOPrivate.addText("PIO",str+"_endl");
    else
        PIOPrivate.addText("PIO",str);
    if(out)
    {
        if(endl)
            output(str);
        else
            output(str,false);
    }
}

function Pexit()
{
    PIOPrivate.addText("PIOend","true");
}