import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../model/state_model.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageView createState() => _FirstPageView();
}

class _FirstPageView extends State<FirstPage> {
  List _imgUrls = [
    'https://images.unsplash.com/photo-1551334787-21e6bd3ab135?w=640',
    'https://images.unsplash.com/photo-1551214012-84f95e060dee?w=640',
    'https://images.unsplash.com/photo-1551446591-142875a901a1?w=640'
  ];
  double appBarAlpha = 0;
  bool _loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _submit() {
    setState(() {
      _loading = true;
    });

    //Simulate a service call
    print('submitting to backend...');
    Provider.of<StateManagement>(context, listen: false).setValue('count','5');
    new Future.delayed(new Duration(seconds: 4), () {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: const Color(0xffFF7E5C),
          title: Text('订座',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(34),
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          centerTitle: true,
        ),
        preferredSize: Size.fromHeight(35.0),
      ),
      body: ModalProgressHUD(
          child: ListView(children: <Widget>[
            Container(
                height: ScreenUtil().setHeight(320),
                color: Colors.black12,
                child: Swiper(
                  itemCount: _imgUrls.length,
                  autoplay: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Image.network(
                      _imgUrls[index],
                      fit: BoxFit.fill,
                    );
                  },
                  pagination: SwiperPagination(builder: SwiperPagination.dots),
                )),
            Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            Row(
              textBaseline: TextBaseline.alphabetic,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(left: 15, right: 7),
                        child: Image.asset('assets/ic_home/ic_store.png',
                            width: ScreenUtil().setWidth(44),
                            height: ScreenUtil().setHeight(44))),
                    Container(
                        padding: EdgeInsets.only(right: 7),
                        width: ScreenUtil().setWidth(200),
                        child: Text(
                          '蔚来K书（中南店asdfdffsdaf）',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(28),
                              color: Colors.black),
                        )),
                    Image.asset(
                      'assets/ic_home/ic_down.png',
                      height: ScreenUtil().setHeight(10),
                      width: ScreenUtil().setWidth(18),
                    )
                  ],
                ),
                Container(
                    padding: EdgeInsets.only(right: 40),
                    child: Text(
                      '08:00 - 22:00',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(26),
                          color: const Color(0xff424753)),
                    ))
              ],
            ),
            Container(
                margin: EdgeInsets.only(top: 20, right: 20, left: 20),
                width: ScreenUtil().setWidth(660),
                height: ScreenUtil().setHeight(454),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x12202020),
                      offset: Offset(2.0, 4.0),
                      blurRadius: 6.0,
                      spreadRadius: 9.0,
                    )
                  ],
                )),
            Container(
                margin: EdgeInsets.fromLTRB(25, 30, 25, 13),
                width: ScreenUtil().setWidth(648),
                height: ScreenUtil().setHeight(80),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x30FF7E5C),
                        offset: Offset(0.0, 5.0), // 1-右偏移，2-下偏移
                        blurRadius: 8.0, // 扩散
                        spreadRadius: 6.0,
                      )
                    ]),
                child: RaisedButton(
                    onPressed: _submit,
                    color: const Color(0xffFF7E5C),
                    hoverColor: const Color(0xffd05f41),
                    textColor: Colors.white,
                    child: Text("下一步",
                        style: TextStyle(fontSize: ScreenUtil().setSp(28))))),
            Center(
              child: Text("订座规则",
                  style: TextStyle(
                      color: const Color(0xffAAB8CB),
                      fontSize: ScreenUtil().setSp(22),
                      decoration: TextDecoration.underline)),
            )
          ]),
          inAsyncCall: _loading),
    );
  }
}
