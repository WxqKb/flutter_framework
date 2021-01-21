abstract class ServiceInterface {
  //  登录
  Future<T> toLogin<T>(Map<String, String> params);
}
