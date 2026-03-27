/// attemptId : "68c80f9838ccd8446fbd63c4"

class SubmitRequest {
  SubmitRequest({
      this.attemptId,});

  SubmitRequest.fromJson(dynamic json) {
    attemptId = json['attemptId'];
  }
  String? attemptId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['attemptId'] = attemptId;
    return map;
  }

}