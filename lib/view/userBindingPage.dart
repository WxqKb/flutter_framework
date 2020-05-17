import 'package:flutter/material.dart';
import 'package:flutter_app/viewModel/userBindingViewModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../utils/toast.dart';

class UserBindingPage extends StatefulWidget {
  @override
  _UserBindingView createState() => _UserBindingView();
}

class _UserBindingView extends State<UserBindingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    ToastUtils.shortShort('123');
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)
      ..init(context);
    final viewModel = Provider.of<UserBindingViewModel>(context);
    // TODO: implement build
    return Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            backgroundColor: const Color(0xffFF7E5C),
            elevation: 0,
            title: Text(viewModel.states['title'],
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(34),
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            centerTitle: true,
          ),
          preferredSize: Size.fromHeight(35.0),
        ),
        body: ModalProgressHUD(
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                new Image.asset(
                  'assets/ic_binding.png',
                  width: ScreenUtil().setWidth(750),
                  fit: BoxFit.fill,
                ),
                new Center(
                  child: Container(
                    width: ScreenUtil().setWidth(667),
                    height: ScreenUtil().setHeight(630),
                    margin: EdgeInsets.only(top: 290),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(31)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x54C8C8C8),
                            offset: Offset(4.0, 3.0), // 1-右偏移，2-下偏移
                            blurRadius: 22.0, // 扩散
                            spreadRadius: 0.0,
                          )
                        ]),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 30)),
                        Center(
                          child: Image.asset(
                            'assets/ic_welcome.png',
                            width: ScreenUtil().setWidth(277),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new RaisedButton(
                              onPressed: () {
//                                viewModel.goBinding();
                                Provider.of<UserBindingViewModel>(context, listen: false).goBinding();
                              },
                              child: Text('绑定'),
                            )
                          ],
                        )
                      ],
                    ),
                    padding: const EdgeInsets.all(0.0),
                    alignment: Alignment.center,
                  ),
                )
              ],
            ),
          ),
          inAsyncCall: viewModel.states['loading'],
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
