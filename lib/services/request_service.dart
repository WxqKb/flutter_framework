/**
 * File : request_service
 * tips : 网络请求实现类
 * @author : karl.wei
 * @date : 2020-04-06 18:06
 **/

import 'dart:async';
import 'dart:convert';
import 'package:dio/src/form_data.dart';

import '../config/api.dart';
import 'service_interface.dart';
import '../utils/http.dart';

class RequestManagement implements NetWorkApi{
//  工厂模式暴露一个对象
  factory RequestManagement() => _getInternal();
  static RequestManagement _internal;

  static RequestManagement _getInternal(){
    if(_internal == null){
      _internal = new RequestManagement.internal();
    }
  }
  RequestManagement.internal();

  @override
  Future<Null> toLogin(Map<String, String> params, Function callBack, Function errorCallback) async {
    // TODO: implement toLogin
    HttpUtils().post(Api.LOGIN, callBack,data: json.encode(params), errorCallBack: errorCallback);
  }
}