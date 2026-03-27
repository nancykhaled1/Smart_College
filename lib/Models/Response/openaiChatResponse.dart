// OpenAI Chat Response Model

class OpenAIChatResponse {
  final bool success;
  final String data;
  final Usage usage;

  OpenAIChatResponse({
    required this.success,
    required this.data,
    required this.usage,
  });

  factory OpenAIChatResponse.fromJson(Map<String, dynamic> json) {
    // Handle data field - it might be a string directly or need extraction
    String dataString = '';
    if (json['data'] != null) {
      if (json['data'] is String) {
        dataString = json['data'] as String;
      } else if (json['data'] is List && (json['data'] as List).isNotEmpty) {
        // If data is a list, try to extract the content from the first element
        final firstItem = (json['data'] as List)[0];
        if (firstItem is Map) {
          if (firstItem['content'] != null) {
            dataString = firstItem['content'].toString();
          } else if (firstItem['message'] != null && firstItem['message'] is Map) {
            dataString = (firstItem['message'] as Map)['content']?.toString() ?? '';
          } else {
            dataString = '';
          }
        } else {
          dataString = firstItem.toString();
        }
      } else {
        dataString = json['data'].toString();
      }
    }

    return OpenAIChatResponse(
      success: json['success'] ?? false,
      data: dataString,
      usage: Usage.fromJson((json['usage'] as Map<String, dynamic>?) ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data,
      'usage': usage.toJson(),
    };
  }
}

class Usage {
  final int promptTokens;
  final int completionTokens;
  final int totalTokens;
  final double cost;
  final bool isByok;
  final PromptTokensDetails promptTokensDetails;
  final CostDetails costDetails;
  final CompletionTokensDetails completionTokensDetails;

  Usage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
    required this.cost,
    required this.isByok,
    required this.promptTokensDetails,
    required this.costDetails,
    required this.completionTokensDetails,
  });

  factory Usage.fromJson(Map<String, dynamic> json) {
    return Usage(
      promptTokens: (json['prompt_tokens'] is int) ? json['prompt_tokens'] as int : ((json['prompt_tokens'] as num?)?.toInt() ?? 0),
      completionTokens: (json['completion_tokens'] is int) ? json['completion_tokens'] as int : ((json['completion_tokens'] as num?)?.toInt() ?? 0),
      totalTokens: (json['total_tokens'] is int) ? json['total_tokens'] as int : ((json['total_tokens'] as num?)?.toInt() ?? 0),
      cost: (json['cost'] is num) ? (json['cost'] as num).toDouble() : 0.0,
      isByok: json['is_byok'] ?? false,
      promptTokensDetails: PromptTokensDetails.fromJson(
        (json['prompt_tokens_details'] is Map<String, dynamic>) ? json['prompt_tokens_details'] as Map<String, dynamic> : {},
      ),
      costDetails: CostDetails.fromJson(
        (json['cost_details'] is Map<String, dynamic>) ? json['cost_details'] as Map<String, dynamic> : {},
      ),
      completionTokensDetails: CompletionTokensDetails.fromJson(
        (json['completion_tokens_details'] is Map<String, dynamic>) ? json['completion_tokens_details'] as Map<String, dynamic> : {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prompt_tokens': promptTokens,
      'completion_tokens': completionTokens,
      'total_tokens': totalTokens,
      'cost': cost,
      'is_byok': isByok,
      'prompt_tokens_details': promptTokensDetails.toJson(),
      'cost_details': costDetails.toJson(),
      'completion_tokens_details': completionTokensDetails.toJson(),
    };
  }
}

class PromptTokensDetails {
  final int cachedTokens;
  final int audioTokens;
  final int videoTokens;

  PromptTokensDetails({
    required this.cachedTokens,
    required this.audioTokens,
    required this.videoTokens,
  });

  factory PromptTokensDetails.fromJson(Map<String, dynamic> json) {
    return PromptTokensDetails(
      cachedTokens: (json['cached_tokens'] is int) ? json['cached_tokens'] as int : ((json['cached_tokens'] as num?)?.toInt() ?? 0),
      audioTokens: (json['audio_tokens'] is int) ? json['audio_tokens'] as int : ((json['audio_tokens'] as num?)?.toInt() ?? 0),
      videoTokens: (json['video_tokens'] is int) ? json['video_tokens'] as int : ((json['video_tokens'] as num?)?.toInt() ?? 0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cached_tokens': cachedTokens,
      'audio_tokens': audioTokens,
      'video_tokens': videoTokens,
    };
  }
}

class CostDetails {
  final double? upstreamInferenceCost;
  final double upstreamInferencePromptCost;
  final double upstreamInferenceCompletionsCost;

  CostDetails({
    this.upstreamInferenceCost,
    required this.upstreamInferencePromptCost,
    required this.upstreamInferenceCompletionsCost,
  });

  factory CostDetails.fromJson(Map<String, dynamic> json) {
    return CostDetails(
      upstreamInferenceCost: json['upstream_inference_cost'] != null
          ? (json['upstream_inference_cost'] as num).toDouble()
          : null,
      upstreamInferencePromptCost:
          (json['upstream_inference_prompt_cost'] ?? 0).toDouble(),
      upstreamInferenceCompletionsCost:
          (json['upstream_inference_completions_cost'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'upstream_inference_cost': upstreamInferenceCost,
      'upstream_inference_prompt_cost': upstreamInferencePromptCost,
      'upstream_inference_completions_cost': upstreamInferenceCompletionsCost,
    };
  }
}

class CompletionTokensDetails {
  final int reasoningTokens;
  final int imageTokens;

  CompletionTokensDetails({
    required this.reasoningTokens,
    required this.imageTokens,
  });

  factory CompletionTokensDetails.fromJson(Map<String, dynamic> json) {
    return CompletionTokensDetails(
      reasoningTokens: (json['reasoning_tokens'] is int) ? json['reasoning_tokens'] as int : ((json['reasoning_tokens'] as num?)?.toInt() ?? 0),
      imageTokens: (json['image_tokens'] is int) ? json['image_tokens'] as int : ((json['image_tokens'] as num?)?.toInt() ?? 0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reasoning_tokens': reasoningTokens,
      'image_tokens': imageTokens,
    };
  }
}

