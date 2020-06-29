/**
 * File : routers
 * tips :
 * @author : karl.wei
 * @date : 2020-06-05 22:11
 **/

import 'package:flutter/material.dart';
import 'package:flutter_app/view/homePage.dart';

import '../view/loginView.dart';
import '../view/homePage.dart';

class Routers {
//  所有页面路由静态Map
  static final Map<String, Function> router = {
    '/login': (BuildContext context, {Map argument}) => new LoginPage(arguments: argument),
    '/home': (BuildContext context, {Map argument}) => new HomePage(arguments: argument)
  };

//  进入页面通用方法
  static pushName(BuildContext context, String key, {Map params, callBack}) {
    print('router');
    Navigator.push(context, MaterialPageRoute(builder: (context) => router[key](context, argument: params)))
        .then((res) {
      if (callBack != null) {
        callBack(res);
      }
    });
  }

  static pushReplacement(BuildContext context, String key, {Map params, callBack}) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => router[key](context, argument: params)))
        .then((res) {
      if (callBack != null) {
        callBack(res);
      }
    });
  }

  static pushAndRemove(BuildContext context, String key, {Map params, callBack}) {
    Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) => router[key](context, argument: params)), (check) => false)
        .then((res) {
      if (callBack != null) {
        callBack(res);
      }
    });
  }
}
