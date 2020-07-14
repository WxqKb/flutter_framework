import 'dart:async';

class ZoomController {
  StreamController controller = new StreamController();

  Stream get stream => controller.stream;

  ///  此处可传递model，但目前需求不需要。可参考eventBus
  fireEvent() {
    controller.sink.add(1);
  }

  closed() {
    controller?.close();
  }
}
