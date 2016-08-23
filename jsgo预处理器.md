jsgo 预处理器
==========
jsgo预处理器给js添加了一些常用但web js没有的关键字，如`#require` `#define`等。并提供了丰富的构建选项，使其在预处理后生成你想要的代码。

使用方式
----------------
在main.js中编写代码。打开预处理器，按下F4或点击“预处理运行”按钮，预处理器会构建预处理器目录所在的工程（必须确保有一个makefile文件）并立即运行它。

新关键字
----------------
### #require
像其它语言那样，使用require关键字你可以引用另一个js文件到目前的文件。
```javascript
#require test.js
```
你可以把`require`插入到代码的任何位置。要注意的是，当`[build]isCopy`构建选项开关不同时，`require`的行为不同。若为`true`，引用代码会像C语言那样被直接插入到`require`语句的位置。若为`false`，一个文件中的所有`require`文件会被统一记录，在生成HTML界面时使用HTML代码插入到该js文件前执行，也就是说，在该文件执行前，其引用的文件已经全部执行完毕。显然，他们之间存在代码执行顺序的差异。

### #define
define是简单的文本替换
```javascript
#define function fun
```
该代码会将之前所有的function替换为fun，fun的位置为`define`语句的参数（宏体）。注意，它单纯进行文本替换，不会注意被替换的是一个完整的关键字、另一个关键字的一部分或者引号内的内容。`define`的作用范围为该行之前的代码。要注意的是，当`[build]isCopy`构建选项开关不同时，`define`的行为不同。若为`true`，之前引用的所有代码都在`define`的作用范围内。若为`false`，`define`仅作用于当前代码文本。

### #read
由于依赖浏览器运行的js没有简单可用的本地文件操作，`read`使用宏的方式支持预处理期的文件读。注意，`read`必须和`define`配套使用
```javascript
#define FILE1 #read file.txt
```
该代码会将之前所有的FILE1替换为file.txt文件中的内容。file.txt的位置为`read`语句的参数。注意，这个参数不支持直接写相对路径。如果需要用相对路径，需要写在`Relative:\`之后

### #input
`input`是输入关键字，当扫描到这个预处理关键字时，会弹出输入框让开发者输入该关键字位置应该填充的内容。适用于需要频繁变化的宏体。`input`可以作为任何预处理语句的参数，但不得单独使用。
```javascript
#define function #input
```
预处理期输入function应该被替换为的内容
```javascript
#define FILE1 #read #input
```
预处理期输入FILE1被替换为的内容从哪个文件中读取

`input`不只可以通过输入框直接输入，还可以在makefile中批量定义。开启`[define]external`构建选项，并在`external`下面按定义所有的宏体
```
1=fun
2=file.txt
```
需要特别注意的是，读取顺序是按关键字解析先后顺序的。这里需要简单的了解预处理器的处理顺序——当解析到一个`require`语句时，会递归解析所`require`的代码文本的内容，当被`require`的文本解析完成后，才会继续向下解析原文本。所以一般来讲，如果`require`和`define`分别放在所处代码文本的最前和最后，那么最后被包含的代码文本中的`define`，将最先被解析。

PIO
--------
由于依赖浏览器运行的js没有简单可用的本地文件操作，PIO为jsgo预处理器提供的一套运行结果输出机制。构建选项`[PIO]usePIO`开启后，程序将不会在开发者的浏览器中运行，而是在预处理器的浏览器中运行（预处理器会弹出一个子窗口）并监控运行状态。当程序中Pexit函数被调用时，处理器读取开发者使用Pout输出的运行结果并生成到构建选项`[PIO]outFile`对应的文件，然后自动启动`[PIO]subProgram`对应的可执行文件进行结果分析工作。

开启PIO后，生成的主页中将引用PIO.js。

构建选项
-------------
### [project]
* name: 项目名，构建生成的主页标题

### [build]
* isCopy:` require`文本的包含方式。`true`为复制到原文本包含语句位置，`false`为在HTML中提前引用
* useJsgo: 使用jsgo lib。`true`为生成主页时jsgo.js会被最先在HTML中引用
* generateIndex: 预处理器生成主页，`true`为正常生成主页，`false`为复制工程目录下的`index.htm`到构建文件夹。如果关闭，会使得和主页生成有关的构建选项无效化

### [run]
* hide: `true`为静默预处理，也就是启动预处理器后会自动进行预处理，处理后关闭自身，不会弹出预处理器窗口（开启PIO时会弹出子运行窗口）

### [define]
* external:` true`为在makefile文件中自动读取宏体。上节已经叙述，不做过多说明

### [PIO]
* usePIO: `true`为开启PIO
* outFile: 运行结果输出到的文本名，为相对路径
* subProgram: 运行结果后进行结果分析的可执行文件名，为相对路径
* width:弹出的运行窗口宽
* height: 弹出的运行窗口高

打包
--------
如果程序只需要一次性预处理，可以直接将预处理器生成的构建目录使用winRAR等工具打包为exe文件（如果不希望弹出浏览器窗口运行，可以使用[HTML应用框架](https://github.com/sg-first/FSG/tree/master/TC5_HTML%E5%BA%94%E7%94%A8%E6%A1%86%E6%9E%B6/%E7%94%9F%E6%88%90)进行包装）

如果程序在运行期需要进行动态预处理或动态处理输出结果，需要连预处理器一起打包。应当在测试完毕后删除构建目录和结果输出文件，开启`[run]hide`构建选项（不影响input窗口的弹出）。然后直接打包整个工程目录并设定预处理器（`jsgo preprocessor.exe`为入口文件）。
