class ValidationUtil {
  /// 手机号码
  static final RegExp _phoneRegex = RegExp(r'^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$');

  /// 邮箱
  static final RegExp _emailRegex = RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');

  /// 短信验证码，4位以上的整数
  static final RegExp _smsRegex = RegExp(r'^\d{4,}$');

  /// 中国身份证
  static final RegExp _idRegex = RegExp(r'\d{17}[\d|x]|\d{15}');

  static bool isValidPhone(String input) => _phoneRegex.hasMatch(input);

  static bool isValidEmail(String input) => _emailRegex.hasMatch(input);

  static bool isValidId(String input) => _idRegex.hasMatch(input);

  static bool isValidSms(String input) => _smsRegex.hasMatch(input);
}
