/// success : true
/// data : [{"_id":"68d51ca1bfcb8efbc4a11656","chat":"68d50b4380d4f6665a52ed62","senderModel":"User","sender":{"_id":"68ca7ac4604923e139462899","name":"hassan","email":"hassanmohed@gmail.com","password":"$2b$10$WKPjxG.ylUJDhVkMimnr3Osbc6YrnwqO2PrvTJKFje4.CAB0DUSC.","BaseImage64":null,"isVerified":true,"role":"Student","level":3,"department":"CS","isNew":false,"isOnline":true,"lastSeen":"2025-09-25T13:02:26.698Z","updatedAt":"2025-09-25T13:03:04.532Z","__v":0,"fcmtoken":"fB5HhX52TlSX7ecOM4IaIP:APA91bFZk6wr5PG64T8q1apZwfnXOoH_0F49uoGONPTQ5RHq3C8iBulZn15WnGpiVA_5em8HzVnTT3wpbxov0V4BzCBShKriveDiDElVvdghukUwzVYSFdg"},"content":"السلام عليكم يا ادمن","readBy":["68ca7ac4604923e139462899"],"createdAt":"2025-09-25T10:42:41.797Z","updatedAt":"2025-09-25T10:42:41.797Z","__v":0},{"_id":"68d53d9a2a9933ba3362d4f3","chat":"68d50b4380d4f6665a52ed62","senderModel":"Admin","sender":{"roleId":null,"_id":"68d505b6cb5768439463619b","name":"Main Super Admin","email":"smartcollge82@gmail.com","hashedPassword":"$2b$10$QVno3NZ6iGicEG0ya5p31uo//aIvXKK12.Wm5l44Ba7nHv51cVimS","role":"SuperAdmin","isOnline":false,"lastSeen":"2025-09-25T12:00:00.000Z"},"content":"أهلا بيك يا طالب 👋","readBy":["68d505b6cb5768439463619b"],"createdAt":"2025-09-25T13:03:22.281Z","updatedAt":"2025-09-25T13:03:22.281Z","__v":0},{"_id":"68d53d9b2a9933ba3362d4f6","chat":"68d50b4380d4f6665a52ed62","senderModel":"User","sender":{"_id":"68ca7ac4604923e139462899","name":"hassan","email":"hassanmohed@gmail.com","password":"$2b$10$WKPjxG.ylUJDhVkMimnr3Osbc6YrnwqO2PrvTJKFje4.CAB0DUSC.","BaseImage64":null,"isVerified":true,"role":"Student","level":3,"department":"CS","isNew":false,"isOnline":true,"lastSeen":"2025-09-25T13:02:26.698Z","updatedAt":"2025-09-25T13:03:04.532Z","__v":0,"fcmtoken":"fB5HhX52TlSX7ecOM4IaIP:APA91bFZk6wr5PG64T8q1apZwfnXOoH_0F49uoGONPTQ5RHq3C8iBulZn15WnGpiVA_5em8HzVnTT3wpbxov0V4BzCBShKriveDiDElVvdghukUwzVYSFdg"},"content":"👏🏼👏🏼","readBy":["68ca7ac4604923e139462899"],"createdAt":"2025-09-25T13:03:23.516Z","updatedAt":"2025-09-25T13:03:23.516Z","__v":0},{"_id":"68d53da82a9933ba3362d4fb","chat":"68d50b4380d4f6665a52ed62","senderModel":"User","sender":{"_id":"68ca7ac4604923e139462899","name":"hassan","email":"hassanmohed@gmail.com","password":"$2b$10$WKPjxG.ylUJDhVkMimnr3Osbc6YrnwqO2PrvTJKFje4.CAB0DUSC.","BaseImage64":null,"isVerified":true,"role":"Student","level":3,"department":"CS","isNew":false,"isOnline":true,"lastSeen":"2025-09-25T13:02:26.698Z","updatedAt":"2025-09-25T13:03:04.532Z","__v":0,"fcmtoken":"fB5HhX52TlSX7ecOM4IaIP:APA91bFZk6wr5PG64T8q1apZwfnXOoH_0F49uoGONPTQ5RHq3C8iBulZn15WnGpiVA_5em8HzVnTT3wpbxov0V4BzCBShKriveDiDElVvdghukUwzVYSFdg"},"content":"👋🏼👋🏼👋🏼","readBy":["68ca7ac4604923e139462899"],"createdAt":"2025-09-25T13:03:36.172Z","updatedAt":"2025-09-25T13:03:36.172Z","__v":0}]

