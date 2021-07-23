import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_framework/l10n/localization_intl.dart';
import 'package:flutter_framework/utils/common_util.dart';
import 'package:flutter_framework/view/main_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _lastPressBackKeyTime = 0;

  late PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: this._page);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = (MediaQuery.of(context).size.width - 88) / 4;
    return WillPopScope(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        //融合底部工具栏
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child: AppBar(),
        ),
        body: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              MainPage(),
              Center(
                child: Text('展示canvas画布样例'),
              ),
              Center(
                child: Text('调用微信开放平台能力'),
              ),
              Center(
                child: Text('我的界面'),
              ),
            ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          elevation: 0,
          tooltip: '拍照或图库', //长按提示
          backgroundColor: Theme.of(context).primaryColor, //背景颜色
          child: Icon(Icons.camera_alt, color: Colors.white),
        ),
        bottomNavigationBar: BottomAppBar(
          //底部工具栏
          color: Theme.of(context).primaryColor,
          shape: CircularNotchedRectangle(), //圆形缺口
          child: Container(
            height: 52.0,
            padding: EdgeInsets.only(top: 8.0),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 0.5,
                  color: MediaQuery.of(context).platformBrightness ==
                          Brightness.light
                      ? Color(0xFFEAF4F6)
                      : Color(0xFF313131),
                ),
              ),
            ),
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      _onNavigateButtonTap(0);
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Container(
                      width: buttonWidth,
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          Icon(Icons.home, size: 26.0, color: _getColor(0)),
                          Padding(
                            padding: EdgeInsets.only(top: 26.0),
                            child: Text(
                              '首页',
                              style: TextStyle(
                                  fontSize: 10.0, color: _getColor(0)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      _onNavigateButtonTap(1);
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Container(
                      width: buttonWidth,
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          Icon(Icons.margin, size: 26.0, color: _getColor(1)),
                          Padding(
                            padding: EdgeInsets.only(top: 26.0),
                            child: Text(
                              '画布',
                              style: TextStyle(
                                  fontSize: 10.0, color: _getColor(1)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 88),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      _onNavigateButtonTap(2);
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Container(
                      width: buttonWidth,
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          Icon(Icons.camera, size: 26.0, color: _getColor(2)),
                          Padding(
                            padding: EdgeInsets.only(top: 26.0),
                            child: Text(
                              '微信',
                              style: TextStyle(
                                  fontSize: 10.0, color: _getColor(2)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      _onNavigateButtonTap(3);
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Container(
                      width: buttonWidth,
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          Icon(Icons.person, size: 26.0, color: _getColor(3)),
                          Padding(
                            padding: EdgeInsets.only(top: 26.0),
                            child: Text(
                              '我的',
                              style: TextStyle(
                                  fontSize: 10.0, color: _getColor(3)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
      onWillPop: () async {
        int newTime = DateTime.now().millisecondsSinceEpoch;
        int result = newTime - _lastPressBackKeyTime;
        _lastPressBackKeyTime = newTime;
        if (result > 2000) {
          CommonUtils.showToast(
              AppLocalizations.of(context)!.pressAgainToClose);
        } else {
          SystemNavigator.pop();
        }
        return false;
      },
    );
  }

  void _onNavigateButtonTap(int value) {
    _pageController.animateToPage(
      value,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOutCirc,
    );
    setState(() {
      this._page = value;
    });
  }

  Color _getColor(int value) {
    return this._page == value ? Colors.white : Color(0xFF111111);
  }
}
