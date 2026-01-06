/// success : true
/// data : {"questions":[{"text":"2 + 2 = ?","type":"MCQ","choices":[{"text":"1","_id":"68d67ae5cc470c4fca8c73bb"},{"text":"2","_id":"68d67ae5cc470c4fca8c73bc"},{"text":"3","_id":"68d67ae5cc470c4fca8c73bd"},{"text":"4","_id":"68d67ae5cc470c4fca8c73be"}],"correctAnswer":"4","points":5,"image":null,"_id":"68d67ae5cc470c4fca8c73ba","createdAt":"2025-09-26T11:37:09.636Z","updatedAt":"2025-09-26T11:37:09.636Z"},{"text":"Solve for x: x + 3 = 7","type":"short-answer","choices":[],"correctAnswer":"4","points":5,"image":null,"_id":"68d67ae5cc470c4fca8c73bf","createdAt":"2025-09-26T11:37:09.636Z","updatedAt":"2025-09-26T11:37:09.636Z"},{"text":"Identify the shape in the image","type":"MCQ","choices":[{"text":"Circle","_id":"68d67ae5cc470c4fca8c73c1"},{"text":"Square","_id":"68d67ae5cc470c4fca8c73c2"},{"text":"Triangle","_id":"68d67ae5cc470c4fca8c73c3"},{"text":"Rectangle","_id":"68d67ae5cc470c4fca8c73c4"}],"correctAnswer":"Triangle","points":10,"image":"http://smartcollgeapp-production.up.railway.app/uploads/questions/68d505b6cb5768439463619b.png","_id":"68d67ae5cc470c4fca8c73c0","createdAt":"2025-09-26T11:37:09.636Z","updatedAt":"2025-09-26T11:37:09.636Z"}]}

class QuestionsResponse {
  QuestionsResponse({
      this.success, 
      this.data,});

  QuestionsResponse.fromJson(dynamic json) {
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

/// questions : [{"text":"2 + 2 = ?","type":"MCQ","choices":[{"text":"1","_id":"68d67ae5cc470c4fca8c73bb"},{"text":"2","_id":"68d67ae5cc470c4fca8c73bc"},{"text":"3","_id":"68d67ae5cc470c4fca8c73bd"},{"text":"4","_id":"68d67ae5cc470c4fca8c73be"}],"correctAnswer":"4","points":5,"image":null,"_id":"68d67ae5cc470c4fca8c73ba","createdAt":"2025-09-26T11:37:09.636Z","updatedAt":"2025-09-26T11:37:09.636Z"},{"text":"Solve for x: x + 3 = 7","type":"short-answer","choices":[],"correctAnswer":"4","points":5,"image":null,"_id":"68d67ae5cc470c4fca8c73bf","createdAt":"2025-09-26T11:37:09.636Z","updatedAt":"2025-09-26T11:37:09.636Z"},{"text":"Identify the shape in the image","type":"MCQ","choices":[{"text":"Circle","_id":"68d67ae5cc470c4fca8c73c1"},{"text":"Square","_id":"68d67ae5cc470c4fca8c73c2"},{"text":"Triangle","_id":"68d67ae5cc470c4fca8c73c3"},{"text":"Rectangle","_id":"68d67ae5cc470c4fca8c73c4"}],"correctAnswer":"Triangle","points":10,"image":"http://smartcollgeapp-production.up.railway.app/uploads/questions/68d505b6cb5768439463619b.png","_id":"68d67ae5cc470c4fca8c73c0","createdAt":"2025-09-26T11:37:09.636Z","updatedAt":"2025-09-26T11:37:09.636Z"}]

class Data {
  Data({
      this.questions,});

  Data.fromJson(dynamic json) {
    if (json['questions'] != null) {
      questions = [];
      json['questions'].forEach((v) {
        questions?.add(Questions.fromJson(v));
      });
    }
  }
  List<Questions>? questions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (questions != null) {
      map['questions'] = questions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// text : "2 + 2 = ?"
/// type : "MCQ"
/// choices : [{"text":"1","_id":"68d67ae5cc470c4fca8c73bb"},{"text":"2","_id":"68d67ae5cc470c4fca8c73bc"},{"text":"3","_id":"68d67ae5cc470c4fca8c73bd"},{"text":"4","_id":"68d67ae5cc470c4fca8c73be"}]
/// correctAnswer : "4"
/// points : 5
/// image : null
/// _id : "68d67ae5cc470c4fca8c73ba"
/// createdAt : "2025-09-26T11:37:09.636Z"
/// updatedAt : "2025-09-26T11:37:09.636Z"

class Questions {
  Questions({
      this.text, 
      this.type, 
      this.choices, 
      this.correctAnswer, 
      this.points, 
      this.image, 
      this.id, 
      this.createdAt, 
      this.updatedAt,});

  Questions.fromJson(dynamic json) {
    text = json['text'];
    type = json['type'];
    if (json['choices'] != null) {
      choices = [];
      json['choices'].forEach((v) {
        choices?.add(Choices.fromJson(v));
      });
    }
    correctAnswer = json['correctAnswer'];
    points = json['points'];
    image = json['image'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  String? text;
  String? type;
  List<Choices>? choices;
  String? correctAnswer;
  int? points;
  dynamic image;
  String? id;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = text;
    map['type'] = type;
    if (choices != null) {
      map['choices'] = choices?.map((v) => v.toJson()).toList();
    }
    map['correctAnswer'] = correctAnswer;
    map['points'] = points;
    map['image'] = image;
    map['_id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

}

/// text : "1"
/// _id : "68d67ae5cc470c4fca8c73bb"

class Choices {
  Choices({
      this.text, 
      this.id,});

  Choices.fromJson(dynamic json) {
    text = json['text'];
    id = json['_id'];
  }
  String? text;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = text;
    map['_id'] = id;
    return map;
  }

}