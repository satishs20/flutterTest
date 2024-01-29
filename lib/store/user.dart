import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../class/user_detail_entity.dart'; // Add this import for JSON encoding and decoding

class SharedPreferencesService {
  static const String key = 'user';

  // Save the custom object to SharedPreferences
  static Future<void> saveUser(UserDetailEntity user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = json.encode(user.toJson()); // Convert JSON to string
    await prefs.setString(key, userJson);
  }

  // Retrieve the custom object from SharedPreferences
  static Future<UserDetailEntity?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(key);

    if (userJson != null) {
      // Parse the JSON string into a Map before calling fromJson
      final userMap = json.decode(userJson) as Map<String, dynamic>;
      return UserDetailEntity.fromJson(userMap);
    } else {
      return null;
    }
  }

  static Future<bool> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    return true;
  }
}
