import 'dart:async';

class CommonUtils{
  static var timer;
  static  debounce(Function callback){
    if(timer==null){
      timer = Timer.periodic(Duration(milliseconds: 200), (timer){
        callback();
        timer.cancel();
      });
    }else{
    }
  }
}