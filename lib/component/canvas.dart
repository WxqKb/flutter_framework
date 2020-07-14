import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';

/// 已弃用
class CostomWidget extends StatefulWidget {
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
  AnimationController _animationController, _animationScaleController;
  Animation _animation, _animationScale;

//  偏移变量
  double distanceX, distanceY; //  手势开始时，报错手势与child坐标的差值
  Offset realPosition = Offset(0, 0); //  child上一次的偏移值
  double dx = 0.0, dy = 0.0; // child真正偏移值

//  缩放变量
  double maxScale = 2; // child最大缩放变量
  double scaleLevel = 1; //  手势缩放倍数
  double initScale = 1; //  child真正缩放倍数

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ConstrainedBox(
        child: Center(
            child: Transform(
                key: _key,
                transform: Matrix4.identity()
                  ..translate(dx, dy)
                  ..scale(initScale * scaleLevel),
                child: GestureDetector(
                    // 手势只包裹着child
                    onScaleStart: _scaleStartHandle,
                    onScaleUpdate: _scaleUpdateHandle,
                    onScaleEnd: _scaleEndHandle,
                    child: widget.child))),
        constraints: new BoxConstraints.expand());
  }

//  手势开始事件
  _scaleStartHandle(ScaleStartDetails details) {
    _animationController?.stop();
    _animationScaleController?.stop();
//    手指按下时与图片原点的距离
    distanceX = details.localFocalPoint.dx - realPosition.dx;
    distanceY = details.localFocalPoint.dy - realPosition.dy;
  }

//  手势进行事件
  _scaleUpdateHandle(ScaleUpdateDetails details) {
    setState(() {
      dx = details.localFocalPoint.dx - distanceX * details.scale;
      dy = details.localFocalPoint.dy - distanceY * details.scale;
      scaleLevel = details.scale;
    });
  }

//  手势结束事件
  _scaleEndHandle(ScaleEndDetails details) {
//    加入防抖
    initScale = initScale * scaleLevel;
    scaleLevel = 1.0;
//    被缩小或者有偏移才需要恢复
    if (initScale < 1.0 ||
        initScale == 1.0 && (dx != realPosition.dy || dy != realPosition.dy)) {
//    记录init动画前的偏移量和缩放倍数
      _scaleMin();
    } else if (initScale > maxScale) {
      _scaleMax();
    } else {
//      Offset offset = checkXY(dx, dy, initScale);
//      setState(() {
//        dx = offset.dx;
//        dy = offset.dy;
//      });
      realPosition = Offset(dx, dy);
    }
  }

  _scaleMin() {
    double animationX = dx;
    double animationY = dy;
    double animationScale = 1 - initScale;
    double scale = initScale;
    _animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this)
          ..addListener(() {
            if (_animation.value != 1.0) {
              setState(() {
                dx = animationX * _animation.value;
                dy = animationY * _animation.value;
                initScale = scale + animationScale * (1 - _animation.value);
              });
            }
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationController.reset();
            }
          });
    _animation = Tween(begin: 1.0, end: 0.0).animate(_animationController);
    _animationController.forward();
    realPosition = Offset(0, 0);
  }

  _scaleMax() {
    realPosition = Offset(dx, dy);
    double animationScale = initScale;

    _animationScaleController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this)
          ..addListener(() {
            if (_animationScale.value != animationScale) {
              Offset offset = checkXY(
                  realPosition.dx * _animationScale.value / animationScale,
                  realPosition.dy * _animationScale.value / animationScale,
                  _animationScale.value);
              setState(() {
                initScale = _animationScale.value;
                dx = offset.dx;
                dy = offset.dy;
              });
            }
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationScaleController.reset();
              scaleLevel = 1.0;
              initScale = maxScale;
              realPosition = Offset(dx, dy);
            }
          });
    _animationScale = Tween(begin: initScale, end: maxScale)
        .animate(_animationScaleController);
    _animationScaleController.forward();
  }

  Offset checkXY(double x, double y, double animationScale) {
    RenderBox renderBox = _key.currentContext.findRenderObject();
    double childWidth = renderBox.size.width * animationScale;
    double childHeight = renderBox.size.height * animationScale;
    double incrementX = childWidth + x - MediaQuery.of(context).size.width;
    double incrementY = childHeight + y - MediaQuery.of(context).size.height;
    if (x > 0) {
      x = 0;
    }
    if (y > 0) {
      y = 0;
    }
    if (incrementX < 0) {
      x = x + incrementX.abs();
    }
    if (incrementY < 0) {
      y = y + incrementY.abs();
    }
    return Offset(x, y);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController?.dispose();
    _animationScaleController?.dispose();
  }
}
