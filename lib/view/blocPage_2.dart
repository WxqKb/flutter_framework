import 'package:flutter/material.dart';
import '../bloc/count_bloc.dart';

class BlocPage_2 extends StatefulWidget {
  @override
  _BlocView createState() => new _BlocView();
}

class _BlocView extends State<BlocPage_2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 6.0,
        centerTitle: true,
        title: new Text(
          'BLoC_2',
        ),
      ),
      body: Center(
        child: StreamBuilder(
            stream: bLoC.stream,
            initialData: bLoC.count,
            builder: (context, snapshot) => Text(
                  "add: ${snapshot.data} ",
                )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => bLoC.increment(),
        child: Icon(Icons.add),
      ),
    );
  }
}
