// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import '../../services/local/sharedPreference.dart';
// import '../States/States.dart';
// import '../../Repositories/ChatRepository.dart';
// import '../../Models/Response/AllMessagesResponse.dart';
//
// class ChatCubit extends Cubit<States> {
//   late IO.Socket socket;
//   final String token;
//   String? chatId; // خليها متغيرة مش final
//   final ChatRepository chatRepository;
//
//   List<MessageData> allMessages = [];
//   bool isConnected = false;
//
//   ChatCubit({
//     required this.token,
//     required this.chatRepository,
//   }) : super(ChatInitial());
//
//   void _connectSocket() {
//     if (isConnected) return;
//
//     emit(ChatConnecting());
//
//     socket = IO.io(
//       "https://smartcollgeapp-production.up.railway.app",
//       IO.OptionBuilder()
//           .setTransports(['websocket'])
//           .disableAutoConnect()
//           .setAuth({"token": token})
//           .build(),
//     );
//
//     socket.connect();
//
//     socket.onConnect((_) {
//       isConnected = true;
//       emit(ChatConnected());
//
//       if (chatId != null) {
//         socket.emit("join_chat", {"chatId": chatId});
//       }
//     });
//
//     socket.on("chat_history", (data) {
//       if (data is Map && data["messages"] is List) {
//         final list = data["messages"] as List;
//         allMessages = list.map((e) => MessageData.fromJson(e)).toList();
//         chatId = data["chatId"];
//         emit(GetMessagesSuccessState(messages: allMessages));
//       } else {
//         // لو السيرفر ما رجعش history → استعمل API كـ fallback
//         getAllMessages();
//       }
//     });
//
//     socket.off("message");
//     socket.on("message", (msg) {
//       allMessages.add(MessageData.fromJson(msg));
//       emit(GetMessagesSuccessState(messages: List.from(allMessages)));
//     });
//
//     socket.onDisconnect((_) {
//       isConnected = false;
//       emit(ChatDisconnected());
//     });
//   }
//
//   /// fallback API call
//   Future<void> getAllMessages() async {
//     emit(LoadingState(loadingMessage: "جارى تحميل الرسائل..."));
//
//     var either = await chatRepository.getMessages();
//
//     either.fold(
//           (failure) {
//         emit(ErrorState(errorMessage: failure.error?.message ?? "حدث خطأ"));
//       },
//           (response) async {
//         allMessages = response.data ?? [];
//         if (allMessages.isNotEmpty) {
//           chatId = allMessages.first.chat;
//           await TokenStorage.saveChat(chatId!);
//           _connectSocket();
//         }
//
//         emit(GetMessagesSuccessState(messages: allMessages));
//       },
//     );
//   }
//
//
//   void sendMessage(String text) {
//     if (text.isEmpty || chatId == null) return;
//     socket.emit("send_message", {
//       "chatId": chatId,
//       "content": text,
//     });
//   }
//
//   void setTyping(bool typing) {
//     if (chatId == null) return;
//     socket.emit("typing", {
//       "chatId": chatId,
//       "isTyping": typing,
//     });
//   }
//
//   @override
//   Future<void> close() {
//     socket.dispose();
//     return super.close();
//   }
//
//   // /// ✅ استدعاء API للرسائل القديمة
//   // Future<void> getAllMessages() async {
//   //   emit(LoadingState(loadingMessage: "جارى تحميل الرسائل..."));
//   //
//   //   var either = await chatRepository.getMessages();
//   //
//   //   either.fold(
//   //         (failure) {
//   //       emit(ErrorState(errorMessage: failure.error?.message ?? "حدث خطأ"));
//   //     },
//   //         (response) async {
//   //       allMessages = response.data ?? [];
//   //
//   //       if (allMessages.isNotEmpty) {
//   //         chatId = allMessages.first.chat; // ✅ خزّني chatId هنا
//   //         await TokenStorage.saveChat(chatId!);
//   //
//   //         // بعد ما جهزنا chatId نعمل اتصال
//   //         _connectSocket();
//   //       }
//   //
//   //       emit(GetMessagesSuccessState(messages: allMessages));
//   //     },
//   //   );
//   // }
// }
//
//
//
//
//
//
//
//
//
//
//
//

//
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../services/local/sharedPreference.dart';
import '../States/States.dart';
import '../../Repositories/ChatRepository.dart';
import '../../Models/Response/AllMessagesResponse.dart';

