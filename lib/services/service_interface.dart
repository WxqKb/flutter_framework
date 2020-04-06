/**
 * File : service_interface
 * tips : 抽象接口，管理所有请求
 * @author : karl.wei
 * @date : 2020-04-06 18:04
 **/

import 'dart:async';
import 'package:dio/dio.dart';

abstract class NetWorkApi {
  //  登录
  Future<Null> toLogin(
      Map<String, String> params, Function callBack, Function errorCallback);
}