import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_framework/router/router_config.dart';

///
/// 路由跳转工具类
/// 注意路径中的参数含有中文时，需要使用Uri.encodeComponent('中文')
///

class NavigatorUtils {
  static List<String> accessRoutes = ['/composition/aiComment'];

  //不需要页面返回值的跳转
  static push(BuildContext context, String path, {bool replace = false, bool clearStack = false}) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (accessRoutes.indexOf(path.split('?')[0]) != -1) {
      /// 需要验证的路由，获取用户信息进行验证
    }
    RouterConfig.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.native);
  }

  //需要页面返回值的跳转
  static pushResult(BuildContext context, String path, Function(Object) callBack, {bool replace = false, bool clearStack = false}) {
    FocusScope.of(context).requestFocus(new FocusNode());
    RouterConfig.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.native).then((result) {
      // 页面返回result为null
      if (result == null) {
        return;
      }
      callBack(result);
    }).catchError((error) {
      print("$error");
    });
  }

  /// 返回
  static void goBack(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
    Navigator.pop(context);
  }

  /// 带参数返回
  static void goBackWithParams(BuildContext context, result) {
    FocusScope.of(context).requestFocus(new FocusNode());
    Navigator.pop(context, result);
  }
}
