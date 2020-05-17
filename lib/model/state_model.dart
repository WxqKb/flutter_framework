/**
 * File : state_model
 * tips : 状态管理数据
 * @author : karl.wei
 * @date : 2020-04-06 18:38
 **/

import 'package:flutter/material.dart';

class StateManagement with ChangeNotifier {
  Map<String, dynamic> _states = {'count': '-1'};

  void setValue(key, value) {
    _states[key] = value;
    notifyListeners();
  }

  void clearStates() {
    _states = {};
  }

  get states => _states;
}
