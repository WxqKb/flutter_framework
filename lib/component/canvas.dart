import 'dart:math';

import 'package:flutter/material.dart';

class CostomWidget extends StatefulWidget {
//  static BuildContext context;
  @required
  Widget child;

  double width;
  double height;
  CostomWidget({this.child, this.width, this.height});

  @override
  _CostomView createState() => new _CostomView();
}

class _CostomView extends State<CostomWidget> with TickerProviderStateMixin {
  GlobalKey _key = new GlobalKey();
  AnimationController _animationController;
  Animation _animation;
  double mediaWidth, mediaHeight;
  double dx = 0.0, dy = 0.0;

  double distance_x, distance_y;
  Offset realPosition = Offset(0, 0);

//  手势缩放倍数
  double scaleLevel = 1;
//  当前图片真正缩放倍数
  double initScale = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(duration: Duration(seconds: 2), vsync: this)
      ..addListener(() {
        print('123');
      })
      ..addStatusListener((status) {
        print('123');
      });
    _animation = Tween(begin: 0.0, end: 2.0 * pi).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    mediaWidth = MediaQuery.of(context).size.width;
    mediaHeight = MediaQuery.of(context).size.height;
    // TODO: implement build
    Widget current;
    current = ConstrainedBox(
        child: GestureDetector(
            onScaleStart: (details) {
              distance_x = details.localFocalPoint.dx - realPosition.dx;
              distance_y = details.localFocalPoint.dy - realPosition.dy;
            },
            onScaleUpdate: (details) {
              setState(() {
                scaleLevel = details.scale;
                dx = details.localFocalPoint.dx - distance_x;
                dy = details.localFocalPoint.dy - distance_y;
              });
            },
            onScaleEnd: (details) {
              initScale = initScale * scaleLevel;
              realPosition = Offset(dx, dy);
              RenderBox renderBox = _key.currentContext.findRenderObject();
              if (initScale <= 1) {
//                if (dx + renderBox.size.width > mediaWidth || dy + renderBox.size.height > mediaHeight) {
//                  print('超出边界啦');
//                }
              }
            },
            child: Center(
              child: Transform(
                  key: _key,
                  transform: Matrix4.translationValues(dx, dy, 0)..scale(initScale * scaleLevel),
                  child: widget.child),
            )),
        constraints: new BoxConstraints.expand());
    return current;
  }
}
