/// success : true
/// data : {"exams":[{"_id":"68d3daa0f3e2af28f051ed6e","title":"Math Exam","doctorname":"Dr. Ahmed","level":3,"department":"CS","isPublished":false,"subject_name":"Algebra","startAt":"2025-09-30T08:00:00.000Z","endAt":"2025-09-30T10:00:00.000Z","durationMinutes":120,"createdAt":"2025-09-24T11:48:48.325Z","updatedAt":"2025-09-24T11:48:48.325Z","__v":0},{"_id":"68d3dc2f61d653181c185513","title":"Math Exam","doctorname":"Dr. Ahmed","level":3,"department":"CS","isPublished":false,"subject_name":"Algebra","startAt":"2025-09-30T08:00:00.000Z","endAt":"2025-09-30T10:00:00.000Z","durationMinutes":120,"createdAt":"2025-09-24T11:55:27.820Z","updatedAt":"2025-09-24T11:55:27.820Z","__v":0},{"_id":"68d3dc4d61d653181c185517","title":"Math Exam","doctorname":"Dr. Ahmed","level":3,"department":"CS","isPublished":false,"subject_name":"Algebra","startAt":"2025-09-30T08:00:00.000Z","endAt":"2025-09-30T10:00:00.000Z","durationMinutes":120,"createdAt":"2025-09-24T11:55:57.062Z","updatedAt":"2025-09-24T11:55:57.062Z","__v":0},{"_id":"68d3dc6c61d653181c18551b","title":"Math Exam","doctorname":"Dr. Ahmed","level":3,"department":"CS","isPublished":false,"subject_name":"Algebra","startAt":"2025-09-30T08:00:00.000Z","endAt":"2025-09-30T10:00:00.000Z","durationMinutes":120,"createdAt":"2025-09-24T11:56:28.791Z","updatedAt":"2025-09-24T11:56:28.791Z","__v":0},{"_id":"68d3dc8661d653181c18551f","title":"Math Exam","doctorname":"Dr. Ahmed","level":3,"department":"CS","isPublished":false,"subject_name":"Algebra","startAt":"2025-09-30T08:00:00.000Z","endAt":"2025-09-30T10:00:00.000Z","durationMinutes":120,"createdAt":"2025-09-24T11:56:54.685Z","updatedAt":"2025-09-24T11:56:54.685Z","__v":0},{"_id":"68d3dd4f401113ef0e02cf8b","title":"Math Exam","doctorname":"Dr. Ahmed","level":3,"department":"CS","isPublished":false,"subject_name":"Algebra","startAt":"2025-09-30T08:00:00.000Z","endAt":"2025-09-30T10:00:00.000Z","durationMinutes":120,"createdAt":"2025-09-24T12:00:15.128Z","updatedAt":"2025-09-24T12:00:15.128Z","__v":0},{"_id":"68d3df09e36996af7725096d","title":"Math Exam","doctorname":"Dr. Ahmed","level":3,"department":"CS","isPublished":false,"subject_name":"Algebra","startAt":"2025-09-30T08:00:00.000Z","endAt":"2025-09-30T10:00:00.000Z","durationMinutes":120,"createdAt":"2025-09-24T12:07:37.961Z","updatedAt":"2025-09-24T12:07:37.961Z","__v":0},{"_id":"68d3df73e36996af7725097e","title":"Math Exam","doctorname":"Dr. Ahmed","level":3,"department":"CS","isPublished":true,"subject_name":"Algebra","startAt":"2025-09-30T08:00:00.000Z","endAt":"2025-09-30T10:00:00.000Z","durationMinutes":120,"createdAt":"2025-09-24T12:09:23.554Z","updatedAt":"2025-09-26T11:44:27.762Z","__v":0},{"_id":"68d3dfb0e36996af77250987","title":"Math Exam","doctorname":"Dr. Ahmed","level":3,"department":"CS","isPublished":false,"subject_name":"Algebra","startAt":"2025-09-30T08:00:00.000Z","endAt":"2025-09-30T10:00:00.000Z","durationMinutes":120,"createdAt":"2025-09-24T12:10:24.679Z","updatedAt":"2025-09-24T12:10:24.679Z","__v":0},{"_id":"68d3e00ee36996af77250990","title":"Math Exam","doctorname":"Dr. Ahmed","level":3,"department":"CS","isPublished":false,"subject_name":"Algebra","startAt":"2025-09-30T08:00:00.000Z","endAt":"2025-09-30T10:00:00.000Z","durationMinutes":120,"createdAt":"2025-09-24T12:11:58.104Z","updatedAt":"2025-09-24T12:11:58.104Z","__v":0},{"_id":"68d3e2749e591b4f46ec88d5","title":"Math Exam","doctorname":"Dr. Ahmed","level":3,"department":"CS","isPublished":false,"subject_name":"Algebra","startAt":"2025-09-30T08:00:00.000Z","endAt":"2025-09-30T10:00:00.000Z","durationMinutes":120,"createdAt":"2025-09-24T12:22:12.186Z","updatedAt":"2025-09-24T12:22:13.284Z","__v":1},{"_id":"68d67ae5cc470c4fca8c73b8","title":"Math Exam","subject_name":"Algebra","level":3,"department":"CS","startAt":"2025-09-30T08:00:00.000Z","endAt":"2025-09-30T10:00:00.000Z","durationMinutes":120,"isPublished":true,"createdAt":"2025-09-26T11:37:09.367Z","updatedAt":"2025-09-26T11:44:54.326Z","__v":1}]}

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

