/// success : true
/// data : {"exams":[{"_id":"68c7ff48e4e9b47d6a1f3bf0","title":"Math Examx","doctorname":"Dr. Ahmedxxxxxx","level":3,"department":"CS","isPublished":false,"subject_name":"Mathematics","startAt":"2025-09-20T00:00:00.000Z","endAt":"2025-09-29T00:00:00.000Z","durationMinutes":120,"createdAt":"2025-09-15T11:58:00.977Z","updatedAt":"2025-09-15T11:58:00.977Z","__v":0},{"_id":"68c8051872f53a0d4feb0a5c","title":"arabic Examx","doctorname":"Dr. Ahmedxxxxxx","level":3,"department":"CS","isPublished":true,"subject_name":"Mathematics","startAt":"2025-09-20T00:00:00.000Z","endAt":"2025-09-29T00:00:00.000Z","durationMinutes":120,"createdAt":"2025-09-15T12:22:48.423Z","updatedAt":"2025-09-15T12:29:08.466Z","__v":2}]}

class ExamsResponse {
  ExamsResponse({
      this.success, 
      this.data,});

  ExamsResponse.fromJson(dynamic json) {
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

/// exams : [{"_id":"68c7ff48e4e9b47d6a1f3bf0","title":"Math Examx","doctorname":"Dr. Ahmedxxxxxx","level":3,"department":"CS","isPublished":false,"subject_name":"Mathematics","startAt":"2025-09-20T00:00:00.000Z","endAt":"2025-09-29T00:00:00.000Z","durationMinutes":120,"createdAt":"2025-09-15T11:58:00.977Z","updatedAt":"2025-09-15T11:58:00.977Z","__v":0},{"_id":"68c8051872f53a0d4feb0a5c","title":"arabic Examx","doctorname":"Dr. Ahmedxxxxxx","level":3,"department":"CS","isPublished":true,"subject_name":"Mathematics","startAt":"2025-09-20T00:00:00.000Z","endAt":"2025-09-29T00:00:00.000Z","durationMinutes":120,"createdAt":"2025-09-15T12:22:48.423Z","updatedAt":"2025-09-15T12:29:08.466Z","__v":2}]

class Data {
  Data({
      this.exams,});

  Data.fromJson(dynamic json) {
    if (json['exams'] != null) {
      exams = [];
      json['exams'].forEach((v) {
        exams?.add(Exams.fromJson(v));
      });
    }
  }
  List<Exams>? exams;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (exams != null) {
      map['exams'] = exams?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "68c7ff48e4e9b47d6a1f3bf0"
/// title : "Math Examx"
/// doctorname : "Dr. Ahmedxxxxxx"
/// level : 3
/// department : "CS"
/// isPublished : false
/// subject_name : "Mathematics"
/// startAt : "2025-09-20T00:00:00.000Z"
/// endAt : "2025-09-29T00:00:00.000Z"
/// durationMinutes : 120
/// createdAt : "2025-09-15T11:58:00.977Z"
/// updatedAt : "2025-09-15T11:58:00.977Z"
/// __v : 0

class Exams {
  Exams({
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

  Exams.fromJson(dynamic json) {
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