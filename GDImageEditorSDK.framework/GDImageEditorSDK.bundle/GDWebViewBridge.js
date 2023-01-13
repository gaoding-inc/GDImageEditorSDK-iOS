;(function() {

    var responseCallbacks = {};
    var messageHandler = {};
    var WEBVIEW_CALLBACK_HANDLE_NAME = "_WEBVIEW_CALLBACK_";
    var uniqueId = 1;

    // JS调用OC
    function callHandler(handlerName, data, responseCallback)
    {
        var callbackId = 'cb_' + handlerName + '_' + (uniqueId++) + '_' + new Date().getTime();
        responseCallbacks[callbackId] = responseCallback;
        window.webkit.messageHandlers.callHandler.postMessage({'handlerName' : handlerName, 'data' : data, 'callbackId' : callbackId});
    }

    // 注册方法到JS
    function registerHandler(handlerName, handler)
    {
        messageHandler[handlerName] = handler;
        window.webkit.messageHandlers.registerHandler.postMessage({'handlerName' : handlerName});
    }

    // OC调用JS后，JS异步回调
    function registerCallBack(handlerName, callbackId, requestData)
    {
        var handler = messageHandler[handlerName];
        var callback = function(responseData) {
            if (callbackId && callbackId !== 'null') {
                window.webkit.messageHandlers.callbackHandler.postMessage({'handlerName' : handlerName, 'data' : data, 'callbackId' : callbackId});
            }
        };
        if (handler) {
            handler(requestData, callback);
        };
    }
    
    function callerCallback(handlerName, callbackId, responseData)
    {
        var handler = responseCallbacks[callbackId];
        if (handler) {
            handler(responseData);
        };
        delete responseCallbacks[callbackId];
    }

    window.WebViewJavascriptBridge = {
        registerHandler: registerHandler,
        callHandler: callHandler,
        callerCallback : callerCallback,
        registerCallBack : registerCallBack,
    }
    
})();

