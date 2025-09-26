/// success : true
/// data : [{"_id":"68b95c17724c737a6de60b5e","user":"68b95562724c737a6de60b3c","notification":{"_id":"68b95c17724c737a6de60b5c","title":"Test Notification","body":"This is a test notification from Postman","createdAt":"2025-09-04T09:29:59.391Z","updatedAt":"2025-09-04T09:29:59.391Z","__v":0},"read":false,"__v":0,"createdAt":"2025-09-04T09:29:59.659Z","updatedAt":"2025-09-04T09:29:59.659Z"},{"_id":"68b9567a724c737a6de60b4d","user":"68b95562724c737a6de60b3c","notification":{"_id":"68b9567a724c737a6de60b4b","title":"mmmmmmmmmmmmmmmmmmm","body":"This is a test notification from Postman","createdAt":"2025-09-04T09:06:02.693Z","updatedAt":"2025-09-04T09:06:02.693Z","__v":0},"read":true,"__v":0,"createdAt":"2025-09-04T09:06:02.958Z","updatedAt":"2025-09-04T12:55:34.982Z"}]

class GetNotificationResponse {
  GetNotificationResponse({
      this.success, 
      this.data,});

  GetNotificationResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(NotificationData.fromJson(v));
      });
    }
  }
  bool? success;
  List<NotificationData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "68b95c17724c737a6de60b5e"
/// user : "68b95562724c737a6de60b3c"
/// notification : {"_id":"68b95c17724c737a6de60b5c","title":"Test Notification","body":"This is a test notification from Postman","createdAt":"2025-09-04T09:29:59.391Z","updatedAt":"2025-09-04T09:29:59.391Z","__v":0}
/// read : false
/// __v : 0
/// createdAt : "2025-09-04T09:29:59.659Z"
/// updatedAt : "2025-09-04T09:29:59.659Z"

class NotificationData {
  NotificationData({
      this.id, 
      this.user, 
      this.notification, 
      this.read, 
      this.v, 
      this.createdAt, 
      this.updatedAt,});

  NotificationData.fromJson(dynamic json) {
    id = json['_id'];
    user = json['user'];
    notification = json['notification'] != null ? Notification.fromJson(json['notification']) : null;
    read = json['read'];
    v = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  String? id;
  String? user;
  Notification? notification;
  bool? read;
  int? v;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['user'] = user;
    if (notification != null) {
      map['notification'] = notification?.toJson();
    }
    map['read'] = read;
    map['__v'] = v;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

}

/// _id : "68b95c17724c737a6de60b5c"
/// title : "Test Notification"
/// body : "This is a test notification from Postman"
/// createdAt : "2025-09-04T09:29:59.391Z"
/// updatedAt : "2025-09-04T09:29:59.391Z"
/// __v : 0

class Notification {
  Notification({
      this.id, 
      this.title, 
      this.body, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Notification.fromJson(dynamic json) {
    id = json['_id'];
    title = json['title'];
    body = json['body'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? title;
  String? body;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['title'] = title;
    map['body'] = body;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}