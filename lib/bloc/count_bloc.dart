import 'dart:async';

CountBLoC bLoC = new CountBLoC();

class CountBLoC {
  int _count = 0;
//  广播
  var _countController = StreamController<int>.broadcast();

  Stream<int> get stream => _countController.stream;
  int get count => _count;

//  增加方法
  increment() {
    _countController.sink.add(++_count);
  }

  dispose() {
    _countController.close();
  }
}
