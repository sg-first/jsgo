jsgo preprocessor
==========
jsgo preprocessor added some commonly used but web js doesn’t provide, for example `#require` `#define` etc. And provides a wealth of building options, Enable it can generate the code that you want after pre-process.

How to use
----------------
Write code in main.js then start-up preprocessor，Press F4 or click”预处理运行”button，preprocessor will build the project in this directory (Must ensure that there is a makefile file in the directory) and run it right now.

New keywords
----------------
### #require
As others languages, You can refer to another JS file using the require keyword to current file.
```javascript
#require test.js
```
You can insert `require` into any location in the code. Be careful, when the `[build]isCopy` build options switch is not at the same time, the behavior of `require` is different.If `true`, the require code is directly inserted into the `require` statement as the C language. If `false`, All `require` files in the file will be unified, use HTML code to make it run before the JS file when generating the HTML interface. This indicates that the required file has been executed completed before the file is executed. Clearly, there is a difference in the order of execution between them.

### #define
define is a simple text replacement keyword.
```javascript
#define function fun
```
The code will replace all the fun to function, the location of “fun” is the parameter of `define` sentence(also called marco body). Be careful, It simply replaces the text, It doesn't pay attention to what is replaced. It’s a complete keyword? A part of a keyword or contents in quotation marks? `define` only acts to the code that previous this line. Be careful, when the `[build]isCopy` build options switch is not at the same time, the behavior of `define` is different. If `true`, all of the code that is required in the `define`'s scope of action. If `false`, `define` only acts on the current code file.

### #read
Because web js doesn’t have a simple method to operate local file, `read` uses macros to support read files in the preprocessing phase. Be careful, `read` must be used with `define`.
```javascript
#define FILE1 #read file.txt
```
The code will replace all of the previous FILE1 to the content in the file.txt file. the location of “file.txt” is the parameter of `read` sentence. Be careful, this parameter does not support the direct write relative path. If you need to use the relative path, you need to write path after the `Relative:\`.

### #input
`input` is the input keyword, When the scan to the pretreatment keyword, will pop up the input box for the developer to enter the keyword position should be filled with the content. This feature applies to macro body that need to frequent changes. `input` can be used as a parameter for any preprocessing statement, but it may not be used alone.
```javascript
#define function #input
```
Input content that “function” should be replaced when preprocessing phase.
```javascript
#define FILE1 #read #input
```
Input file name when preprocessing phase, then the content that “FILE1” will be replaced will be read from it.

`input` not only can be directly input by the input box, Can also batch definition in makefile. Open `[define]external` build options, and define all macro body below `external`.
```
1=fun
2=file.txt
```
Be careful, reading order is determined by the key word order. So You need a simple understanding of the processing sequence of the processor——When parsing a `require` statement, the content of be required will be parse. When the file of be required is parsed, processor will continue to parse the original file. So generally speaking, If `require` and `define` are placed at the top and end of the code file, Then the `define` in the code file that is required in the final, will be the first to be parsed.

PIO
--------
Because web js doesn’t have a simple method to operate local file, PIO provides a mechanism that  run the resulting output for jsgo preprocessor. After build options `[PIO] usePIO` open, the program will not run in the developer's browser. It runs at the preprocessor browser (preprocessor will pop up a child window) and monitoring the operating status. When the Pexit function be called, The processor reads the operating results that Developers output by Pout and generated to a file that build options `[PIO] outFile` correspond. At last Automatic start `[PIO] subProgram` corresponding executable file to analysis the results.

After opening PIO, the index that be generated will require PIO.js.

Build Options
-------------
### [project]
* name: Project name, It’s the title of index.

### [build]
* isCopy: require mode. `True` is copied to the place that require sentence.
* useJsgo: Use jsgo lib.`True` is jsgo.js will be the first require in HTML when generated index.
* generateIndex: preprocessor generated index, `true` is generated index, `false` is copied the `index.htm` in project directory to build folder, It will make the build options busting that have relationships with generated index.

### [run]
* hide: `true` for silent preprocessing, preprocessor will be automatically processed after it’s started, Shut down itself after treatment. Doesn’t pop the preprocessor window (Open PIO will pop up child run window).

### [define]
* external:` true` is read the macro body automatically in makefile. The last section has been described, doesn’t say too much about it here.

### [PIO]
* usePIO: `true` is opening PIO.
* outFile: The name of text that run the results output to, relative path.
* subProgram: Executable file name that be run after program running, relative path.
* width: run window width.
* height: run window height.

Pack
--------
If the program only needs one-time preprocessing. You can package build directory directly by WinRAR and other tools to EXE (If you don’t want to pop up the browser window. You can use [HTML application framework](https://github.com/sg-first/FSG/tree/master/TC5_HTML%E5%BA%94%E7%94%A8%E6%A1%86%E6%9E%B6/%E7%94%9F%E6%88%90)pack index.htm)

If the program needs to be processed dynamically or the output result in dynamic process is in run-time. Package needs to include preprocessor. You should delete the build directory and the result output file after the test finished, then open `[run]hide` build options (Doesn’t affect the input window pop up). And then directly package the entire project directory and set `jsgo preprocessor.exe` for entry.