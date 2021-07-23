import 'package:flutter/material.dart';
import 'package:flutter_framework/component/default_behavior.dart';
import 'package:flutter_framework/utils/navigator_util.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: DefaultBehavior(),
        child: ListView(
          children: [
            new Image.asset(
              'assets/images/login_bg.png',
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 20),
              padding: EdgeInsets.fromLTRB(0, 30, 0, 50),
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
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              child: Column(
                children: [
                  new Image.asset(
                    'assets/images/logo.png',
                    width: 75,
                    height: 75,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 43,
                    width: 243,
                    child: TextFormField(
                        // controller: loginVM.userNameController,
                        decoration: InputDecoration(
                          hintText: "请输入用户名",
                          isDense: true,
                          icon: Icon(Icons.person, size: 20),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        validator: (value) {
                          return (value?.trim().length ?? 0) > 0
                              ? null
                              : "必填选项";
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 43,
                    width: 243,
                    child: TextFormField(
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: '请输入登录密码',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 14),
                          icon: Icon(Icons.lock, size: 20),
                        ),
                        //是否是密码
                        obscureText: true,
                        validator: (value) {
                          return (value?.length ?? 0) > 0 ? null : '必填选项';
                        }),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 80, left: 30, right: 30),
              height: 45,
              child: new ElevatedButton(
                onPressed: () {
                  NavigatorUtils.push(context, '/home', replace: true);
                },
                child: new Text(
                  "登录",
                  style: new TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
