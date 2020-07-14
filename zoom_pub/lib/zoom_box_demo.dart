import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'zoom_controller.dart';

/// 可缩放/平移的容器

class ZoomBoxDemo extends StatefulWidget {
  Widget child;
  double width;
  double height;
  ZoomController controller;

  ZoomBoxDemo({Key key, @required this.child, this.width, this.height, this.controller}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ZoomBoxView();
  }
}

class _ZoomBoxView extends State<ZoomBoxDemo> with TickerProviderStateMixin {
  GlobalKey _key = new GlobalKey();

  AnimationController _scaleAnimController, _offsetAnimController;

  // 上次缩放变化数据
  ScaleUpdateDetails _latestScaleUpdateDetails;

  // 当前缩放值
  double _currentScale = 1.0;

  // 当前偏移值
  Offset _offset = Offset.zero;

  // 双击缩放的点击位置
  Offset _doubleTapPosition = Offset.zero;

  bool _isBig = false;
  double maxScale = 5.0; // child最大缩放变量
  double targetScale = 2.0;

  Duration _duration = Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    widget.controller.stream.listen((event) {
      _animationScale(1.0);
      _animationOffset(Offset.zero);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: widget.width == null ? double.infinity : widget.width,
      height: widget.height == null ? double.infinity : widget.height,
      child: Transform(
        key: _key,
        alignment: Alignment.center,
        transform: Matrix4.translationValues(_offset.dx, _offset.dy, 0)..scale(_currentScale),
        child: GestureDetector(
          onDoubleTap: _onDoubleTap,
          onScaleStart: _onScaleStart,
          onScaleUpdate: _onScaleUpdate,
          onScaleEnd: _onScaleEnd,
          child: widget.child,
        ),
      ),
    ));
  }

  @override
  void dispose() {
    _scaleAnimController?.dispose();
    _offsetAnimController?.dispose();
    super.dispose();
  }

  /// 处理双击
  _onDoubleTap() {
    if (_isBig) {
      _animationOffset(Offset.zero);
      _animationScale(1.0);
    } else {
      _animationScale(targetScale);
    }
  }

  /// 事件开始
  _onScaleStart(ScaleStartDetails details) {
    _scaleAnimController?.stop();
    _offsetAnimController?.stop();
  }

  /// 事件变化
  _onScaleUpdate(ScaleUpdateDetails details) {
    if (_latestScaleUpdateDetails == null) {
      _latestScaleUpdateDetails = details;
      return;
    }
    // 计算缩放比例
    double scaleIncrement = details.scale - _latestScaleUpdateDetails.scale;
    if (details.scale < 1.0 && _currentScale > 1.0) {
      scaleIncrement *= _currentScale;
    }
    if (_currentScale < 1.0 && scaleIncrement < 0) {
      scaleIncrement *= (_currentScale - 0.5);
    } else if (_currentScale > maxScale && scaleIncrement > 0) {
      scaleIncrement *= (2.0 - (_currentScale - maxScale));
    }
    double offsetXIncrement =
        (details.localFocalPoint.dx - _latestScaleUpdateDetails.localFocalPoint.dx) * _currentScale;
    double offsetYIncrement =
        (details.localFocalPoint.dy - _latestScaleUpdateDetails.localFocalPoint.dy) * _currentScale;

    setState(() {
      _currentScale += scaleIncrement;
      _isBig = _currentScale > 0;
    });
    // 计算偏移，使缩放中心在屏幕上的位置保持不变
    setState(() {
      _offset += Offset(offsetXIncrement, offsetYIncrement);
    });
    _latestScaleUpdateDetails = details;
  }

  /// 事件结束
  _onScaleEnd(ScaleEndDetails details) {
    RenderBox renderBox = _key.currentContext.findRenderObject();
    if (_currentScale < 1.0) {
      _animationScale(1.0);
    } else if (_currentScale > maxScale) {
      _animationScale(maxScale);
    }
    if (_currentScale <= 1.0) {
      // 偏移到初始状态
      _animationOffset(Offset.zero);
    } else {
      // 处理拖动超过边界的情况（自动回弹到边界）
      double realScale = _currentScale > maxScale ? maxScale : _currentScale;
      double targetOffsetX = _offset.dx, targetOffsetY = _offset.dy;
      // 处理 X 轴边界
      double scaleOffsetX = renderBox.size.width * (realScale - 1.0) / 2;
      if (scaleOffsetX <= 0) {
        targetOffsetX = 0;
      } else if (_offset.dx > scaleOffsetX) {
        targetOffsetX = scaleOffsetX;
      } else if (_offset.dx < -scaleOffsetX) {
        targetOffsetX = -scaleOffsetX;
      }
      // 处理 Y 轴边界
//      print(MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top);
      double scaleOffsetY = renderBox.size.height * (realScale - 1) / 2; // child与屏幕高度之差 / 2，得出最大最小偏移量；
      print('容器Y偏移>>>' + scaleOffsetY.toString());
//      double scaleOffsetY =
//          (renderBox.size.height * realScale - MediaQuery.of(context).size.height) / 2; // child与屏幕高度之差 / 2，得出最大最小偏移量；
      if (scaleOffsetY < 0) {
        targetOffsetY = 0;
      } else if (_offset.dy > scaleOffsetY) {
        targetOffsetY = scaleOffsetY;
      } else if (_offset.dy < -scaleOffsetY) {
        targetOffsetY = -scaleOffsetY;
      }
      if (_offset.dx != targetOffsetX || _offset.dy != targetOffsetY) {
        // 启动越界回弹
        _animationOffset(Offset(targetOffsetX, targetOffsetY));
      } else {
        // 处理 X 轴边界
        double duration = (_duration.inSeconds + _duration.inMilliseconds / 1000);
        Offset targetOffset = _offset + details.velocity.pixelsPerSecond * duration;
        targetOffsetX = targetOffset.dx;
        if (targetOffsetX > scaleOffsetX) {
          targetOffsetX = scaleOffsetX;
        } else if (targetOffsetX < -scaleOffsetX) {
          targetOffsetX = -scaleOffsetX;
        }
        // 处理 X 轴边界
        targetOffsetY = targetOffset.dy;
        if (targetOffsetY > scaleOffsetY) {
          targetOffsetY = scaleOffsetY;
        } else if (targetOffsetY < -scaleOffsetY) {
          targetOffsetY = -scaleOffsetY;
        }
        // 启动惯性滚动
        _animationOffset(Offset(targetOffsetX, targetOffsetY));
      }
    }
    _latestScaleUpdateDetails = null;
  }

  /// 执行缩放动画
  _animationScale(double targetScale) {
    _scaleAnimController?.dispose();
    _scaleAnimController = AnimationController(vsync: this, duration: _duration);
    Animation anim = Tween<double>(begin: _currentScale, end: targetScale).animate(_scaleAnimController);
    anim.addListener(() {
      _onScaleUpdate(ScaleUpdateDetails(
        focalPoint: _doubleTapPosition,
        localFocalPoint: _doubleTapPosition,
        scale: anim.value,
        horizontalScale: anim.value,
        verticalScale: anim.value,
      ));
    });
    anim.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _isBig = targetScale > 1.0;
        _onScaleEnd(ScaleEndDetails());
      }
    });
    _scaleAnimController.forward();
  }

  /// 执行偏移动画
  _animationOffset(Offset targetOffset) {
    _offsetAnimController?.dispose();
    _offsetAnimController = AnimationController(vsync: this, duration: _duration);
    Animation anim = _offsetAnimController.drive(Tween<Offset>(begin: _offset, end: targetOffset));
    anim.addListener(() {
      setState(() {
        _offset = anim.value;
      });
    });
    _offsetAnimController.forward();
  }
}
