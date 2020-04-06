import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const APPBAR_SCROLL_OFFSET = 100;

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPage createState() => _ThirdPage();
}

class _ThirdPage extends State<ThirdPage> {
  List _imgUrls = [
    'https://images.unsplash.com/photo-1551334787-21e6bd3ab135?w=640',
    'https://images.unsplash.com/photo-1551214012-84f95e060dee?w=640',
    'https://images.unsplash.com/photo-1551446591-142875a901a1?w=640'
  ];
  double appBarAlpha = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _onScroll(offset) {
    print(offset);
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    // TODO: implement build
    return new Scaffold(
        body: Stack(
      children: <Widget>[
        MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: NotificationListener(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollUpdateNotification &&
                      scrollNotification.depth == 0) {
                    _onScroll(scrollNotification.metrics.pixels);
                  }
                },
                child: ListView(children: <Widget>[
                  Container(
                      height: 160,
                      child: Swiper(
                        itemCount: _imgUrls.length,
                        autoplay: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network(
                            _imgUrls[index],
                            fit: BoxFit.fill,
                          );
                        },
                        pagination: SwiperPagination(),
                      )),
                  Container(
                    height: 800,
                    child: Text("向上滑动看效果"),
                  )
                ]))),
        Opacity(
          child: Container(
            height: 80,
            decoration: BoxDecoration(color: const Color(0xffFF7E5C)),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text('订座',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(34),
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
          ),
          opacity: appBarAlpha,
        )
      ],
    ));
  }
}
