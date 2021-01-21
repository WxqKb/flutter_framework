class BaseModel<T> {
  int httpStatus;
  int code;
  String msg;
  T data;

  BaseModel(this.httpStatus, this.code, this.msg, this.data);

  BaseModel.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        msg = json['msg'],
        data = json['data'];
}
