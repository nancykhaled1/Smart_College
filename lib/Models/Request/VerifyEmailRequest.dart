/// userId : "68adee1e3181ce66687df373"
/// code : "311857"

class VerifyEmailRequest {
  VerifyEmailRequest({
      this.userId, 
      this.code,});

  VerifyEmailRequest.fromJson(dynamic json) {
    userId = json['userId'];
    code = json['code'];
  }
  String? userId;
  String? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['code'] = code;
    return map;
  }

}