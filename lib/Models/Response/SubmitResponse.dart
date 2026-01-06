/// success : true
/// data : {"attempt":{"_id":"68ed14ee74636dce3d087a8e","exam":"68ed14cb74636dce3d087a2f","student":"68ca7ac4604923e139462899","answers":[{"question":"68ed14cb74636dce3d087a31","answer":"Speed","file":null,"pointsAwarded":0},{"question":"68ed14cb74636dce3d087a36","answer":"BFS","file":null,"pointsAwarded":2},{"question":"68ed14cb74636dce3d087a36","answer":"BFS","file":null,"pointsAwarded":2},{"question":"68ed14cb74636dce3d087a40","answer":"Regression","file":null,"pointsAwarded":2},{"question":"68ed14cb74636dce3d087a45","answer":"Neural Logic Programming","file":null,"pointsAwarded":0}],"totalPoints":6,"correctCount":3,"wrongCount":2,"status":"submitted","startedAt":"2025-10-13T15:04:14.143Z","endAt":"2025-10-13T16:04:14.143Z","createdAt":"2025-10-13T15:04:14.144Z","updatedAt":"2025-10-13T15:04:38.871Z","__v":5,"submittedAt":"2025-10-13T15:04:38.871Z"},"examTitle":" AI Exam 2","maxPoints":10,"scoredPoints":6}

class SubmitResponse {
  SubmitResponse({
      this.success, 
      this.data,});

  SubmitResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? SubmitData.fromJson(json['data']) : null;
  }
  bool? success;
  SubmitData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// attempt : {"_id":"68ed14ee74636dce3d087a8e","exam":"68ed14cb74636dce3d087a2f","student":"68ca7ac4604923e139462899","answers":[{"question":"68ed14cb74636dce3d087a31","answer":"Speed","file":null,"pointsAwarded":0},{"question":"68ed14cb74636dce3d087a36","answer":"BFS","file":null,"pointsAwarded":2},{"question":"68ed14cb74636dce3d087a36","answer":"BFS","file":null,"pointsAwarded":2},{"question":"68ed14cb74636dce3d087a40","answer":"Regression","file":null,"pointsAwarded":2},{"question":"68ed14cb74636dce3d087a45","answer":"Neural Logic Programming","file":null,"pointsAwarded":0}],"totalPoints":6,"correctCount":3,"wrongCount":2,"status":"submitted","startedAt":"2025-10-13T15:04:14.143Z","endAt":"2025-10-13T16:04:14.143Z","createdAt":"2025-10-13T15:04:14.144Z","updatedAt":"2025-10-13T15:04:38.871Z","__v":5,"submittedAt":"2025-10-13T15:04:38.871Z"}
/// examTitle : " AI Exam 2"
/// maxPoints : 10
/// scoredPoints : 6

class SubmitData {
  SubmitData({
      this.attempt, 
      this.examTitle, 
      this.maxPoints, 
      this.scoredPoints,});

  SubmitData.fromJson(dynamic json) {
    attempt = json['attempt'] != null ? Attempt.fromJson(json['attempt']) : null;
    examTitle = json['examTitle'];
    maxPoints = json['maxPoints'];
    scoredPoints = json['scoredPoints'];
  }
  Attempt? attempt;
  String? examTitle;
  int? maxPoints;
  int? scoredPoints;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (attempt != null) {
      map['attempt'] = attempt?.toJson();
    }
    map['examTitle'] = examTitle;
    map['maxPoints'] = maxPoints;
    map['scoredPoints'] = scoredPoints;
    return map;
  }

}

/// _id : "68ed14ee74636dce3d087a8e"
/// exam : "68ed14cb74636dce3d087a2f"
/// student : "68ca7ac4604923e139462899"
/// answers : [{"question":"68ed14cb74636dce3d087a31","answer":"Speed","file":null,"pointsAwarded":0},{"question":"68ed14cb74636dce3d087a36","answer":"BFS","file":null,"pointsAwarded":2},{"question":"68ed14cb74636dce3d087a36","answer":"BFS","file":null,"pointsAwarded":2},{"question":"68ed14cb74636dce3d087a40","answer":"Regression","file":null,"pointsAwarded":2},{"question":"68ed14cb74636dce3d087a45","answer":"Neural Logic Programming","file":null,"pointsAwarded":0}]
/// totalPoints : 6
/// correctCount : 3
/// wrongCount : 2
/// status : "submitted"
/// startedAt : "2025-10-13T15:04:14.143Z"
/// endAt : "2025-10-13T16:04:14.143Z"
/// createdAt : "2025-10-13T15:04:14.144Z"
/// updatedAt : "2025-10-13T15:04:38.871Z"
/// __v : 5
/// submittedAt : "2025-10-13T15:04:38.871Z"

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
      this.v, 
      this.submittedAt,});

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
    submittedAt = json['submittedAt'];
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
  String? submittedAt;

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
    map['submittedAt'] = submittedAt;
    return map;
  }

}

/// question : "68ed14cb74636dce3d087a31"
/// answer : "Speed"
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