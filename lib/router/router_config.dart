import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class RouterConfig{
  /// 全局context
  static GlobalKey<NavigatorState> navigatorState = new GlobalKey();
  static FluroRouter router;
}