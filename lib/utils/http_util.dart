import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_framework/config/constants.dart';
import 'package:flutter_framework/model/base_model.dart';
import 'package:flutter_framework/router/router_config.dart';
import 'package:flutter_framework/utils/common_util.dart';
import 'package:flutter_framework/utils/navigator_util.dart';
import 'package:flutter_framework/utils/shared_preferences_util.dart';
import 'dart:async';

enum Method { get, post, put, patch, delete }

class HttpUtils {
  static Dio dio;

//  构造方法+单例模式
  HttpUtils() {
    if (dio == null) {
      dio = getInstance();
    }
  }

  /// 创建 dio 实例对象
  static Dio getInstance() {
    if (dio == null) {
      BaseOptions baseOptions = new BaseOptions(
        baseUrl: Constants.BASE_URL,
        connectTimeout: Constants.CONNECT_TIMEOUT,
        receiveTimeout: Constants.RECEIVE_TIMEOUT,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      dio = new Dio(baseOptions);
      dio.interceptors.add(
        InterceptorsWrapper(onRequest: (RequestOptions requestOptions) async {
          requestOptions.contentType = requestOptions.contentType ?? 'application/json';
          // 请求拦截，加入token
          String token = SpUtil.getString("token") ?? '';
          Map<String, String> headers = {"token": token};
          requestOptions.headers = headers;
          return requestOptions;
        }, onResponse: (Response response) {
          if (response?.statusCode == HttpStatus.unauthorized) {
            SpUtil.clear();
            // token失效时，重定向到登录页
            NavigatorUtils.push(RouterConfig.navigatorState.currentContext, '/enter/login', clearStack: true);
          }
          return response;
        }, onError: (DioError error) {
          if (error.response?.statusCode == HttpStatus.unauthorized || error.response?.statusCode == HttpStatus.forbidden) {
            SpUtil.clear();
          }
          return error; //continue
        }),
      );
    }

    return dio;
  }

  /// 清空 dio 对象
  static clear() {
    dio = null;
  }

  /// 这里其实可以直接调用request，但为了符合一般前端开发人员的使用习惯方便，故编写中转函数
  Future<BaseModel> get(String url, {data}) async {
    return _request(url, method: Method.get, data: data);
  }

  Future<BaseModel> post(String url, {data}) async {
    return _request(url, method: Method.post, data: data);
  }

  Future<BaseModel> put(String url, {data}) async {
    return _request(url, method: Method.post, data: data);
  }

  Future<BaseModel> patch(String url, {data}) async {
    return _request(url, method: Method.post, data: data);
  }

  Future<BaseModel> delete(String url, {data}) async {
    return _request(url, method: Method.post, data: data);
  }

  Future<BaseModel> _request(String url, {Method method, data}) async {
    try {
      Response response;
      switch (method) {
        case Method.get:
          {
            Options option = new Options(method: 'get');
            response = await dio.get(url, queryParameters: data, options: option);
            break;
          }
        case Method.post:
          {
            Options option = new Options(method: 'post');
            response = await dio.post(url, data: data, options: option);
            break;
          }
        case Method.put:
          {
            Options option = new Options(method: 'post');
            response = await dio.put(url, data: data, options: option);
            break;
          }
        case Method.patch:
          {
            Options option = new Options(method: 'patch');
            response = await dio.patch(url, data: data, options: option);
            break;
          }
        case Method.delete:
          {
            Options option = new Options(method: 'delete');
            response = await dio.delete(url, data: data, options: option);
            break;
          }
      }
      _printLog(response); // 打印返回Log，方便调试
      BaseModel commentModel = BaseModel.fromJson(response.data);
      if (commentModel.httpStatus == HttpStatus.ok) {
        if (commentModel.code == 401) {
          CommonUtils.showToast('会话失效，请重新登录');
          return null;
        } else {
          return commentModel;
        }
      } else {
        /// 完成通信，但HttpStatus错误，需要抛给业务层去解决
        throw commentModel.httpStatus;
      }
    } on DioError catch (e) {
      _handError(e);
      return null;
    }
  }

  /// 打印Http日志
  void _printLog(Response response) {
    if (Constants.isRelease) {
      return;
    }
    print('----------Http Log Start----------');
    try {
      print('[statusCode]: ${response.statusCode.toString()}');
      print('[request]: method = ${response.request.method}, baseUrl = ${response.request.baseUrl}, path: ${response.request.path}');
      print('[requestData]:${response.request.data.toString()}');
      print('[responseData]:${response.data.toString()}');
    } catch (ex) {
      print('Http log error: $ex');
    }
    print('----------Http Log End----------');
  }

  /// error统一处理
  static void _handError(DioError e) {
    if (e != null) {
      print(" ------------- Error Msg ------------" + e.toString());
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        CommonUtils.showToast("连接超时");
      } else if (e.type == DioErrorType.SEND_TIMEOUT) {
        CommonUtils.showToast("请求超时");
      } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
        CommonUtils.showToast("响应超时");
      } else if (e.type == DioErrorType.RESPONSE) {
        CommonUtils.showToast('无法访问服务器,请稍后再试');
      } else if (e.type == DioErrorType.CANCEL) {
        CommonUtils.showToast("请求取消");
      } else {
        CommonUtils.showToast("未知错误");
      }
    }
    print("<net> errorMsg :" + e.message);
  }
}
