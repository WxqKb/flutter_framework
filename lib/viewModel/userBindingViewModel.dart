import 'package:flutter/material.dart';
import '../model/common_model.dart';
import '../services/request_service.dart';

/**
 * File : userBindingViewModel
 * tips :
 * @author : karl.wei
 * @date : 2020-05-17 23:00
 **/

class UserBindingViewModel with ChangeNotifier {
  Map<String, dynamic> _states = {'loading': false, 'title': '欢迎绑定'};

  void setValue(key, value) {
    _states[key] = value;
    notifyListeners();
  }

  get states => _states;

  goBinding() {
    _states['loading'] = true;
    notifyListeners();
    var params = Map<String, String>();
    params['mobile'] = '13417066166';
    params['code'] = '8888';
    RequestManagement.internal().toLogin(params, (CommentModel m) {
      if (m.code == 0) {
        new Future.delayed(new Duration(seconds: 4), () {
          _states['title'] = '绑定成功';
          _states['loading'] = false;
          notifyListeners();
        });
      } else {}
    }, (err) {
      new Future.delayed(new Duration(seconds: 4), () {
        _states['loading'] = false;
        notifyListeners();
      });
    });
  }
}
