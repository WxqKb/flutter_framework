import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';

class ZoomBox extends StatefulWidget {
  Widget child;
  double width;
  double height;
  StreamController<int> controller; // controller是一个stream

  ZoomBox({Key key, @required this.child, this.width, this.height, this.controller}) : super(key: key);

  @override
  ZoomBoxView createState() => new ZoomBoxView();
}

class ZoomBoxView extends State<ZoomBox> with TickerProviderStateMixin {
  GlobalKey _key = new GlobalKey();
  AnimationController _animationOffsetController, _animationScaleController;

  double dx = 0.0, dy = 0.0; // child真正偏移值
  double maxScale = 2; // child最大缩放变量
  double _currentScale = 1.0; //  child当前缩放倍数

//  ScaleUpdateDetails _latestScaleUpdateDetails; // 上次缩放变化数据
  double distanceX = 0.0, distanceY = 0.0, lastScale = 1.0;
  Offset realPosition = Offset(0, 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Stream<int> stream = widget.controller.stream;
    stream.listen((event) {
      _animationScale(1.0);
      _animationOffset(Offset.zero);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
          width: widget.width == null ? double.infinity : widget.width,
          height: widget.height == null ? double.infinity : widget.height,
          child: Transform(
              key: _key,
              transform: Matrix4.identity()
                ..translate(dx, dy)
                ..scale(_currentScale, _currentScale),
              child: GestureDetector(
                  // 手势只包裹着child
                  onScaleStart: _scaleStartHandle,
                  onScaleUpdate: _scaleUpdateHandle,
                  onScaleEnd: _scaleEndHandle,
                  child: widget.child))),
//      constraints: new BoxConstraints(
//          maxWidth: widget.width == null ? double.infinity : widget.width,
//          maxHeight: widget.height == null ? double.infinity : widget.height),
    );
  }

  //  手势开始
  _scaleStartHandle(ScaleStartDetails details) {
    _animationOffsetController?.stop();
    _animationScaleController?.stop();
    //  手指按下时与上次偏移后的距离
    distanceX = details.localFocalPoint.dx - realPosition.dx;
    distanceY = details.localFocalPoint.dy - realPosition.dy;
  }

  //  手势进行中
  _scaleUpdateHandle(ScaleUpdateDetails details) {
    setState(() {
      dx = details.localFocalPoint.dx - distanceX * details.scale;
      dy = details.localFocalPoint.dy - distanceY * details.scale;
      _currentScale = lastScale * details.scale;
    });
  }

  //  手势结束
  _scaleEndHandle(ScaleEndDetails details) {
    lastScale = _currentScale;
    realPosition = Offset(dx, dy);
    //  处理缩放
    if (_currentScale <= 1.0) {
      _animationScale(1.0); // 缩小需要恢复倍数为1.0
    } else if (_currentScale > maxScale) {
      _animationScale(maxScale); // 超出最大倍数，需要缩小为最大倍数
    }
    //  处理偏移
    if (_currentScale <= 1.0) {
      _animationOffset(Offset.zero); // 缩小需要恢复偏移量为0
    } else {
      // 其他需要视图是否没有充满屏幕，然后进行偏移
      RenderBox renderBox = _key.currentContext.findRenderObject();

      double realScale = _currentScale > maxScale ? maxScale : _currentScale;
      double targetOffsetX = dx, targetOffsetY = dy;
      //  计算 X/Y 轴边界
      double distanceX = targetOffsetX +
          renderBox.size.width * realScale -
          (widget.width == null ? MediaQuery.of(context).size.width : widget.width);
      //  Tips: renderOffset.dy表示child原始的Y值，无论如何操作，y值超过原始值就要回弹
      //  double distanceY = targetOffsetY + renderBox.size.height * realScale - (widget.height + renderOffset.dy);
      double distanceY = targetOffsetY +
          renderBox.size.height * realScale -
          (widget.height == null ? MediaQuery.of(context).size.height : widget.height);
      print('Y>>>' + distanceY.toString());
      if (targetOffsetX > 0) {
        targetOffsetX = 0;
      }
      if (targetOffsetX < 0 && distanceX < 0) {
        targetOffsetX = targetOffsetX + distanceX.abs();
      }
      if (targetOffsetY > 0) {
        targetOffsetY = 0;
      }
      if (targetOffsetY < 0 && distanceY < 0) {
        targetOffsetY = targetOffsetY + distanceY.abs();
      }
      _animationOffset(Offset(targetOffsetX * realScale / _currentScale, targetOffsetY * realScale / _currentScale));
    }
  }

  //  缩放动画
  _animationScale(double targetScale) {
    _animationScaleController?.dispose();
    double scale = _currentScale;
    Animation animation;
    _animationScaleController = AnimationController(duration: Duration(milliseconds: 300), vsync: this)
      ..addListener(() {
        setState(() {
          dx = realPosition.dx * animation.value / scale;
          dx = realPosition.dy * animation.value / scale;
          _currentScale = animation.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          lastScale = _currentScale;
        }
      });
    animation = Tween<double>(begin: lastScale, end: targetScale).animate(_animationScaleController);
    _animationScaleController.forward();
  }

  //  位移动画
  _animationOffset(Offset targetOffset) {
    _animationOffsetController?.dispose();
    Animation animation;
    _animationOffsetController = AnimationController(duration: Duration(milliseconds: 300), vsync: this)
      ..addListener(() {
        setState(() {
          dx = animation.value.dx;
          dy = animation.value.dy;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          realPosition = Offset(dx, dy);
        }
      });
    animation = Tween<Offset>(begin: Offset(dx, dy), end: targetOffset).animate(_animationOffsetController);
    _animationOffsetController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationOffsetController?.dispose();
    _animationScaleController?.dispose();
  }
}
