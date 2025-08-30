/// success : true
/// data : {"message":"Login Successful","token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4YWY3NGIxNzc0OGY1OTY1MjUzMmY2YyIsIm5hbWUiOiJuYW5jeSAiLCJpYXQiOjE3NTYzMzA3OTcsImV4cCI6MTc1NjkzNTU5N30.x2U7SH1YpMxfvbTQV4YxFK9XYWS__lpMRawyE-56wFk"}

class LoginResponse {
  LoginResponse({
      this.success, 
      this.data,});

  LoginResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// message : "Login Successful"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4YWY3NGIxNzc0OGY1OTY1MjUzMmY2YyIsIm5hbWUiOiJuYW5jeSAiLCJpYXQiOjE3NTYzMzA3OTcsImV4cCI6MTc1NjkzNTU5N30.x2U7SH1YpMxfvbTQV4YxFK9XYWS__lpMRawyE-56wFk"

class Data {
  Data({
      this.message, 
      this.token,});

  Data.fromJson(dynamic json) {
    message = json['message'];
    token = json['token'];
  }
  String? message;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['token'] = token;
    return map;
  }

}