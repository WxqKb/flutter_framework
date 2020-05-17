import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/tabbarPage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/viewModel/userBindingViewModel.dart';
import 'package:provider/provider.dart';

import 'model/state_model.dart';
import 'view/userBindingPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //statusBar设置为透明，去除半透明遮罩
  final SystemUiOverlayStyle _style =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);

  @override
  Widget build(BuildContext context) {
    //将style设置到app
    SystemChrome.setSystemUIOverlayStyle(_style);
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => UserBindingViewModel())],
        child:
            Consumer<UserBindingViewModel>(builder: (context, stateManagement, _) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              accentColor: Color(0xffFF7E5C),
              primaryColor: Color(0xffffffff),
              primaryColorLight: Color(0xff0a0a0a),
              primaryColorDark: Color(0xff000000),
            ),
            home: UserBindingPage(),
          );
        }));
  }
}
