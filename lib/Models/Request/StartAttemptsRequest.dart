/// examId : "68d3df73e36996af7725097e"

class StartAttemptsRequest {
  StartAttemptsRequest({
      this.examId,});

  StartAttemptsRequest.fromJson(dynamic json) {
    examId = json['examId'];
  }
  String? examId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['examId'] = examId;
    return map;
  }

}