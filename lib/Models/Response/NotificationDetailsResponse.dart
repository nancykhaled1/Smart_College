class NotificationDetailsResponse {
  bool? success;
  DataDetails? data;

  NotificationDetailsResponse({this.success, this.data});

  NotificationDetailsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataDetails.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    return map;
  }
}

class DataDetails {
  String? id;
  String? user;
  Notification? notification;
  bool? read;
  String? createdAt;
  String? updatedAt;

  DataDetails(
      {this.id, this.user, this.notification, this.read, this.createdAt, this.updatedAt});

  DataDetails.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    user = json['user'];
    notification = json['notification'] != null
        ? Notification.fromJson(json['notification'])
        : null;
    read = json['read'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['_id'] = id;
    map['user'] = user;
    if (notification != null) {
      map['notification'] = notification!.toJson();
    }
    map['read'] = read;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
}

class Notification {
  String? id;
  String? title;
  String? body;
  String? createdAt;
  String? updatedAt;

  Notification({this.id, this.title, this.body, this.createdAt, this.updatedAt});

  Notification.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    body = json['body'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['_id'] = id;
    map['title'] = title;
    map['body'] = body;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
}
