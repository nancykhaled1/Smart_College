class RegisterError {
  bool? success;
  ErrorDetails? error;

  RegisterError({this.success, this.error});

  RegisterError.fromJson(dynamic json) {
    success = json['success'];
    error = json['error'] != null ? ErrorDetails.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (error != null) {
      map['error'] = error?.toJson();
    }
    return map;
  }
}

class ErrorDetails {
  int? code;
  String? message;
  dynamic details;

  ErrorDetails({this.code, this.message, this.details});

  ErrorDetails.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    map['details'] = details;
    return map;
  }
}
