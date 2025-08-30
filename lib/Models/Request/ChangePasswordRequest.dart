/// email : "hassanmohed590@gmail.com"
/// code : "327380"
/// newPassword : "123456"

class ChangePasswordRequest {
  ChangePasswordRequest({
      this.email, 
      this.code, 
      this.newPassword,});

  ChangePasswordRequest.fromJson(dynamic json) {
    email = json['email'];
    code = json['code'];
    newPassword = json['newPassword'];
  }
  String? email;
  String? code;
  String? newPassword;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['code'] = code;
    map['newPassword'] = newPassword;
    return map;
  }

}