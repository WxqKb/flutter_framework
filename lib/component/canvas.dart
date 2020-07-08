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
  AnimationController _animationController;
  Animation _animation;
  double dx = 0.0, dy = 0.0;

  Offset beforePinPosition = Offset(0, 0);
  Offset realPosition = Offset(0, 0);

//  手势缩放倍数
  double scaleLevel = 1;
//  当前图片真正缩放倍数
  double initScale = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this)
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
    // TODO: implement build
    Widget current;
    current = ConstrainedBox(
        child: GestureDetector(
            onScaleStart: (details) {
              print('开始缩放');
              print(details);
              beforePinPosition = details.localFocalPoint;
            },
            onScaleUpdate: (details) {
              print('缩放更新');
              print(details);
              print(details.scale);
              setState(() {
                scaleLevel = details.scale;
                dx = details.localFocalPoint.dx;
                dy = details.localFocalPoint.dy;
              });
            },
            onScaleEnd: (details) {
              print('缩放结束');
              print(details);
              initScale = initScale * scaleLevel;
            },
            child: Stack(
              children: <Widget>[
                Transform(
                    transform: Matrix4.translationValues(dx, dy, 0)
                      ..scale(initScale * scaleLevel),
//                      scale: initScale * scaleLevel,
                    child: widget.child),
//                ),
              ],
            )),
        constraints: new BoxConstraints.expand());
    return current;
  }
}
