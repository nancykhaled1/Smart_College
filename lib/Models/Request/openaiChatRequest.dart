// OpenAI Chat Request Model

class OpenAIChatRequest {
  final String prompt;

  OpenAIChatRequest({required this.prompt});

  Map<String, dynamic> toJson() {
    return {
      'prompt': prompt,
    };
  }
}

