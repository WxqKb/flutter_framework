import 'package:flutter/material.dart';
import 'package:flutter_framework/utils/common_util.dart';
import 'package:flutter_framework/utils/navigator_util.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  //  tabBar变量
  List<Tab> myTabs = <Tab>[Tab(text: "推荐"), Tab(text: "热榜"), Tab(text: "关注"), Tab(text: "开源推荐"), Tab(text: "面试资源")];
  TabController? mTabController;

  int? pageNum;

  @override
  void initState() {
    super.initState();
    mTabController = TabController(
      length: myTabs.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: new Drawer(
        elevation: 10.0,
        child: new ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(top: 64.5, bottom: 40.0),
              child: new Column(
                children: <Widget>[
                  new Image.asset("assets/icons/ic_title.png", width: 89.0, height: 89.0),
                  new Padding(padding: EdgeInsets.only(top: 10.0)),
                  new Text(
                    'Karl',
                    style: new TextStyle(fontWeight: FontWeight.w700, color: const Color(0xff111111), fontSize: 20),
                  ),
                  new Padding(padding: EdgeInsets.only(top: 8.0)),
                  new Text(
                    '13400000000',
                    style: new TextStyle(color: const Color(0x9f111111), fontSize: 16),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  pageNum = 1;
                });
                CommonUtils.showToast('正在建设...');
                Navigator.pop(context);
              },
              child: drawerUI(1, "嵌入高德地图", Icons.map),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  pageNum = 2;
                });
                Navigator.pop(context);
                NavigatorUtils.push(context, '/drawer/animation');
              },
              child: drawerUI(2, "酷炫动画实例", Icons.category),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  pageNum = 3;
                });
                CommonUtils.showToast('正在建设...');
                Navigator.pop(context);
              },
              child: drawerUI(3, "原生音频插件", Icons.volume_up_rounded),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  pageNum = 4;
                });
                CommonUtils.showToast('正在建设...');
                Navigator.pop(context);
              },
              child: drawerUI(4, "雷达图组件", Icons.memory),
            ),
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(38.0 + 46.0),
        child: AppBar(
          elevation: 6.0,
          centerTitle: true,
          title: new Text(
            '首页',
            style: Theme.of(context).textTheme.headline6,
          ),
          bottom: TabBar(
            tabs: myTabs,
            controller: mTabController,
            isScrollable: false,
            indicatorWeight: 4,
            labelPadding: EdgeInsets.only(left: 6.5, right: 6.5),
            unselectedLabelColor: Colors.black,
            labelColor: Theme.of(context).primaryColor,
            labelStyle: new TextStyle(fontWeight: FontWeight.w700),
            unselectedLabelStyle: new TextStyle(fontWeight: FontWeight.w500),
            indicatorColor: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: TabBarView(
        controller: mTabController,
        children: <Widget>[Center(child: Text("这是首页的内容")), Center(child: Text("这是热榜的内容")), Center(child: Text("这是关注的内容")), Center(child: Text("这是开源推荐的内容")), Center(child: Text("这是面试资源的内容"))],
      ),
    );
  }

  //  单个drawer通用布局
  Widget drawerUI(int i, String title, IconData iconData) {
    return Container(
      decoration: pageNum == i
          ? new BoxDecoration(
              image: new DecorationImage(image: new AssetImage('assets/icons/ic_menu_selected.png'), fit: BoxFit.fill // 填满
                  ))
          : new BoxDecoration(),
      height: 60,
      child: Row(children: <Widget>[
        Padding(
            padding: EdgeInsets.fromLTRB(30.0, 0.0, 20.0, 0.0),
            child: Icon(
              iconData,
              size: 24,
              color: pageNum == i ? Theme.of(context).primaryColor : Colors.black,
            )),
        new Text(
          title,
          style: new TextStyle(fontWeight: pageNum == i ? FontWeight.w900 : null, color: pageNum == i ? Theme.of(context).primaryColor : Colors.black, fontSize: 16.0),
        )
      ]),
    );
  }
}
