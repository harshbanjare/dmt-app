class BaseBean {
  BaseBean({
    this.status,
    this.msg,
  });

  BaseBean.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
  }

  bool? status;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    return map;
  }
}
