/**
 * File : state_model
 * tips : 状态管理数据
 * @author : karl.wei
 * @date : 2020-04-06 18:38
 **/

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class StateManagement with ChangeNotifier{
  int _count = 0;
  int get count => _count;

  void updateCount(count){
    _count =  count;
    notifyListeners();
  }
}