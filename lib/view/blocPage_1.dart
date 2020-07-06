/**
 * File : blocPage_1
 * tips :
 * @author : karl.wei
 * @date : 2020-07-06 17:06
 **/

import 'package:flutter/material.dart';
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
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
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
      body: new Center(
          child: StreamBuilder<int>(
              stream: bLoC.stream,
              initialData: bLoC.count,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                print('build');
                return Text('${snapshot.data}');
              })),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.navigate_next),
        onPressed: () => {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => BlocPage_2()))
        },
      ),
    );
  }
}
