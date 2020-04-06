import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'view/firstPage.dart';
import 'view/secondPage.dart';
import 'view/thirdPage.dart';

class TabPage extends StatefulWidget {
  TabPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TabView createState() => _TabView();
}

class _TabView extends State<TabPage> {
  PageController pageController;
  int page = 0;
  List<BottomNavigationBarItem> _tabbarList;

  initTabbar() {
    _tabbarList = [
      BottomNavigationBarItem(
          icon: new Image.asset(
            'assets/ic_home_noselect.png',
            height: ScreenUtil().setHeight(42),
            width: ScreenUtil().setWidth(44),
          ),
          activeIcon: new Image.asset(
            'assets/ic_home_select.png',
            height: ScreenUtil().setHeight(42),
            width: ScreenUtil().setWidth(44),
          ),
          title: new Text('订座')),
      BottomNavigationBarItem(
          icon: new Image.asset(
            'assets/ic_door_noselect.png',
            height: ScreenUtil().setHeight(42),
            width: ScreenUtil().setWidth(44),
          ),
          activeIcon: new Image.asset(
            'assets/ic_door_select.png',
            height: ScreenUtil().setHeight(42),
            width: ScreenUtil().setWidth(44),
          ),
          title: new Text('开门')),
      BottomNavigationBarItem(
          icon: new Image.asset('assets/ic_my_noselect.png',
              height: ScreenUtil().setHeight(42),
              width: ScreenUtil().setWidth(44)),
          activeIcon: new Image.asset('assets/ic_my_select.png',
              height: ScreenUtil().setHeight(42),
              width: ScreenUtil().setWidth(44)),
          title: new Text('我的'))
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = new PageController(initialPage: this.page);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    initTabbar();
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: new BottomNavigationBar(
        backgroundColor: Colors.white,
        items: _tabbarList,
        onTap: onClick,
        fixedColor: const Color(0xff000000),
        unselectedLabelStyle: TextStyle(
            fontSize: ScreenUtil().setSp(24), color: const Color(0xffCFD2DF)),
        currentIndex: page,
      ),
      body: new PageView(
        children: <Widget>[
          new FirstPage(),
          new SecondPage(),
          new ThirdPage()
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
    );
  }

  void onClick(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    print(page);
    setState(() {
      this.page = page;
    });
  }
}
