/// success : true
/// data : [{"_id":"68f76bb5ffcca80ce9c8fa43","level_number":1,"isActive":true,"__v":0},{"_id":"68f76bbeffcca80ce9c8fa46","level_number":2,"isActive":true,"__v":0},{"_id":"68f76bc0ffcca80ce9c8fa49","level_number":3,"isActive":true,"__v":0},{"_id":"68f76bc3ffcca80ce9c8fa4c","level_number":4,"isActive":true,"__v":0}]

class LevelResponse {
  LevelResponse({
      this.success, 
      this.data,});

  LevelResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DataLevel.fromJson(v));
      });
    }
  }
  bool? success;
  List<DataLevel>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "68f76bb5ffcca80ce9c8fa43"
/// level_number : 1
/// isActive : true
/// __v : 0

class DataLevel {
  DataLevel({
      this.id, 
      this.levelNumber, 
      this.isActive, 
      this.v,});

  DataLevel.fromJson(dynamic json) {
    id = json['_id'];
    levelNumber = json['level_number'];
    isActive = json['isActive'];
    v = json['__v'];
  }
  String? id;
  int? levelNumber;
  bool? isActive;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['level_number'] = levelNumber;
    map['isActive'] = isActive;
    map['__v'] = v;
    return map;
  }

}