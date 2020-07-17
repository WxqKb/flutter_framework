/**
 * File : blocPage_1
 * tips :
 * @author : karl.wei
 * @date : 2020-07-06 17:06
 **/

import 'package:flutter/material.dart';
import 'package:pinch_zoom_image/pinch_zoom_image.dart';
import '../bloc/count_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'blocPage_2.dart';

class BlocPage_1 extends StatefulWidget {
  @override
  _BlocView createState() => new _BlocView();
}

class _BlocView extends State<BlocPage_1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      appBar: AppBar(
        elevation: 6.0,
        centerTitle: true,
        title: new Text(
          'BLoC_1',
        ),
      ),
      body: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(color: Colors.red),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              StreamBuilder<int>(
                  stream: bLoC.stream,
                  initialData: bLoC.count,
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                    print('build');
                    return Text(
                      '${snapshot.data}',
                      style: TextStyle(fontSize: 32, color: Colors.blueAccent),
                    );
                  }),
              Positioned(
                top: 80,
                left: 220,
                child: CustomPaint(
                  size: Size(300, 300),
                  painter: MyPaint(),
                ),
              ),
              PinchZoomImage(
                image: Image.network('https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1594896108361&di=09c612e75f9c1e78c0cc22563e84c59e&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1208%2F15%2Fc0%2F12924355_1344999165562.jpg'),
                zoomedBackgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
                hideStatusBarWhileZooming: true,
                onZoomStart: () {
                  print('Zoom started');
                },
                onZoomEnd: () {
                  print('Zoom finished');
                },
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.navigate_next),
        onPressed: () => {Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlocPage_2()))},
      ),
    );
  }
}

class MyPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const _angle = 3.1415926 / 180 * 3.6; // 1%的度数
    Paint _paint = new Paint()
      ..color = Colors.greenAccent
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(Offset.zero, 50, _paint);
    _paint.style = PaintingStyle.fill;
    Rect rect = Rect.fromCircle(center: Offset.zero, radius: 50.0);
    canvas.drawArc(rect, 0.0, -_angle * 61, true, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
