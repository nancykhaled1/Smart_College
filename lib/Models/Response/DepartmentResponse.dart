/// success : true
/// data : [{"_id":"68f7673fffcca80ce9c8fa31","name":"Our Visionsssddssssssssss","isActive":true,"__v":0},{"_id":"68f76792ffcca80ce9c8fa39","name":"sssssss","isActive":true,"__v":0},{"_id":"68f7679bffcca80ce9c8fa3c","name":"sssseee","isActive":true,"__v":0}]

class DepartmentResponse {
  DepartmentResponse({
      this.success, 
      this.data,});

  DepartmentResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DataDepartment.fromJson(v));
      });
    }
  }
  bool? success;
  List<DataDepartment>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "68f7673fffcca80ce9c8fa31"
/// name : "Our Visionsssddssssssssss"
/// isActive : true
/// __v : 0

class DataDepartment {
  DataDepartment({
      this.id, 
      this.name, 
      this.isActive, 
      this.v,});

  DataDepartment.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    isActive = json['isActive'];
    v = json['__v'];
  }
  String? id;
  String? name;
  bool? isActive;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['isActive'] = isActive;
    map['__v'] = v;
    return map;
  }

}