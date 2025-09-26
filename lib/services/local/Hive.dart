// import 'package:hive/hive.dart';
// import '../../Models/Response/SendMessageResponse.dart';
//
// class LocalMessageStorage {
//   static Box get _box => Hive.box('messages');
//
//   /// تخزين الرسائل لمحادثة معينة
//   static Future<void> saveMessages(String convId, List<Message> messages) async {
//     await _box.put(convId, messages.map((m) => m.toJson()).toList());
//   }
//
//   /// استرجاع الرسائل
//   static List<Message> getMessages(String convId) {
//     final data = _box.get(convId, defaultValue: []);
//     return (data as List).map((e) => Message.fromJson(Map<String, dynamic>.from(e))).toList();
//   }
// }
