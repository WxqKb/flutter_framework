import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class RouterConfig{
  /// 全局context
  static GlobalKey<NavigatorState> navigatorState = new GlobalKey();
  // 全局路由对象
  static FluroRouter router;
}