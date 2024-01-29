import 'dart:convert' as convert;
import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../class/user_detail_entity.dart';
import '../store/user.dart';

class FirebaseAuthentication {
  FirebaseAuthentication(this.client);
  final http.Client client;

  Future<UserDetailEntity?> registerWithEmailAndPassword(String email, String displayName, String password) async {
    const apiKey = 'AIzaSyBr3XfPEXp0hxB1cZRMEnRVWoymaIWm4fw'; // Replace with your Firebase Web API Key
    const endpoint = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$apiKey';

    final data = <String, dynamic>{
      'email': email,
      'password': password,
      'displayName': displayName,
      'returnSecureToken': true,
    };

    final response = await client.post(
      Uri.parse(endpoint),
      body: convert.jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    log(response.request.toString());

    log(response.body);
    final responseData = convert.jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      print('User registered successfully. User ID: ${responseData["localId"]}');
      // Save user to SharedPreferences
      final userDetail = UserDetailEntity.fromJson(responseData);

      return userDetail;
    } else {
      await Fluttertoast.showToast(msg: '${responseData["error"]["message"]}');
      print('Error during registration: ${responseData["error"]["message"]}');
      return null; // Handle sign-in error
    }
  }

  Future<UserDetailEntity?> signInWithEmailAndPassword(String email, String password) async {
    const apiKey = 'AIzaSyBr3XfPEXp0hxB1cZRMEnRVWoymaIWm4fw'; // Replace with your Firebase Web API Key
    const endpoint = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$apiKey';

    final data = <String, dynamic>{
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final response = await client.post(
      Uri.parse(endpoint),
      body: convert.jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    log(response.request.toString());
    log(response.body);
    final responseData = convert.jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      print('User signed in successfully. User ID: ${responseData["localId"]}');
      // Save user to SharedPreferences
      final userDetail = UserDetailEntity.fromJson(responseData);

      return userDetail;
    } else {
      // await Fluttertoast.showToast(msg: '${responseData["error"]["message"]}');
      // print('Error during sign-in: ${responseData["error"]["message"]}');
      print('User signed in failed.');
      return null; // Handle sign-in error
    }
  }

  Future<void> saveData(UserDetailEntity userDetailEntity) async => SharedPreferencesService.saveUser(userDetailEntity);
}
