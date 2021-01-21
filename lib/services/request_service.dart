import 'package:flutter_framework/config/apis.dart';
import 'package:flutter_framework/services/service_interface.dart';
import 'package:flutter_framework/utils/common_util.dart';
import 'package:flutter_framework/utils/http_util.dart';

class RequestService implements ServiceInterface {
  // 内部实例
  static RequestService _internal;

  // 工厂构造函数，以实现单例
  factory RequestService() {
    if (_internal == null) {
      _internal = new RequestService.internal();
    }
    return _internal;
  }

  // 命名构造函数，将返回类实例
  RequestService.internal();

  @override
  Future<T> toLogin<T>(Map<String, String> params) async {
    try {
      final res = await HttpUtils().post(Api.login, data: {});
      if (res.code == 0) {
        return null;
      } else if (res.code == 4001) {
        CommonUtils.showToast(res.msg);
        return null;
      }
      return null;
    } catch (e) {
      handleHttpError(e.toString());
      return null;
    }
  }

  void handleHttpError(String statusCode) {
    if (statusCode == null) return;
    if (statusCode == '500') {
      CommonUtils.showToast("服务器内部错误，无法完成请求");
    } else if (statusCode == '502') {
      CommonUtils.showToast("无效请求");
    } else if (statusCode == '404') {
      CommonUtils.showToast("资源不存在");
    } else if (statusCode == '400') {
      CommonUtils.showToast("客户端语法错误");
    } else {
      CommonUtils.showToast("未知错误");
    }
  }
}
