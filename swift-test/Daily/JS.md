
DSWebview基本解析[https://juejin.cn/post/6844904142331183117]


# 传统的jsbridge依赖于 addScriptMessageHandler 和 didReceiveScriptMessage 相互回调 需要两个方法才可以获取到原生端的数据 麻烦
 也可以进行优化。前端调用  我们需要写中间件 将调用 写成id 然后存入字典 异步返回根据id获取到回调的函数 调用
 window.vbrowser.httpPost(data, function (result) {

}); 

js： 生成一个函数名，存下来，并且传递给iOS端供回调
原生调用 {'responseId': 'id',"response": "" }
实现异步调用调用

## 原生端调用js方法 也是一样 原生生成id 存入block 然后js调用方法返回id和返回值 

# dsbridge： 不依赖于  didReceiveScriptMessage 通过WKUIDelegate实现js与native通信
# dsbridge： 依赖 runJavaScriptTextInputPanelWithPrompt

### 优点： 同步函数 不需要 写异步方法可以直接获取到

### H5调用原生方法
依赖于 前端调用方法 prompt 和 runJavaScriptTextInputPanelWithPrompt

### 原生调用H5方法 evaluateJavaScript 


runtime获取到所有的方法 然后 js回调回去
