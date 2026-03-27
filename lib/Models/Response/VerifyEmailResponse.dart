class VerifyEmailResponse {
  final bool success;
  final VerifyEmailData data;

  VerifyEmailResponse({
    required this.success,
    required this.data,
  });

  factory VerifyEmailResponse.fromJson(Map<String, dynamic> json) {
    return VerifyEmailResponse(
      success: json['success'],
      data: VerifyEmailData.fromJson(json['data']),
    );
  }
}

class VerifyEmailData {
  final String message;
  final String token;
  final User user;

  VerifyEmailData({
    required this.message,
    required this.token,
    required this.user,
  });

  factory VerifyEmailData.fromJson(Map<String, dynamic> json) {
    return VerifyEmailData(
      message: json['message'],
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final String? baseImage64;
  final bool isVerified;
  final String role;
  final int? level;
  final String? department;
  final bool isNew;
  final bool isOnline;
  final String lastSeen;
  final String updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.baseImage64,
    required this.isVerified,
    required this.role,
    required this.level,
    required this.department,
    required this.isNew,
    required this.isOnline,
    required this.lastSeen,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      baseImage64: json['BaseImage64'],
      isVerified: json['isVerified'],
      role: json['role'],
      level: json['level'],
      department: json['department'],
      isNew: json['isNew'],
      isOnline: json['isOnline'],
      lastSeen: json['lastSeen'],
      updatedAt: json['updatedAt'],
    );
  }
}
