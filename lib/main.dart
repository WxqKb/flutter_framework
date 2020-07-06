import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/utils/providers_util.dart';
import 'package:provider/provider.dart';

import 'view/loginView.dart';

void main() {
  runZoned(() {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      Zone.current.handleUncaughtError(details.exception, details.stack);
      return Center(
        child: Text('出错啦'),
      );
    };
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
      Zone.current.handleUncaughtError(details.exception, details.stack);
    };
//  开启布局线
    debugPaintSizeEnabled = !true;
    runApp(MyApp());
  }, onError: (Object obj, StackTrace stack) {
//    上传错误日志
    print(obj);
    print(stack);
  });
}

class MyApp extends StatelessWidget {
  //statusBar设置为透明，去除半透明遮罩
  final SystemUiOverlayStyle _style = SystemUiOverlayStyle(statusBarColor: Colors.transparent);

  @override
  Widget build(BuildContext context) {
    //将style设置到app
    SystemChrome.setSystemUIOverlayStyle(_style);
    return MultiProvider(
        providers: ProviderUtil.providersUtil,
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              accentColor: Color(0xff00b4ed),
              primaryColor: Color(0xff00b4ed), // 主题色
            ),
            // 相当于Vue中的beforeEnter路由拦截
//            onGenerateRoute: (RouteSettings setting){
//              final Function pageContentBuilder = Routers.router[setting.name];
//              if(pageContentBuilder==null){
//                return MaterialPageRoute(builder: (BuildContext context) {
//                  return Scaffold(
//                    body: Center(
//                      child: Text("Page not found"),
//                    ));
//                });
//              }else{
//                return MaterialPageRoute(builder: (context) => Routers.router[setting.name](context, argument: setting.arguments));
//              }
//            },
            home: LoginPage(arguments: {'title': '登录'})));
  }
}
