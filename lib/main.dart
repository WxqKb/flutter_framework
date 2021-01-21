import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_framework/router/router_config.dart';
import 'package:flutter_framework/router/routes.dart';
import 'package:flutter_framework/theme/theme_dark.dart';
import 'package:flutter_framework/theme/theme_light.dart';
import 'package:flutter_framework/utils/provider_util.dart';
import 'package:flutter_framework/view/login_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'l10n/localization_intl.dart';

void main() {
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp() {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    RouterConfig.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        // 本地化的代理类
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizationsDelegate(),
      ],
      supportedLocales: [
        const Locale('en', 'US'), // 美国英语
        const Locale('zh', 'CN'), // 中文简体
        //其它Locales
      ],
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      navigatorKey: RouterConfig.navigatorState,
      onGenerateRoute: RouterConfig.router.generator,
      home: LoginPage(),
    );
  }
}
