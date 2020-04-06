class CommentModel {
  int code;
  String msg;
  int times;
  int userId;
  dynamic data;
  dynamic page;

  CommentModel(
      this.code, this.msg, this.data,  this.times, this.page,this.userId);

  CommentModel.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        msg = json['msg'],
        times = json['times'],
        data = json['data'],
        page = json['page'],
        userId = json['userId'];

  Map<String, dynamic> toJson() => {
    'code': code,
    'msg': msg,
    'times': times,
    'data': data,
    'page': page
  };
}
