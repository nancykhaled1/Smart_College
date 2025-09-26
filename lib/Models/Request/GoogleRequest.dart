class GoogleLoginRequest {
  final String idToken;
  final String role;

  GoogleLoginRequest({required this.idToken, required this.role});

  Map<String, dynamic> toJson() {
    return {
      "idToken": idToken,
      "role": role,
    };
  }
}