class AllMessagesResponse {
  AllMessagesResponse({
      this.success, 
      this.data,});

  AllMessagesResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(MessageData.fromJson(v));
      });
    }
  }
  bool? success;
  List<MessageData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "68d51ca1bfcb8efbc4a11656"
/// chat : "68d50b4380d4f6665a52ed62"
/// senderModel : "User"
/// sender : {"_id":"68ca7ac4604923e139462899","name":"hassan","email":"hassanmohed@gmail.com","password":"$2b$10$WKPjxG.ylUJDhVkMimnr3Osbc6YrnwqO2PrvTJKFje4.CAB0DUSC.","BaseImage64":null,"isVerified":true,"role":"Student","level":3,"department":"CS","isNew":false,"isOnline":true,"lastSeen":"2025-09-25T13:02:26.698Z","updatedAt":"2025-09-25T13:03:04.532Z","__v":0,"fcmtoken":"fB5HhX52TlSX7ecOM4IaIP:APA91bFZk6wr5PG64T8q1apZwfnXOoH_0F49uoGONPTQ5RHq3C8iBulZn15WnGpiVA_5em8HzVnTT3wpbxov0V4BzCBShKriveDiDElVvdghukUwzVYSFdg"}
/// content : "السلام عليكم يا ادمن"
/// readBy : ["68ca7ac4604923e139462899"]
/// createdAt : "2025-09-25T10:42:41.797Z"
/// updatedAt : "2025-09-25T10:42:41.797Z"
/// __v : 0

class MessageData {
  MessageData({
      this.id, 
      this.chat, 
      this.senderModel, 
      this.sender, 
      this.content, 
      this.readBy, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  MessageData.fromJson(dynamic json) {
    id = json['_id'];
    chat = json['chat'];
    senderModel = json['senderModel'];
    sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    content = json['content'];
    readBy = json['readBy'] != null ? json['readBy'].cast<String>() : [];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? chat;
  String? senderModel;
  Sender? sender;
  String? content;
  List<String>? readBy;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['chat'] = chat;
    map['senderModel'] = senderModel;
    if (sender != null) {
      map['sender'] = sender?.toJson();
    }
    map['content'] = content;
    map['readBy'] = readBy;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}

/// _id : "68ca7ac4604923e139462899"
/// name : "hassan"
/// email : "hassanmohed@gmail.com"
/// password : "$2b$10$WKPjxG.ylUJDhVkMimnr3Osbc6YrnwqO2PrvTJKFje4.CAB0DUSC."
/// BaseImage64 : null
/// isVerified : true
/// role : "Student"
/// level : 3
/// department : "CS"
/// isNew : false
/// isOnline : true
/// lastSeen : "2025-09-25T13:02:26.698Z"
/// updatedAt : "2025-09-25T13:03:04.532Z"
/// __v : 0
/// fcmtoken : "fB5HhX52TlSX7ecOM4IaIP:APA91bFZk6wr5PG64T8q1apZwfnXOoH_0F49uoGONPTQ5RHq3C8iBulZn15WnGpiVA_5em8HzVnTT3wpbxov0V4BzCBShKriveDiDElVvdghukUwzVYSFdg"

class Sender {
  Sender({
      this.id, 
      this.name, 
      this.email, 
      this.password, 
      this.baseImage64, 
      this.isVerified, 
      this.role, 
      this.level, 
      this.department, 
      this.isNew, 
      this.isOnline, 
      this.lastSeen, 
      this.updatedAt, 
      this.v, 
      this.fcmtoken,});

  Sender.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    baseImage64 = json['BaseImage64'];
    isVerified = json['isVerified'];
    role = json['role'];
    level = json['level'];
    department = json['department'];
    isNew = json['isNew'];
    isOnline = json['isOnline'];
    lastSeen = json['lastSeen'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    fcmtoken = json['fcmtoken'];
  }
  String? id;
  String? name;
  String? email;
  String? password;
  dynamic baseImage64;
  bool? isVerified;
  String? role;
  int? level;
  String? department;
  bool? isNew;
  bool? isOnline;
  String? lastSeen;
  String? updatedAt;
  int? v;
  String? fcmtoken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;
    map['BaseImage64'] = baseImage64;
    map['isVerified'] = isVerified;
    map['role'] = role;
    map['level'] = level;
    map['department'] = department;
    map['isNew'] = isNew;
    map['isOnline'] = isOnline;
    map['lastSeen'] = lastSeen;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['fcmtoken'] = fcmtoken;
    return map;
  }

}