/**
 * File : communication_util
 * tips : 管理webSocket
 * @author : karl.wei
 * @date : 2020-06-27 12:27
 **/

import 'dart:convert';
import 'package:common_utils/common_utils.dart';

import '../events/logout_event.dart';
import '../config/constants.dart';
import 'websocket_util.dart';

class CommunicationUtil {
  static final CommunicationUtil _communicationUtil = new CommunicationUtil._internal();
  int count = 0;
  TimerUtil timerUtil;

//  初始化时启动webSocket连接
  CommunicationUtil._internal() {
    sockets.initWebSocket();
    sockets.addListener(_onGameDataReceived);
  }

//  工厂构造函数返回实例
  factory CommunicationUtil() {
    return _communicationUtil;
  }

  initTimer() {
//    5秒发送一次ping
    timerUtil = new TimerUtil(mInterval: 5000);
    timerUtil.setOnTimerTickCallback((int value) {
      print("'-----:>ping");
      sendHandle('ping', '123');
      count++;
      if (count > 3) {
//        三次没有接收到pong，需要重连并订阅
        sockets.removeAllListener();
        sockets.initWebSocket();
        sockets.addListener(_onGameDataReceived);
      }
    });
  }

  // timer controller
  startTimer() {
    timerUtil.startTimer();
  }

  cancelTimer() {
    timerUtil.cancel();
  }

  sendHandle(String action, String data) {
    sockets.sendMessage(json.encode({"method": action, "param": data}));
  }

  // 处理推送信息
  _onGameDataReceived(message) {
    if (message.toString() == "done") {
      return;
    }
    if (message.contains('pong')) {
      print('-----:>pong');
      count = 0;
      return;
    }
//    若是连接成功，取消定时器；若是连接失败，启动定时器
    try {
      var result = json.decode(message);
      if (result['result'] != null) {
        if (result['result'] == 'connected') {
//          业务开发一般会发送用户的token进行身份验证，请确保在connected后才发送
//         sendHandle("login", token));
          count = 0;
          return;
        }
      }
      print('-----result:>' + result.toString());
//      此处只是做实例，对返回信息进行处理，若code==1010，将触发退出登录事件，返回登录页
      switch(result['code']){
        case 1010:{
          Constants.eventBus.fire(new LogoutEvent(result['msg']));
          break;
        }
        case 1012:{
          break;
        }
        default:{

        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
