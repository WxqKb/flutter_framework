import 'package:flutter/material.dart';

class globalButton extends RaisedButton {
  @required
  VoidCallback onPress;
  String text = "";

  globalButton({this.onPress, this.text});

  @override
  Color get color => const Color(0xffFF7E5C);

  @override
  Color get textColor => Colors.white;
}
