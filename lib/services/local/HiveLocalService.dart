import 'package:hive/hive.dart';

import '../../Models/Response/AllMessagesResponse.dart';
import 'Hive.dart';

class ChatLocalService {
  Future<void> saveMessage(String chatId, Message message) async {
  final box = await Hive.openBox<Message>('messages_$chatId');
  await box.put(message.id, message);
  }

  Future<List<Message>> getMessages(String chatId) async {
  final box = await Hive.openBox<Message>('messages_$chatId');
  return box.values.toList();
  }
  }


