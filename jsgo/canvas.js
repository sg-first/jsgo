var canvas=
{
    isEmpty:function(par, val)
    {
        if (par===undefined)
        {return val;}
        return par;
    }
}

function creatCanvas(height,width)
{
    output("<canvas id=\"Canvas\" height="+height+"px width="+width+"px></canvas>")
    var canvas=document.getElementById('Canvas');
    var ctx=canvas.getContext('2d');
    return ctx;
}

function drawLine(cans,x,y,fx,fy,width)
{
    cans.lineWidth=canvas.isEmpty(width,1);
    cans.beginPath();
    cans.moveTo(x,y);
    cans.lineTo(fx,fy);
    cans.stroke();
}