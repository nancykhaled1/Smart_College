/// success : true
/// data : {"attempt":{"_id":"68d9c41fc865b2cba60b13b3","exam":"68d3df73e36996af7725097e","student":"68ca7ac4604923e139462899","answers":[{"question":"68d67ae5cc470c4fca8c73ba","answer":"4","file":null,"pointsAwarded":0}],"totalPoints":0,"correctCount":0,"wrongCount":0,"status":"in-progress","startedAt":"2025-09-28T23:26:23.859Z","endAt":"2025-09-29T01:26:23.859Z","createdAt":"2025-09-28T23:26:23.861Z","updatedAt":"2025-09-29T14:57:53.495Z","__v":1}}

class SaveAnswersResponse {
  SaveAnswersResponse({
      this.success, 
      this.data,});

  SaveAnswersResponse.fromJson(dynamic json) {
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

/// attempt : {"_id":"68d9c41fc865b2cba60b13b3","exam":"68d3df73e36996af7725097e","student":"68ca7ac4604923e139462899","answers":[{"question":"68d67ae5cc470c4fca8c73ba","answer":"4","file":null,"pointsAwarded":0}],"totalPoints":0,"correctCount":0,"wrongCount":0,"status":"in-progress","startedAt":"2025-09-28T23:26:23.859Z","endAt":"2025-09-29T01:26:23.859Z","createdAt":"2025-09-28T23:26:23.861Z","updatedAt":"2025-09-29T14:57:53.495Z","__v":1}

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

/// _id : "68d9c41fc865b2cba60b13b3"
/// exam : "68d3df73e36996af7725097e"
/// student : "68ca7ac4604923e139462899"
/// answers : [{"question":"68d67ae5cc470c4fca8c73ba","answer":"4","file":null,"pointsAwarded":0}]
/// totalPoints : 0
/// correctCount : 0
/// wrongCount : 0
/// status : "in-progress"
/// startedAt : "2025-09-28T23:26:23.859Z"
/// endAt : "2025-09-29T01:26:23.859Z"
/// createdAt : "2025-09-28T23:26:23.861Z"
/// updatedAt : "2025-09-29T14:57:53.495Z"
/// __v : 1

class Attempt {
  Attempt({
      this.id, 
      this.exam, 
      this.student, 
      this.answers, 
      this.totalPoints, 
      this.correctCount, 
      this.wrongCount, 
      this.status, 
      this.startedAt, 
      this.endAt, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Attempt.fromJson(dynamic json) {
    id = json['_id'];
    exam = json['exam'];
    student = json['student'];
    if (json['answers'] != null) {
      answers = [];
      json['answers'].forEach((v) {
        answers?.add(Answers.fromJson(v));
      });
    }
    totalPoints = json['totalPoints'];
    correctCount = json['correctCount'];
    wrongCount = json['wrongCount'];
    status = json['status'];
    startedAt = json['startedAt'];
    endAt = json['endAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? exam;
  String? student;
  List<Answers>? answers;
  int? totalPoints;
  int? correctCount;
  int? wrongCount;
  String? status;
  String? startedAt;
  String? endAt;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
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
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}

/// question : "68d67ae5cc470c4fca8c73ba"
/// answer : "4"
/// file : null
/// pointsAwarded : 0

class Answers {
  Answers({
      this.question, 
      this.answer, 
      this.file, 
      this.pointsAwarded,});

  Answers.fromJson(dynamic json) {
    question = json['question'];
    answer = json['answer'];
    file = json['file'];
    pointsAwarded = json['pointsAwarded'];
  }
  String? question;
  String? answer;
  dynamic file;
  int? pointsAwarded;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['question'] = question;
    map['answer'] = answer;
    map['file'] = file;
    map['pointsAwarded'] = pointsAwarded;
    return map;
  }

}