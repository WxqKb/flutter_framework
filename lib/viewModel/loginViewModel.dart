/**
 * File : loginViewModel
 * tips :
 * @author : karl.wei
 * @date : 2020-05-23 20:06
 **/
import 'package:flutter/material.dart';
import '../router/routers.dart';
import '../utils/shared_cache.dart';
import '../utils/toast_util.dart';
import '../model/common_model.dart';
import '../services/request_service.dart';

class LoginViewModel extends ChangeNotifier{
  TextEditingController userNameController = new TextEditingController();
  TextEditingController pwdController = new TextEditingController();

  bool radioValue = false;
  bool loading = false;

  changeRadio(){
    radioValue =!radioValue;
    notifyListeners();
  }

  loginHandel(BuildContext context) {
    loading = true;
    notifyListeners();
    var params = Map<String, String>();
    params['mobile'] = userNameController.text;
    params['password'] = pwdController.text;
    RequestManagement.internal().toLogin(params, (CommentModel m) {
      if (m.code == 0) {
          loading = false;
          ToastUtils.shortShort(m.msg);
          if(radioValue){
            saveName(params['mobile']);
            savePassword(params['password']);
          }
          Routers.pushReplacement(context,'/home');
      } else {
        loading = false;
        ToastUtils.shortShort(m.msg);
      }
      notifyListeners();
    }, (err) {
        loading = false;
        notifyListeners();
    });
//    跳转页面
    Routers.pushReplacement(context,'/home');
  }
}