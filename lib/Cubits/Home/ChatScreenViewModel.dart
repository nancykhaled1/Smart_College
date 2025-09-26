import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../services/local/sharedPreference.dart';
import '../States/States.dart';
import '../../Repositories/ChatRepository.dart';
import '../../Models/Response/AllMessagesResponse.dart';

class ChatCubit extends Cubit<States> {
  late IO.Socket socket;
  final String token;
  String? chatId; // خليها متغيرة مش final
  final ChatRepository chatRepository;

  List<MessageData> allMessages = [];
  bool isConnected = false;

  ChatCubit({
    required this.token,
    required this.chatRepository,
  }) : super(ChatInitial());

  void _connectSocket() {
    emit(ChatConnecting());

    socket = IO.io(
      "https://smartcollgeapp-production.up.railway.app",
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setAuth({"token": token})
          .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      isConnected = true;
      emit(ChatConnected());

      // ✅ دلوقتي chatId متظبط من getAllMessages
      socket.emit("join_chat", {
        "chatId": chatId,
      });
    });

    socket.on("chat_history", (data) {
      allMessages = (data as List).map((e) => MessageData.fromJson(e)).toList();
      emit(GetMessagesSuccessState(messages: allMessages));
    });

    socket.on("message", (msg) {
      allMessages.add(MessageData.fromJson(msg));
      emit(GetMessagesSuccessState(messages: List.from(allMessages)));
    });

    socket.onDisconnect((_) {
      isConnected = false;
      emit(ChatDisconnected());
    });
  }

  void sendMessage(String text) {
    if (text.isEmpty || chatId == null) return;
    socket.emit("send_message", {
      "chatId": chatId,
      "content": text,
    });
  }

  void setTyping(bool typing) {
    if (chatId == null) return;
    socket.emit("typing", {
      "chatId": chatId,
      "isTyping": typing,
    });
  }

  @override
  Future<void> close() {
    socket.dispose();
    return super.close();
  }

  /// ✅ استدعاء API للرسائل القديمة
  Future<void> getAllMessages() async {
    emit(LoadingState(loadingMessage: "جارى تحميل الرسائل..."));

    var either = await chatRepository.getMessages();

    either.fold(
          (failure) {
        emit(ErrorState(errorMessage: failure.error?.message ?? "حدث خطأ"));
      },
          (response) async {
        allMessages = response.data ?? [];

        if (allMessages.isNotEmpty) {
          chatId = allMessages.first.chat; // ✅ خزّني chatId هنا
          await TokenStorage.saveChat(chatId!);

          // بعد ما جهزنا chatId نعمل اتصال
          _connectSocket();
        }

        emit(GetMessagesSuccessState(messages: allMessages));
      },
    );
  }
}