/// exams : [{"_id":"68d3daa0f3e2af28f051ed6e","title":"Math Exam","doctorname":"Dr. Ahmed","level":3,"department":"CS","isPublished":false,"subject_name":"Algebra","startAt":"2025-09-30T08:00:00.000Z","endAt":"2025-09-30T10:00:00.000Z","durationMinutes":120,"createdAt":"2025-09-24T11:48:48.325Z","updatedAt":"2025-09-24T11:48:48.325Z","__v":0},{"_id":"68d3dc2f61d653181c185513","title":"Math Exam","doctorname":"Dr. Ahmed","level":3,"department":"CS","isPublished":false,"subject_name":"Algebra","startAt":"2025-09-30T08:00:00.000Z","endAt":"2025-09-30T10:00:00.000Z","durationMinutes":120,"createdAt":"2025-09-24T11:55:27.820Z","updatedAt":"2025-09-24T11:55:27.820Z","__v":0},{"_id":"68d3dc4d61d653181c185517","title":"Math Exam","doctorname":"Dr. Ahmed","level":3,"department":"CS","isPublished":false,"subject_name":"Algebra","startAt":"2025-09-30T08:00:00.000Z","endAt":"2025-09-30T10:00:00.000Z","durationMinutes":120,"createdAt":"2025-09-24T11:55:57.062Z","updatedAt":"2025-09-24T11:55:57.062Z","__v":0},{"_id":"68d3dc6c61d653181c18551b","title":"Math Exam","doctorname":"Dr. Ahmed","level":3,"department":"CS","isPublished":false,"subject_name":"Algebra","startAt":"2025-09-30T08:00:00.000Z","endAt":"2025-09-30T10:00:00.000Z","durationMinutes":120,"createdAt":"2025-09-24T11:56:28.791Z","updatedAt":"2025-09-24T11:56:28.791Z","__v":0},{"_id":"68d3dc8661d653181c18551f","title":"Math Exam","doctorname":"Dr. Ahmed","level":3,"department":"CS","isPublished":false,"subject_name":"Algebra","startAt":"2025-09-30T08:00:00.000Z","endAt":"2025-09-30T10:00:00.000Z","durationMinutes":120,"createdAt":"2025-09-24T11:56:54.685Z","updatedAt":"2025-09-24T11:56:54.685Z","__v":0},{"_id":"68d3dd4f401113ef0e02cf8b","title":"Math Exam","doctorname":"Dr. Ahmed","level":3,"department":"CS","isPublished":false,"subject_name":"Algebra","startAt":"2025-09-30T08:00:00.000Z","endAt":"2025-09-30T10:00:00.000Z","durationMinutes":120,"createdAt":"2025-09-24T12:00:15.128Z","updatedAt":"2025-09-24T12:00:15.128Z","__v":0},{"_id":"68d3df09e36996af7725096d","title":"Math Exam","doctorname":"Dr. Ahmed","level":3,"department":"CS","isPublished":false,"subject_name":"Algebra","startAt":"2025-09-30T08:00:00.000Z","endAt":"2025-09-30T10:00:00.000Z","durationMinutes":120,"createdAt":"2025-09-24T12:07:37.961Z","updatedAt":"2025-09-24T12:07:37.961Z","__v":0},{"_id":"68d3df73e36996af7725097e","title":"Math Exam","doctorname":"Dr. Ahmed","level":3,"department":"CS","isPublished":true,"subject_name":"Algebra","startAt":"2025-09-30T08:00:00.000Z","endAt":"2025-09-30T10:00:00.000Z","durationMinutes":120,"createdAt":"2025-09-24T12:09:23.554Z","updatedAt":"2025-09-26T11:44:27.762Z","__v":0},{"_id":"68d3dfb0e36996af77250987","title":"Math Exam","doctorname":"Dr. Ahmed","level":3,"department":"CS","isPublished":false,"subject_name":"Algebra","startAt":"2025-09-30T08:00:00.000Z","endAt":"2025-09-30T10:00:00.000Z","durationMinutes":120,"createdAt":"2025-09-24T12:10:24.679Z","updatedAt":"2025-09-24T12:10:24.679Z","__v":0},{"_id":"68d3e00ee36996af77250990","title":"Math Exam","doctorname":"Dr. Ahmed","level":3,"department":"CS","isPublished":false,"subject_name":"Algebra","startAt":"2025-09-30T08:00:00.000Z","endAt":"2025-09-30T10:00:00.000Z","durationMinutes":120,"createdAt":"2025-09-24T12:11:58.104Z","updatedAt":"2025-09-24T12:11:58.104Z","__v":0},{"_id":"68d3e2749e591b4f46ec88d5","title":"Math Exam","doctorname":"Dr. Ahmed","level":3,"department":"CS","isPublished":false,"subject_name":"Algebra","startAt":"2025-09-30T08:00:00.000Z","endAt":"2025-09-30T10:00:00.000Z","durationMinutes":120,"createdAt":"2025-09-24T12:22:12.186Z","updatedAt":"2025-09-24T12:22:13.284Z","__v":1},{"_id":"68d67ae5cc470c4fca8c73b8","title":"Math Exam","subject_name":"Algebra","level":3,"department":"CS","startAt":"2025-09-30T08:00:00.000Z","endAt":"2025-09-30T10:00:00.000Z","durationMinutes":120,"isPublished":true,"createdAt":"2025-09-26T11:37:09.367Z","updatedAt":"2025-09-26T11:44:54.326Z","__v":1}]

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

/// _id : "68d3daa0f3e2af28f051ed6e"
/// title : "Math Exam"
/// doctorname : "Dr. Ahmed"
/// level : 3
/// department : "CS"
/// isPublished : false
/// subject_name : "Algebra"
/// startAt : "2025-09-30T08:00:00.000Z"
/// endAt : "2025-09-30T10:00:00.000Z"
/// durationMinutes : 120
/// createdAt : "2025-09-24T11:48:48.325Z"
/// updatedAt : "2025-09-24T11:48:48.325Z"
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