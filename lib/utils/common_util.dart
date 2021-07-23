import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CommonUtils {
  /// 格式化时间
  static String datetimeToString(DateTime dt, {String format = "yyyy-MM-dd HH:mm"}) {
    return DateFormat(format).format(dt);
  }

  /// 吐司提示
  static void showToast(String text, {gravity: ToastGravity.CENTER, toastLength: Toast.LENGTH_SHORT, backgroundColor: Colors.black45, textColor: Colors.white}) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: text,
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }

  /// 取消吐司提示
  static void cancelToast() {
    Fluttertoast.cancel();
  }

  /// 显示加载框
  static void showLoading(context, [String? text, Function? callBack]) {
    text = text ?? "正在加载中...";
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () {
            return null;
          } as Future<bool> Function()?,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).dialogTheme.backgroundColor,
                borderRadius: BorderRadius.circular(3.0),
                boxShadow: [
                  //阴影
                  BoxShadow(
                    color: Colors.black12,
                    //offset: Offset(2.0,2.0),
                    blurRadius: 10.0,
                  )
                ],
              ),
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.all(16.0),
              constraints: BoxConstraints(minHeight: 120.0, minWidth: 180.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 30.0,
                    width: 30.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 3.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      text!,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// 获取存储路径
  static Future<String> get localPath async {
    final directory = await getApplicationSupportDirectory();
    return directory.path;
  }

  /// 申请权限
  static Future<bool> checkLocationPermission(PermissionWithService permissionWithService) async {
    if (Platform.isAndroid) {
      final status = await permissionWithService.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.location.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }
}
