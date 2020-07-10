import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/component/canvas.dart';
import 'package:flutter_app/component/zoom_box.dart';

class CustomPage extends StatefulWidget {
  @override
  _CustomView createState() => new _CustomView();
}

class _CustomView extends State<CustomPage> {
  StreamController<int> controller = new StreamController<int>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义组件'),
      ),
      body: ZoomBox(
        child: Image.asset('assets/ic_girl.png'),
        width: 350,
        height: 520,
        controller: controller,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.sink.add(1);
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.close();
  }
}
