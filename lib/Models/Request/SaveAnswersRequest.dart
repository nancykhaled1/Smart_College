/// attemptId : "68d9c41fc865b2cba60b13b3"
/// questionId : "68d67ae5cc470c4fca8c73ba"
/// answer : "4"

class SaveAnswersRequest {
  SaveAnswersRequest({
      this.attemptId, 
      this.questionId,
    this.examId,
      this.answer,});

  SaveAnswersRequest.fromJson(dynamic json) {
    attemptId = json['attemptId'];
    questionId = json['questionId'];
    examId = json['examId'];
    answer = json['answer'];
  }
  String? attemptId;
  String? questionId;
  String? examId;
  String? answer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['attemptId'] = attemptId;
    map['questionId'] = questionId;
    map['examId'] = examId;
    map['answer'] = answer;
    return map;
  }

}