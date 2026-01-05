import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_college/Cubits/OpenAI/OpenAIChatStates.dart';
import 'package:smart_college/Repositories/OpenAIChatRepository.dart';

class OpenAIChatCubit extends Cubit<OpenAIChatStates> {
  final OpenAIChatRepository repository;
  List<OpenAIChatMessage> messages = [];

  OpenAIChatCubit(this.repository) : super(OpenAIChatInitialState()) {
    // Initialize with empty messages list
    emit(OpenAIChatMessagesState(messages: messages));
  }

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    // Add user message to the list immediately
    final userMessage = OpenAIChatMessage(
      content: message.trim(),
      isUser: true,
      timestamp: DateTime.now(),
    );
    messages.add(userMessage);
    emit(OpenAIChatMessagesState(messages: List.from(messages), isLoading: true));

    // Send to API
    final response = await repository.sendChatMessage(message);

    response.fold(
      (error) {
        // Remove the user message since it failed to send
        if (messages.isNotEmpty && messages.last.isUser) {
          messages.removeLast();
        }
        // Emit error state first (will be handled by BlocListener for SnackBar)
        emit(OpenAIChatErrorState(
          errorMessage: error.error?.message ?? "حدث خطأ أثناء إرسال الرسالة",
        ));
        // Then emit messages state so UI continues showing conversation
        emit(OpenAIChatMessagesState(
          messages: messages,
          isLoading: false,
        ));
      },
      (chatResponse) {
        // Add AI response to the list
        final aiMessage = OpenAIChatMessage(
          content: chatResponse.data,
          isUser: false,
          timestamp: DateTime.now(),
        );
        messages.add(aiMessage);
        emit(OpenAIChatMessagesState(messages: List.from(messages), isLoading: false));
      },
    );
  }

  void clearMessages() {
    messages.clear();
    emit(OpenAIChatMessagesState(messages: messages));
  }
}

