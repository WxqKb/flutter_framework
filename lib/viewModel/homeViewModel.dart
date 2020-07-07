/**
 * File : homeViewModel
 * tips :
 * @author : karl.wei
 * @date : 2020-06-29 22:54
 **/

import 'package:flutter/material.dart';
import '../router/routers.dart';
import '../utils/shared_cache.dart';
import '../utils/toast_util.dart';
import '../model/common_model.dart';
import '../services/request_service.dart';

class HomeViewModel extends ChangeNotifier {
  int pageNum = 0;

  clickDrawer(context, i) {
    pageNum = i;
    notifyListeners();
    Navigator.pop(context);
    switch (i) {
      case 3:
        {
          Routers.pushName(context, '/animation');
          break;
        }
      case 5:
        {
          Routers.pushName(context, '/blocDemo');
          break;
        }
    }
  }
}
