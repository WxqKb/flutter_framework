/**
 * File : loginView
 * tips :
 * @author : karl.wei
 * @date : 2020-05-20 23:42
 **/

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../viewModel/loginViewModel.dart';
import '../utils/communication_util.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.arguments}) : super(key: key);
  final Map arguments;

  @override
  _LoginView createState() => _LoginView();
}

class _LoginView extends State<LoginPage> {
  //全局 Key 用来获取 Form 表单组件
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  CommunicationUtil webSocket = new CommunicationUtil();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    webSocket.initTimer();
    webSocket.startTimer();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 720, height: 1280)..init(context);
    var loginVM = Provider.of<LoginViewModel>(context);
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: new SafeArea(
              child: new SingleChildScrollView(
                child: new Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: new Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Image.asset(
                        'assets/img_login_bg.png',
                        width: MediaQuery.of(context).size.width,
                      ),
                      new Padding(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
                        child: new Container(
                            width: ScreenUtil().setWidth(650),
                            height: ScreenUtil().setHeight(550),
                            decoration: new BoxDecoration(
                                color: Colors.white,
                                boxShadow: <BoxShadow>[
                                  new BoxShadow(
                                    color: const Color(0xffc9c9c9),
                                    offset: new Offset(0.0, 2.0),
                                    blurRadius: 4.0,
                                  ),
                                  new BoxShadow(
                                    color: const Color(0x80000000),
                                    offset: new Offset(0.0, 6.0),
                                    blurRadius: 20.0,
                                  ),
                                ],
                                borderRadius: BorderRadius.all(Radius.circular(15.0))),
                            child: new Stack(
                              alignment: AlignmentDirectional.topCenter,
                              overflow: Overflow.visible,
                              children: <Widget>[
                                new Positioned(
                                    top: -40,
                                    child: new Image.asset(
                                      'assets/img_login_logo.png',
                                      width: ScreenUtil().setWidth(150),
                                      height: ScreenUtil().setHeight(150),
                                    )),
                                new Form(
                                    //设置globalKey，用于后面获取FormState
                                    key: loginKey,
                                    //开启自动校验
                                    autovalidate: true,
                                    child: Column(children: <Widget>[
                                      new Padding(
                                          padding: EdgeInsets.only(top: 85),
                                          child: new Container(
                                              height: ScreenUtil().setHeight(85),
                                              width: ScreenUtil().setWidth(486),
                                              child: TextFormField(
                                                  controller: loginVM.userNameController,
                                                  decoration: InputDecoration(
                                                    hintText: "请输入用户名",
                                                    hintStyle:
                                                        TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(24)),
                                                    icon: Icon(Icons.person),
                                                  ),
                                                  validator: (value) {
                                                    return value.trim().length > 0 ? null : "必填选项";
                                                  }))),
                                      new Padding(
                                          padding: EdgeInsets.only(top: 25),
                                          child: new Container(
                                              height: ScreenUtil().setHeight(85),
                                              width: ScreenUtil().setWidth(486),
                                              child: TextFormField(
                                                  controller: loginVM.pwdController,
                                                  decoration: InputDecoration(
                                                    hintText: '你的登录密码',
                                                    hintStyle: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: ScreenUtil().setSp(24),
                                                    ),
                                                    icon: Icon(Icons.lock),
                                                  ),
                                                  //是否是密码
                                                  obscureText: true,
                                                  validator: (value) {
                                                    return value.length > 0 ? null : '必填选项';
                                                  })))
                                    ])),
                                new Positioned(
                                    bottom: 8,
                                    right: 30,
                                    child: new Row(
                                      children: <Widget>[
                                        new Checkbox(
                                          value: loginVM.radioValue,
                                          onChanged: (val) => loginVM.changeRadio(),
                                        ),
                                        new Text('记住密码',
                                            style: new TextStyle(
                                                color: loginVM.radioValue ? const Color(0xff00b4ed) : Colors.black,
                                                fontSize: ScreenUtil().setSp(24)))
                                      ],
                                    ))
                              ],
                            )),
                      ),
                      new Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: new Container(
                            height: ScreenUtil().setHeight(90),
                            width: ScreenUtil().setWidth(486),
                            child: new RaisedButton(
//                              匿名函数或者普通函数都可以，但是无需()，否则会执行
                              onPressed: (){
                                loginVM.loginHandel(context);
                              },
                              color: const Color(0xff00b4ed),
                              shape: StadiumBorder(),
                              child: new Text(
                                "登录",
                                style: new TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(32)),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
          inAsyncCall: loginVM.loading,
        ));
  }
}
