/**
 * File : shared_cache
 * tips : 缓存工具类
 * @author : karl.wei
 * @date : 2020-04-06 17:51
 **/

import 'package:shared_preferences/shared_preferences.dart';

saveToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("token", token);
}

getPreferences(String key)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}