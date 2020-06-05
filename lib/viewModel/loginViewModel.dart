/**
 * File : loginViewModel
 * tips :
 * @author : karl.wei
 * @date : 2020-05-23 20:06
 **/
import
'package:flutter/material.dart';
import '../utils/shared_cache.dart';
import '../utils/toast.dart';
import '../model/common_model.dart';
import '../services/request_service.dart';

class LoginViewModel with ChangeNotifier{
  TextEditingController userNameController = new TextEditingController(text:getPreferences('userName'));
  TextEditingController pwdController = new TextEditingController(text:getPreferences('password'));

  bool radioValue = false;
  bool loading = false;

//  int radioGround = 0;

  changeRadio(){
    radioValue =!radioValue;
    notifyListeners();
  }

  loginHandel() {
    loading = true;
//    必须做
    notifyListeners();
    var params = Map<String, String>();
    params['mobile'] = userNameController.text;
    params['password'] = pwdController.text;
    RequestManagement.internal().toLogin(params, (CommentModel m) {
      if (m.code == 0) {
          loading = false;
          ToastUtils.shortShort(m.msg);
          notifyListeners();
          if(radioValue){
            saveName(params['mobile']);
            savePassword(params['password']);
          }
      } else {
        loading = false;
        notifyListeners();
        ToastUtils.shortShort(m.msg);
      }
    }, (err) {
        loading = false;
        notifyListeners();
    });
  }
}