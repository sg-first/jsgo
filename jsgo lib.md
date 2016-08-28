jsgo lib
=======

jsgo.js
----------
### Introduction
Some basic interaction function.

### Rely
nothing

### external
* `output(output context : string,line feed=true : bool) : undefine` Output a string.
* `getPath() : string` Get the program running path.
* `outpic(picture path : string) : undefine` Output a picture.
* `wrap() : undefine` Line feed.
* `msgbox(msgbox content : string) : undefine` Displays a message box
* `selbox(msgbox content : string) : bool` Displays a select box (yes or no) and return the choice of the user.
* `input(Prompt information : string) : string` Input box, return to user input.
* `exitPage() : undefine` Exit the program.

### jsgoPrivate
* `isEmpty(variables that wanna check, default value : typeof parameter1) : typeof parameter1` Check whether a variable is undefined, if undefined return parameter, otherwise returns itself. Used to implement to set the default parameters.

PIO.js
---------
### Introduction
Combined with the preprocessor, output the results to the external environment.

### Rely
* jsgo.js

### external
* `Pout(out context : string,line feed=false : bool,call output=true : bool) : undefine` Output content, after the program will be passed to the external environment. Be careful, use `\br` to line feed is invalid.
* `Pexit() : undefine` Pass all the output variables to the external environment.

### PIOPrivate
* `addText(container name: string,out context : string) : undefine` Add a string to the specified container. Be careful, use `\br` to line feed is invalid.

canvas.js
-----------
### Introduction
Simple encapsulation of canvas.

### Rely
* jsgo.js

### external
* `creatCanvas(canvas height : num,canvas width : num) : canvas context` Create a canvas in the current cursor position.
* `drawLine(canvas context : canvas context,starting point x : num,starting point y : num,end point x : num,end point y : num,line width : num) : undefine` Draw a line on the canvas.
