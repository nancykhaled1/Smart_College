/// success : false
/// error : {"code":401,"message":"Invalid email or password"}

class LoginError {
  LoginError({
      this.success, 
      this.error,});

  LoginError.fromJson(dynamic json) {
    success = json['success'];
    error = json['error'] != null ? LoginDetailsError.fromJson(json['error']) : null;
  }
  bool? success;
  LoginDetailsError? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (error != null) {
      map['error'] = error?.toJson();
    }
    return map;
  }

}

/// code : 401
/// message : "Invalid email or password"

class LoginDetailsError {
  LoginDetailsError({
      this.code, 
      this.message,});

  LoginDetailsError.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
  }
  int? code;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    return map;
  }

}