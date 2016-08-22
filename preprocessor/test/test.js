#require test2.js
function startGame() {
	dia=next.d;
	bak=pos={fk:[],y:0,x:4,s:next.s};
	nextdia();
	document.getElementById("next").innerHTML=(next.d[next.s%next.d.length]|0x10000).toString(2).slice(-16).replace(/..../g,"$&<br/>").replace(/1/g,char.t).replace(/0/g,char.x);
	document.getElementById("text").innerHTML="SCORE:"+info.score+"<br/><br/>LINES:"+info.lines+"<br/><br/>SPEED:"+info.speed;
	rotate(0);
	run=setInterval("pause||down()",~~(Math.pow(1.3,12-info.speed)*30+20));
	var a=string(TEST2FILE);
	var b=string(TEST3FILE);
}

#define TEST2FILE #read Relative:\test2.js
#define TEST3FILE #read #input