import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_framework/view/drawer/animation_page.dart';
import 'package:flutter_framework/view/home_page.dart';
import 'package:flutter_framework/view/login_page.dart';

Handler loginHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return LoginPage();
});

Handler homeHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return HomePage();
});

Handler animationHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AnimationPage();
});
