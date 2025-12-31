/// token : "/fcm-token"

class NotificationRequest {
  NotificationRequest({
      this.token,});

  NotificationRequest.fromJson(dynamic json) {
    token = json['token'];
  }
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    return map;
  }

}