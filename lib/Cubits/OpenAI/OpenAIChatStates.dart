abstract class OpenAIChatStates {}

class OpenAIChatInitialState extends OpenAIChatStates {}

class OpenAIChatLoadingState extends OpenAIChatStates {}

class OpenAIChatErrorState extends OpenAIChatStates {
  final String errorMessage;
  OpenAIChatErrorState({required this.errorMessage});
}

class OpenAIChatMessagesState extends OpenAIChatStates {
  final List<OpenAIChatMessage> messages;
  final bool isLoading;
  OpenAIChatMessagesState({required this.messages, this.isLoading = false});
}

// Message model for OpenAI chat
class OpenAIChatMessage {
  final String content;
  final bool isUser;
  final DateTime timestamp;

  OpenAIChatMessage({
    required this.content,
    required this.isUser,
    required this.timestamp,
  });
}

