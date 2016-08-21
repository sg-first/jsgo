var ocrDemo = {
    CANVAS_WIDTH: 200,
    TRANSLATED_WIDTH: 20,
    PIXEL_WIDTH: 10, // TRANSLATED_WIDTH = CANVAS_WIDTH / PIXEL_WIDTH
    BATCH_SIZE: 1,

    //和Py联系通信时候用
    PORT: "9000",
    HOST: "http://localhost",

    BLACK: "#000000",
    BLUE: "#0000ff",

    // 客户端给的训练集
    trainArray: [],
    trainingRequestCount: 0,

    onLoadFunction: function() {
        this.resetCanvas();
    }
}