import 'package:flutter/material.dart';
import 'package:flutter_app/component/canvas.dart';

class CustomPage extends StatefulWidget {
  @override
  _CustomView createState() => new _CustomView();
}

class _CustomView extends State<CustomPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义组件'),
      ),
      body: CostomWidget(
        child: Image.asset('assets/animation/ic_avatar_4.png'),
      ),
    );
  }
}
