import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const String _tokenKey = "auth_token";
  static const String _userIdKey = "user_id";
  static const String _roleKey = "user_role";
  static const String _convIdKey = "conversation_id";
  static const String _IsNewKey = "true";
  static const String _chatKey = "chat";
  static const String _key = 'notifications_enabled';


  ///////////////notification///////////////
  static Future<void> saveNotificationPreference(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', enabled);
  }

  static Future<bool> getNotificationPreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('notifications_enabled') ?? true; // الافتراضى: مفتوح
  }





  // حفظ التوكن
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<void> saveId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
    }

  static Future<void> saveRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_roleKey, role);
  }

  // حفظ conversationId
  static Future<void> saveConvId(String convId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_convIdKey, convId);
  }

  // حفظ isNew
  static Future<void> saveIsNew(bool isNew) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_IsNewKey, isNew);
  }

  // حفظ chat
  static Future<void> saveChat(String chat) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_chatKey, chat);
  }


  static Future<String?> getChat() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_chatKey);
  }
  // استرجاع التوكن
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // استرجاع الـ userId
  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_roleKey);
  }

  // استرجاع الـ conversationId
  static Future<String?> getConvId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_convIdKey);
  }

  static Future<bool?> getIsNew() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_IsNewKey);
  }

  // مسح كل الداتا (مثلا عند اللوج آوت)
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }



}
