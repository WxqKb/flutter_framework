import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';

var sockets = new WebSocketUtil();

class WebSocketUtil {
  static final WebSocketUtil _webSocketUtil = new WebSocketUtil._internal();
  bool _isConnect = false;
  late IOWebSocketChannel _channel;
  ObserverList<Function> _webSocketListeners = new ObserverList<Function>();
  WebSocketUtil._internal();

//  工厂构造函数，确保返回单例
  factory WebSocketUtil() {
    return _webSocketUtil;
  }

//  初始化webSocket
  void initWebSocket(String wsUrl) {
    closed();
    _channel = IOWebSocketChannel.connect(wsUrl);
    _channel.stream
        .listen(receptionMessage, onError: _onError, onDone: _onDone);
  }

//  关闭webSocket
  closed() {
    _channel.sink.close();
    _isConnect = false;
  }

//  加入订阅者
  addListener(Function callback) {
    _webSocketListeners.add(callback);
  }

//  删除订阅者
  removeListener(Function callback) {
    _webSocketListeners.remove(callback);
  }

//  删除所有订阅者
  removeAllListener() {
    try {
      for (int i = 0; i < _webSocketListeners.length; i++) {
        removeListener(_webSocketListeners.elementAt(i));
      }
    } catch (e) {
      print(e);
    }
  }

//  发送消息
  sendMessage(msg) {
    if (_isConnect) {
      _channel.sink.add(msg);
    }
  }

//  处理消息，将消息循环发送给订阅者
  receptionMessage(msg) {
    _isConnect = true;
    _webSocketListeners.forEach((Function callback) {
      callback(msg);
    });
  }

//  接收消息发生错误
  _onError(error, StackTrace stackTrace) {
    print(" ------- connect error -------");
    _webSocketListeners.forEach((Function callback) {
      try {
        callback(error, stackTrace);
        callback(error);
      } catch (e) {
        print(e);
      }
    });
  }

//  webSocket done
  _onDone() {
    print(" ------- done -------");
  }
}
