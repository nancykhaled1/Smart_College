/// success : false
/// error : {"code":400,"message":"No verification record found"}

class VerifyEmailError {
  VerifyEmailError({
      this.success, 
      this.error,});

  VerifyEmailError.fromJson(dynamic json) {
    success = json['success'];
    error = json['error'] != null ? VerifyError.fromJson(json['error']) : null;
  }
  bool? success;
  VerifyError? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (error != null) {
      map['error'] = error?.toJson();
    }
    return map;
  }

}

/// code : 400
/// message : "No verification record found"

class VerifyError {
  VerifyError({
      this.code, 
      this.message,});

  VerifyError.fromJson(dynamic json) {
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