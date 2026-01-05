
// import 'SendMessageResponse.dart';
//
// class UserMessagesResponse {
//   bool? success;
//   Data? data;
//
//   UserMessagesResponse({this.success, this.data});
//
//   UserMessagesResponse.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
// }
//
// class Data {
//   List<Message>? messages;
//
//   Data({this.messages});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     if (json['messages'] != null) {
//       messages = <Message>[];
//       json['messages'].forEach((v) {
//         messages!.add(Message.fromJson(v));
//       });
//     }
//   }
// }
