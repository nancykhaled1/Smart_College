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
      this.token,
      this.user,
  });

  Data.fromJson(dynamic json) {
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;

  }
  String? message;
  String? token;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['token'] = token;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}

/// id : "68b95562724c737a6de60b3c"
/// name : "nancy "
/// email : "nancykhaledn905@gmail.com"
/// role : "Student"

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.role,
    this.department,
    this.level
  });

  User.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    department = json['department'];
    level = json['level'];
  }
  String? id;
  String? name;
  String? email;
  String? role;
  int? level;
  String? department;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['role'] = role;
    map['level'] = level;
    map['department'] = department;
    return map;
  }

}