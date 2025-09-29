/// success : true
/// data : {"attempt":{"exam":"68d3df73e36996af7725097e","student":"68ca7ac4604923e139462899","answers":[],"totalPoints":0,"correctCount":0,"wrongCount":0,"status":"in-progress","startedAt":"2025-09-28T23:26:23.859Z","endAt":"2025-09-29T01:26:23.859Z","_id":"68d9c41fc865b2cba60b13b3","createdAt":"2025-09-28T23:26:23.861Z","updatedAt":"2025-09-28T23:26:23.861Z","__v":0}}

class StartAttemptsResponse {
  StartAttemptsResponse({
      this.success, 
      this.data,});

  StartAttemptsResponse.fromJson(dynamic json) {
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

/// attempt : {"exam":"68d3df73e36996af7725097e","student":"68ca7ac4604923e139462899","answers":[],"totalPoints":0,"correctCount":0,"wrongCount":0,"status":"in-progress","startedAt":"2025-09-28T23:26:23.859Z","endAt":"2025-09-29T01:26:23.859Z","_id":"68d9c41fc865b2cba60b13b3","createdAt":"2025-09-28T23:26:23.861Z","updatedAt":"2025-09-28T23:26:23.861Z","__v":0}

class Data {
  Data({
      this.attempt,});

  Data.fromJson(dynamic json) {
    attempt = json['attempt'] != null ? Attempt.fromJson(json['attempt']) : null;
  }
  Attempt? attempt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (attempt != null) {
      map['attempt'] = attempt?.toJson();
    }
    return map;
  }

}

/// exam : "68d3df73e36996af7725097e"
/// student : "68ca7ac4604923e139462899"
/// answers : []
/// totalPoints : 0
/// correctCount : 0
/// wrongCount : 0
/// status : "in-progress"
/// startedAt : "2025-09-28T23:26:23.859Z"
/// endAt : "2025-09-29T01:26:23.859Z"
/// _id : "68d9c41fc865b2cba60b13b3"
/// createdAt : "2025-09-28T23:26:23.861Z"
/// updatedAt : "2025-09-28T23:26:23.861Z"
/// __v : 0

class Attempt {
  Attempt({
      this.exam, 
      this.student, 
      this.answers, 
      this.totalPoints, 
      this.correctCount, 
      this.wrongCount, 
      this.status, 
      this.startedAt, 
      this.endAt, 
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Attempt.fromJson(dynamic json) {
    exam = json['exam'];
    student = json['student'];
    answers = json['answers'] != null ? List<dynamic>.from(json['answers']) : [];
    totalPoints = json['totalPoints'];
    correctCount = json['correctCount'];
    wrongCount = json['wrongCount'];
    status = json['status'];
    startedAt = json['startedAt'];
    endAt = json['endAt'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? exam;
  String? student;
  List<dynamic>? answers;
  int? totalPoints;
  int? correctCount;
  int? wrongCount;
  String? status;
  String? startedAt;
  String? endAt;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['exam'] = exam;
    map['student'] = student;
    if (answers != null) {
      map['answers'] = answers?.map((v) => v.toJson()).toList();
    }
    map['totalPoints'] = totalPoints;
    map['correctCount'] = correctCount;
    map['wrongCount'] = wrongCount;
    map['status'] = status;
    map['startedAt'] = startedAt;
    map['endAt'] = endAt;
    map['_id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}