class Constants {
  /// 判断当前环境是否生产环境
  static const bool isRelease = bool.fromEnvironment('dart.vm.product', defaultValue: false);

  /// 网络请求配置
  static const String BASE_HOST = isRelease ? 'rm89zj.natappfree.cc/renren-fast' : 'rm89zj.natappfree.cc/renren-fast';
  static const String BASE_STATIC_HOST = isRelease ? 'https://www.wakeai.cn' : 'https://www.wakeai.cn';
  static const String BASE_URL = 'http://$BASE_HOST/app/';

  /// 网络超时配置
  static const int CONNECT_TIMEOUT = isRelease ? 1000 * 30 : 180 * 1000;
  static const int RECEIVE_TIMEOUT = isRelease ? 1000 * 30 : 180 * 1000;
}
