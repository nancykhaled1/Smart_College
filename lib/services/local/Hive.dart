import 'package:hive/hive.dart';

part 'Hive.g.dart';

@HiveType(typeId: 0)
class Message {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String content;

  @HiveField(2)
  final String senderModel;

  @HiveField(3)
  final String createdAt;

  @HiveField(4)
  final bool? isLocal; // 🔥 جديد علشان نعرف إنها Optimistic

  @HiveField(5)
  final String? tempId; // 🔥 جديد علشان نربط الرسالة المؤقتة باللي جاية من السيرفر

  Message({
    required this.id,
    required this.content,
    required this.senderModel,
    required this.createdAt,
    this.isLocal,
    this.tempId,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json["_id"] ?? json["id"] ?? "",
      content: json["content"] ?? "",
      senderModel: json["senderModel"] ?? "User",
      createdAt: json["createdAt"] ?? DateTime.now().toIso8601String(),
      isLocal: json["isLocal"] ?? false,
      tempId: json["tempId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "content": content,
      "senderModel": senderModel,
      "createdAt": createdAt,
      "isLocal": isLocal,
      "tempId": tempId,
    };
  }
}