class ChatCubit extends Cubit<States> {
  late IO.Socket socket;
  final String token;
  final ChatRepository chatRepository;

  List<MessageData> allMessages = [];
  bool isConnected = false;

  ChatCubit({
    required this.token,
    required this.chatRepository,
  }) : super(ChatInitial());

  void connectSocket() {
    if (isConnected) {
      debugPrint("⚠️ Socket already connected, skipping connect...");
      return;
    }

    emit(ChatConnecting());
    debugPrint("⏳ Trying to connect socket...");

    socket = IO.io(
      "https://smartcollgeapp-production.up.railway.app",
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableReconnection() // ✅ ده أهم حاجة
          .setReconnectionAttempts(10) // يحاول 10 مرات
          .setReconnectionDelay(2000)
          .setAuth({"token": token})
          .build(),
    );



    socket.connect();

    socket.onConnect((_) {
      isConnected = true;
      debugPrint("✅ Socket connected successfully!");
      emit(ChatConnected());

      socket.emit("join_chat");
      debugPrint("📩 join_chat event emitted");
    });

    socket.on("connect_error", (data) {
      debugPrint("❌ Socket connect_error: $data");
    });

    socket.on("connect_timeout", (_) {
      debugPrint("⏱️ Socket connection timed out");
    });

    socket.on("error", (data) {
      debugPrint("🚨 Socket general error: $data");
    });

    socket.on("chat_history", (data) {
      debugPrint("📥 chat_history received: $data");

      if (data is Map && data["messages"] is List) {
        final list = data["messages"] as List;
        allMessages = list.map((e) => MessageData.fromJson(e)).toList();

        emit(GetMessagesSuccessState(messages: allMessages));
        debugPrint("✅ Messages loaded from chat_history: ${allMessages.length}");
      } else {
        debugPrint("⚠️ chat_history format invalid: $data");
      }
    });

    socket.off("message");
    socket.on("message", (msg) {
      debugPrint("💬 New message received: $msg");
      final serverMessage = MessageData.fromJson(msg);

      // 🗑️ لو السيرفر رجع tempId → امسح الرسالة المؤقتة
      if (serverMessage.tempId != null) {
        allMessages.removeWhere((m) => m.id == serverMessage.tempId);
      } else {
        // fallback: لو مفيش tempId → شيل الرسالة اللي نفس الـ content ولسه Local
        allMessages.removeWhere((m) =>
        m.isLocal == true && m.content == serverMessage.content);
      }

      // ✅ ضيف الرسالة اللي جاية من السيرفر
      allMessages.add(serverMessage);

      emit(GetMessagesSuccessState(messages: List.from(allMessages)));
    });


    socket.onDisconnect((_) {
      isConnected = false;
      debugPrint("🔌 Socket disconnected");
      emit(ChatDisconnected());
    });
  }

  void sendMessage(String text) {
    if (text.isEmpty) {
      debugPrint("⚠️ Tried to send empty message");
      return;
    }

    final tempId = DateTime.now().millisecondsSinceEpoch.toString();

    // 1️⃣ اعمل رسالة Optimistic
    final optimisticMessage = MessageData(
      id: tempId, // id مؤقت
      content: text,
      senderModel: "User",
      createdAt: DateTime.now().toIso8601String(),
      isLocal: true, // 🔥 لازم تضيفيها في الموديل MessageData
    );

    // 2️⃣ ضيفها للـ UI فورًا
    allMessages.add(optimisticMessage);
    emit(GetMessagesSuccessState(messages: List.from(allMessages)));
    debugPrint("🟡 Optimistic message added: $text");

    // 3️⃣ ابعتها للسيرفر ومعاها الـ tempId
    socket.emit("send_message", {
      "content": text,
      "tempId": tempId,
    });

    debugPrint("📤 Message sent to server: $text (tempId: $tempId)");
  }



  // void sendMessage(String text) {
  //   if (text.isEmpty ) return;
  //   socket.emit("send_message", {
  //     "content": text,
  //   });
  // }

  void setTyping(bool typing) {
    socket.emit("typing", {
      "isTyping": typing,
    });
    debugPrint("⌨️ Typing status sent: $typing");
  }

  @override
  Future<void> close() {
    debugPrint("🛑 Closing socket connection...");
    socket.dispose();
    return super.close();
  }
}























// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter/foundation.dart'; // عشان debugPrint
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import '../../services/local/Hive.dart';
// import '../../services/local/HiveLocalService.dart';
// import '../States/States.dart';
// import '../../Repositories/ChatRepository.dart';
// import 'package:smart_college/Models/Response/AllMessagesResponse.dart';
// import 'package:smart_college/services/local/Hive.dart' ;
//
//
// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:meta/meta.dart';
//
// import 'package:socket_io_client/socket_io_client.dart' as IO;
//
//
// class ChatCubit extends Cubit<States> {
//   final ChatLocalService localService;
//   final String chatId;
//   late IO.Socket socket;
//    final String token;
//   //final ChatRepository chatRepository;
//
//   List<MessageData> allMessages = [];
//
//   ChatCubit({required this.localService, required this.chatId, required this.token})
//       : super(ChatInitial());
//
//   /// 🔌 Connect socket
//   void connectSocket() {
//     socket = IO.io(
//       "https://smartcollgeapp-production.up.railway.app",
//       IO.OptionBuilder()
//           .setTransports(['websocket'])
//           .disableAutoConnect()
//           .setAuth({"token": token})
//           .build(),
//     );
//
//     socket.connect();
//
//     socket.onConnect((_) {
//       debugPrint("✅ Socket connected");
//       emit(ChatConnected());
//     });
//
//     socket.onDisconnect((_) {
//       debugPrint("❌ Socket disconnected");
//       emit(ChatDisconnected());
//     });
//
//
//     socket.on("message", (msg) async {
//       final serverMessage = MessageData.fromJson(msg);
//
//       // 📝 خزّن نسخة في Hive
//       await localService.saveMessage(chatId, serverMessage.toLocalMessage());
//
//       // ➕ أضف نسخة API للعرض
//       allMessages.add(serverMessage);
//       emit(GetMessagesSuccessState(messages: List.from(allMessages)));
//     });
//   }
//
//   /// 📥 تحميل الرسائل من التخزين المحلي (Hive)
//   Future<void> loadLocalMessages() async {
//     final localMsgs = await localService.getMessages(chatId);
//
//     allMessages = localMsgs.map((e) => e.toApiMessage()).toList();
//     emit(GetMessagesSuccessState(messages: allMessages));
//   }
//
//   /// 📤 إرسال رسالة (Optimistic UI)
//   void sendMessage(String text) {
//     final tempId = DateTime.now().millisecondsSinceEpoch.toString();
//
//     final optimistic = MessageData(
//       id: tempId,
//       content: text,
//       senderModel: "User",
//       createdAt: DateTime.now().toIso8601String(),
//       isLocal: true,
//       tempId: tempId,
//     );
//
//     // ➕ أضف للـ UI مباشرة
//     allMessages.add(optimistic);
//     emit(GetMessagesSuccessState(messages: List.from(allMessages)));
//
//     // 📝 خزن في Hive
//     localService.saveMessage(chatId, optimistic.toLocalMessage());
//
//     // 📡 ابعت للسيرفر
//     socket.emit("send_message", {
//       "chatId": chatId,
//       "content": text,
//       "tempId": tempId,
//     });
//   }
//
//
//   void setTyping(bool typing) {
//     socket.emit("typing", {
//       "isTyping": typing,
//     });
//   }
//
//   @override
//   Future<void> close() {
//     socket.dispose();
//     return super.close();
//   }
// }
//
//
//
// extension MessageMapper on MessageData {
//   Message toLocalMessage() {
//     return Message(
//       id: id ?? "",
//       content: content ?? "",
//       senderModel: senderModel ?? "User",
//       createdAt: createdAt ?? DateTime.now().toIso8601String(),
//       isLocal: isLocal,
//       tempId: tempId,
//     );
//   }
// }
//
// extension LocalMessageMapper on Message {
//   MessageData toApiMessage() {
//     return MessageData(
//       id: id,
//       chat: null, // دي ممكن تسيبها فاضية لأن الـ Hive مش بيخزن الـ chatId
//       senderModel: senderModel,
//       sender: null, // مش متخزن عندك
//       content: content,
//       readBy: [],
//       createdAt: createdAt,
//       updatedAt: null,
//       isLocal: isLocal,
//       tempId: tempId,
//     );
//   }
// }

