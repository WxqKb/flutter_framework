class LoginModel{
  String? userName;
  int? id;

  LoginModel.fromJson(Map<String, dynamic> json){
    userName = json.containsKey('user_name')?json['user_name']:null;
    id = json.containsKey('id')?json['id']:null;
  }
}