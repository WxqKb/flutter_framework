import 'dart:async';

import 'package:flutter/material.dart';

import 'package:zoombox/zoom_box_demo.dart';
import 'package:zoombox/zoom_controller.dart';

class CustomPage extends StatefulWidget {
  @override
  _CustomView createState() => new _CustomView();
}

class _CustomView extends State<CustomPage> {
  ZoomController controller = new ZoomController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义组件'),
      ),
      body: ZoomBoxDemo(
        child: Image.asset('assets/ic_girl.png'),
        width: 350,
        height: 520,
        controller: controller,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.fireEvent();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.closed();
  }
}
