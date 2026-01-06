import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_college/Cubits/States/States.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatCubit extends Cubit<ChatStates> {
  IO.Socket? socket;
  final String token;
  final String adminId;
  String? currentChatId;

  // 🧩 الرسائل
  List<MessageModel> messages = [];

  ChatCubit({required this.token, required this.adminId})
      : super(ChatInitialState());

  // 🔌 الاتصال بالسيرفر
  void connectSocket() {
    print("🪪 Token used for socket: $token");

    print("🔌 Connecting socket...");

    socket = IO.io(
      'https://smartcollgeapp-production.up.railway.app',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableForceNew()
          .setAuth({'token': token})
          .build(),
    );

    socket!.onConnect((_) {
      print("✅ Socket connected");
      joinChat();
    });
    socket!.emit('check_connection', {'token': token});
    print("🧠 Sent check_connection to verify token validity");


    socket!.on('chat_history', (data) {
      if (isClosed) return; // ✅ stop if cubit closed
      print("📜 Chat history loaded: ${data['chatId']}");

      currentChatId = data['chatId'];

      final List<MessageModel> history = (data['messages'] as List)
          .map((msg) => MessageModel.fromJson(msg))
          .toList();

      messages = history;
      emit(ChatMessagesUpdated(List.from(messages)));
    });

    socket!.on('message', (msg) {
      if (isClosed) return; // ✅ stop if cubit closed

      final newMsg = MessageModel.fromJson(msg);
      print("💬 New message received: ${newMsg.content}");

      // ✅ امنعي التكرار سواء من send أو من السيرفر
      final exists = messages.any((m) =>
      m.content == newMsg.content &&
          m.senderModel == newMsg.senderModel &&
          (DateTime.parse(m.createdAt!)
              .difference(DateTime.parse(newMsg.createdAt!))
              .inSeconds)
              .abs() <
              2);

      if (!exists) {
        messages.add(newMsg);
        emit(ChatMessagesUpdated(List.from(messages)));
      }
    });

    socket!.onDisconnect((_) {
      print("❌ Socket disconnected");

    });

    socket!.onConnectError((data) {
      print("⚠️ Socket connect error: $data");

    });
  }

  // 📩 الانضمام إلى الشات
  void joinChat() {
    print("📩 Joining chat with admin: $adminId");
    socket?.emit('join_chat', {'adminId': adminId});
  }

  // 📤 إرسال رسالة
  void sendMessage(String content) {
    if (socket == null || !socket!.connected) {
      print("⚠️ Socket not connected");
      return;
    }

    if (currentChatId == null) {
      print("⚠️ No chatId yet, cannot send message");
      return;
    }

    final newMsg = MessageModel(
      chatId: currentChatId,
      content: content,
      senderModel: "User",
      createdAt: DateTime.now().toIso8601String(),
    );

    // ✅ أضيفيها مبدئيًا لكن من غير تكرار
    final exists = messages.any((m) =>
    m.content == newMsg.content &&
        m.senderModel == newMsg.senderModel &&
        (DateTime.parse(m.createdAt!)
            .difference(DateTime.parse(newMsg.createdAt!))
            .inSeconds)
            .abs() <
            2);

    if (!exists) {
      messages.add(newMsg);
      emit(ChatMessagesUpdated(List.from(messages)));
    }

    socket!.emit('send_message', {
      'content': content,
      'chatId': currentChatId,
    });

    print("📤 Message sent: $content (chatId: $currentChatId)");
  }

  // ❌ فصل الاتصال وتنظيف الليسنرز
  void disconnect() {
    print("🔌 Disconnecting socket...");
    if (socket != null) {
      socket!.off('message');
      socket!.off('chat_history');
      socket!.off('connect');
      socket!.off('disconnect');
      socket!.disconnect();
      socket!.dispose();
      socket = null;
    }
    messages.clear();
    emit(ChatInitialState());
  }

  // 🧹 تنظيف بيانات الشات عند اللوج أوت
  void clearChatData() {
    messages.clear();
    currentChatId = null;
    emit(ChatInitialState());
  }

  @override
  Future<void> close() {
    print("🧹 Closing ChatCubit safely...");
    disconnect();
    return super.close();
  }
}

// ----------------------------
// 🧱 States
// ----------------------------
abstract class ChatStates {}

class ChatInitialState extends ChatStates {}

class ChatMessagesUpdated extends ChatStates {
  final List<MessageModel> messages;
  ChatMessagesUpdated(this.messages);
}

// ----------------------------
// 💬 Message Model
// ----------------------------
class MessageModel {
  final String? chatId;
  final String? content;
  final String? senderModel; // "User" or "Admin"
  final String? createdAt;
  final Sender? sender;

  MessageModel({
    this.chatId,
    this.content,
    this.senderModel,
    this.createdAt,
    this.sender,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      chatId: json['chatId']?.toString(),
      content: json['content'] ?? '',
      senderModel: json['senderModel'] ?? '',
      createdAt: json['createdAt'] ?? DateTime.now().toIso8601String(),
      sender: json['sender'] != null ? Sender.fromJson(json['sender']) : null,
    );
  }
}

class Sender {
  final String? id;
  final String? name;

  Sender({this.id, this.name});

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json['_id']?.toString(),
      name: json['name'] ?? '',
    );
  }
}
