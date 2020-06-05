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

saveName(String userName) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("userName", userName);
}

savePassword(String pwd) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("password", pwd);
}

getPreferences(String key)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}
