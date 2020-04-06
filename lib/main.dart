import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/tabbarPage.dart';
import 'package:flutter/services.dart';

import 'view/userBindingPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  //statusBar设置为透明，去除半透明遮罩
  final SystemUiOverlayStyle _style =SystemUiOverlayStyle(statusBarColor: Colors.transparent);

  @override
  Widget build(BuildContext context) {
    //将style设置到app
    SystemChrome.setSystemUIOverlayStyle(_style);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Color(0xffffffff),
          primaryColorLight: Color(0xff0a0a0a),
          primaryColorDark: Color(0xff000000),
      ),
      home: UserBindingPage(),
    );
  }
}
