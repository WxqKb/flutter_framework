import 'dart:io';
import 'package:flutter/material.dart';

class DefaultBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    if (Platform.isAndroid || Platform.isFuchsia) {
      return child;
    } else {
      return super.buildOverscrollIndicator(
          context,
          child,
          ScrollableDetails(
              direction: axisDirection, controller: ScrollController()));
    }
  }
}
