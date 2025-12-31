/// success : true
/// data : {"exam":{"_id":"68d3df73e36996af7725097e","title":"Math Exam","doctorname":"Dr. Ahmed","level":3,"department":"CS","isPublished":true,"subject_name":"Algebra","startAt":"2025-09-30T08:00:00.000Z","endAt":"2025-09-30T10:00:00.000Z","durationMinutes":120,"createdAt":"2025-09-24T12:09:23.554Z","updatedAt":"2025-09-26T11:44:27.762Z","__v":0}}

class ExamDetailsResponse {
  ExamDetailsResponse({
      this.success, 
      this.data,});

  ExamDetailsResponse.fromJson(dynamic json) {
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

/// exam : {"_id":"68d3df73e36996af7725097e","title":"Math Exam","doctorname":"Dr. Ahmed","level":3,"department":"CS","isPublished":true,"subject_name":"Algebra","startAt":"2025-09-30T08:00:00.000Z","endAt":"2025-09-30T10:00:00.000Z","durationMinutes":120,"createdAt":"2025-09-24T12:09:23.554Z","updatedAt":"2025-09-26T11:44:27.762Z","__v":0}

class Data {
  Data({
      this.exam,});

  Data.fromJson(dynamic json) {
    exam = json['exam'] != null ? Exam.fromJson(json['exam']) : null;
  }
  Exam? exam;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (exam != null) {
      map['exam'] = exam?.toJson();
    }
    return map;
  }

}

/// _id : "68d3df73e36996af7725097e"
/// title : "Math Exam"
/// doctorname : "Dr. Ahmed"
/// level : 3
/// department : "CS"
/// isPublished : true
/// subject_name : "Algebra"
/// startAt : "2025-09-30T08:00:00.000Z"
/// endAt : "2025-09-30T10:00:00.000Z"
/// durationMinutes : 120
/// createdAt : "2025-09-24T12:09:23.554Z"
/// updatedAt : "2025-09-26T11:44:27.762Z"
/// __v : 0

class Exam {
  Exam({
      this.id, 
      this.title, 
      this.doctorname, 
      this.level, 
      this.department, 
      this.isPublished, 
      this.subjectName, 
      this.startAt, 
      this.endAt, 
      this.durationMinutes, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Exam.fromJson(dynamic json) {
    id = json['_id'];
    title = json['title'];
    doctorname = json['doctorname'];
    level = json['level'];
    department = json['department'];
    isPublished = json['isPublished'];
    subjectName = json['subject_name'];
    startAt = json['startAt'];
    endAt = json['endAt'];
    durationMinutes = json['durationMinutes'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? title;
  String? doctorname;
  int? level;
  String? department;
  bool? isPublished;
  String? subjectName;
  String? startAt;
  String? endAt;
  int? durationMinutes;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['title'] = title;
    map['doctorname'] = doctorname;
    map['level'] = level;
    map['department'] = department;
    map['isPublished'] = isPublished;
    map['subject_name'] = subjectName;
    map['startAt'] = startAt;
    map['endAt'] = endAt;
    map['durationMinutes'] = durationMinutes;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}