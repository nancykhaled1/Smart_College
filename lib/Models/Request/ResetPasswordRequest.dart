/// email : "nancykhaledn905@gmail.com"
/// code : "917450"

class ResetPasswordRequest {
  ResetPasswordRequest({
      this.email, 
      this.code,});

  ResetPasswordRequest.fromJson(dynamic json) {
    email = json['email'];
    code = json['code'];
  }
  String? email;
  String? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['code'] = code;
    return map;
  }

}