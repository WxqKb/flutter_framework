import 'package:flutter_framework/model/login_model.dart';

abstract class ServiceInterface {
  //  登录
  Future<LoginModel> toLogin(Map<String, String> params);
}
