/**
 * File : http
 * tips : 网络请求工具类
 * @author : karl.wei
 * @date : 2020-04-06 17:51
 **/

import 'package:dio/dio.dart';
import '../model/common_model.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import '../config/api.dart';
import 'toast_util.dart';

class HttpUtils {
  static Dio dio;

  ///  default options
  static const int CONNECT_TIMEOUT = 20000;
  static const int RECEIVE_TIMEOUT = 3000;

  ///   http request methods
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';

//  构造方法+单例模式
  HttpUtils() {
    if (dio == null) {
      dio = createInstance();
    }
  }

  /// 创建 dio 实例对象
  static Dio createInstance() {
    if (dio == null) {
      BaseOptions options = new BaseOptions(
          baseUrl: Api.REDIRECT_URL,
          connectTimeout: CONNECT_TIMEOUT,
          receiveTimeout: RECEIVE_TIMEOUT,
          headers: {
            'Content-Type': 'application/json',
          });
      dio = new Dio(options);
      dio.interceptors.add(InterceptorsWrapper(onRequest: (options) async {
        /// 请求拦截，加入token
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = prefs.getString("token");
        Map<String, String> headers = {"token": token};
        options.headers = headers;
        return options;
      }, onResponse: (Response response) {
        print("响应拦截");
        return response; // continue
      }));
//      , onError: (DioError e) {
//        print("错误之前");
//        // Do something with response error
//        return e; //continue
//      }
    }
    return dio;
  }

  /// 清空 dio 对象
  static clear() {
    dio = null;
  }

  /// 本身可直接调用request进行请求，但为了方便每个调用，编写两个中转函数
  void get(String url, Function callBack,
      {data, Function errorCallBack}) async {
    _request(url, callBack,
        method: GET, data: data, errorCallBack: errorCallBack);
  }

  void post(String url, Function callBack,
      {data, Function errorCallBack}) async {
    print('post url is: ' + await dio.options.baseUrl + url);
    _request(url, callBack,
        method: POST, data: data, errorCallBack: errorCallBack);
  }

  _request(String url, Function callBack,
      {String method, data, Function errorCallBack}) async {
    try {
      Response response;
      if (method == GET) {
        Options option = new Options(method: GET);
        response = await dio.get(url, queryParameters: data, options: option);
      } else {
        Options option = new Options(method: POST);
        response = await dio.post(url, data: data, options: option);
      }
      CommentModel commentModel = CommentModel.fromJson(response.data);
      if (commentModel.code == 401) {
        ToastUtils.shortShort('会话失效，请重新登录');
        return;
      }
      if (callBack != null) {
        callBack(commentModel);
      }
    } on DioError catch (e) {
      _handError(errorCallBack, e);
    }
  }

  /// error统一处理
  static void _handError(Function errorCallback, DioError e) {
    if (e != null) {
      print(" ------------- Error Msg ------------");
      if (errorCallback != null) {
        errorCallback(e);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        // It occurs when url is opened timeout.
        ToastUtils.shortShort("连接超时");
      } else if (e.type == DioErrorType.SEND_TIMEOUT) {
        // It occurs when url is sent timeout.
        ToastUtils.shortShort("请求超时");
      } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
        //It occurs when receiving timeout
        ToastUtils.shortShort("响应超时");
      } else if (e.type == DioErrorType.RESPONSE) {
        // When the server response, but with a incorrect status, such as 404, 503...
        ToastUtils.shortShort('无法访问服务器,请稍后再试');
      } else if (e.type == DioErrorType.CANCEL) {
        // When the request is cancelled, dio will throw a error with this type.
        ToastUtils.shortShort("请求取消");
      } else {
        //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
        ToastUtils.shortShort("未知错误");
      }
    }
    print("<net> errorMsg :" + e.message);
  }
}
