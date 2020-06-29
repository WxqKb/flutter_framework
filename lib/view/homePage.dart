/**
 * File : homePage
 * tips :
 * @author : karl.wei
 * @date : 2020-06-27 15:58
 **/

import 'package:flutter/material.dart';
import 'package:flutter_app/viewModel/homeViewModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.arguments}) : super(key: key);
  final Map arguments;

  @override
  _HomeView createState() => _HomeView();
}

class _HomeView extends State<HomePage> with SingleTickerProviderStateMixin {
  //  tabBar变量\
  List<Tab> myTabs = <Tab>[Tab(text: "推荐"), Tab(text: "热榜"), Tab(text: "关注"), Tab(text: "开源推荐"), Tab(text: "面试资源")];
  var homeVM;
  TabController mTabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mTabController = TabController(
      length: myTabs.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    homeVM = Provider.of<HomeViewModel>(context);
    // TODO: implement build
    return Scaffold(
        backgroundColor: const Color(0xfff7f7f7),
        //  侧滑菜单
        drawer: new Drawer(
          elevation: 10.0,
          child: new ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              new Container(
                padding: EdgeInsets.only(top: 64.5, bottom:40.0),
                child: new Column(
                  children: <Widget>[
                    new Image.asset("assets/drawer/ic_title.png", width: 89.0, height: 89.0),
                    new Padding(padding: EdgeInsets.only(top: 10.0)),
                    new Text(
                      'Karl',
                      style: new TextStyle(fontWeight: FontWeight.w700, color: const Color(0xff111111), fontSize: 16),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 8.0)),
                    new Text(
                      '13400000000',
                      style: new TextStyle(color: const Color(0x9f111111), fontSize: 16),
                    ),
                  ],
                ),
              ),
              drawerUI(1, "高德地图", "assets/drawer/ic_todo_2.png", "assets/drawer/ic_todo.png"),
              drawerUI(2, "音频展示", "assets/drawer/ic_history_2.png", "assets/drawer/ic_history.png"),
              drawerUI(3, "动画实例", "assets/drawer/ic_notice_2.png", "assets/drawer/ic_notice.png"),
              drawerUI(4, "个人信息", "assets/drawer/ic_my_2.png", "assets/drawer/ic_my.png")
            ],
          ),
        ),
        appBar: new AppBar(
            elevation: 6.0,
            centerTitle: true,
            title: new Text(
              '首页',
            ),
            backgroundColor: Colors.white,
            bottom: TabBar(
              tabs: myTabs,
              controller: mTabController,
              isScrollable: false,
              indicatorWeight: 4,
              labelPadding: EdgeInsets.only(left: 6.5, right: 6.5),
              labelColor: const Color(0xff00b4ed),
              labelStyle: new TextStyle(fontWeight: FontWeight.w700),
              unselectedLabelStyle: new TextStyle(fontWeight: FontWeight.w500),
              indicatorColor: const Color(0xff00b4ed),
            )),
        body: TabBarView(
          controller: mTabController,
          children: <Widget>[
            Center(child: Text("这是推荐的内容")),
            Center(child: Text("这是热榜的内容")),
            Center(child: Text("这是关注的内容")),
            Center(child: Text("这是开源推荐的内容")),
            Center(child: Text("这是面试资源的内容"))
          ],
        ));
  }

  //  单个drawer通用布局
  Widget drawerUI(int i, String title, String selectImg, String sourceImg) {
    return new GestureDetector(
        onTap: () {
          homeVM.clickDrawer(context, i);
        },
        child: Container(
          decoration: homeVM.pageNum == i
              ? new BoxDecoration(
                  image: new DecorationImage(
                      image: new AssetImage('assets/drawer/ic_menu_selected.png'), fit: BoxFit.fill // 填满
                      ))
              : new BoxDecoration(),
          height: ScreenUtil().setHeight(120),
          child: new Row(children: <Widget>[
            new Padding(padding: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0)),
            new Image.asset(
              homeVM.pageNum == i ? selectImg : sourceImg,
              width: 20.0,
              height: 20.0,
            ),
            new Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0)),
            new Text(
              title,
              style: new TextStyle(
                  fontWeight: homeVM.pageNum == i ? FontWeight.w900 : null,
                  color: homeVM.pageNum == i ? const Color(0xff014282) : const Color(0xff333333),
                  fontSize: 16.0),
            )
          ]),
        ));
  }
}
