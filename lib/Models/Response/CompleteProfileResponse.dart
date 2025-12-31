/// success : true
/// data : {"message":"Profile completed successfully","user":{"_id":"68ca771d063148eb5cc533b0","name":"nancy ","email":"nancykhaledn905@gmail.com","role":"Student","level":1,"department":"CS"}}

class CompleteProfileResponse {
  CompleteProfileResponse({
      this.success, 
      this.data,});

  CompleteProfileResponse.fromJson(dynamic json) {
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

/// message : "Profile completed successfully"
/// user : {"_id":"68ca771d063148eb5cc533b0","name":"nancy ","email":"nancykhaledn905@gmail.com","role":"Student","level":1,"department":"CS"}

class Data {
  Data({
      this.message, 
      this.user,});

  Data.fromJson(dynamic json) {
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? message;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}

/// _id : "68ca771d063148eb5cc533b0"
/// name : "nancy "
/// email : "nancykhaledn905@gmail.com"
/// role : "Student"
/// level : 1
/// department : "CS"

class User {
  User({
      this.id, 
      this.name, 
      this.email, 
      this.role, 
      this.level, 
      this.department,});

  User.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    level = json['level'];
    department = json['department'];
  }
  String? id;
  String? name;
  String? email;
  String? role;
  int? level;
  String? department;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['role'] = role;
    map['level'] = level;
    map['department'] = department;
    return map;
  }

}