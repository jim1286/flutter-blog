import 'dart:convert';
import 'package:flutter_blog/models/token_model.dart';
import 'package:flutter_blog/models/user_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String baseUrl = dotenv.get("BASE_URI");

class UserService {
  static const String basePath = '/user';
  final Map<String, String> headers = {'Content-Type': 'application/json'};

  Future<String> signUp(Map<String, String> body) async {
    final url = Uri.parse(('$baseUrl$basePath/signup'));
    final response =
        await http.post(url, headers: headers, body: json.encode(body));

    if (response.statusCode == 201) {
      return response.body;
    }

    throw Exception(response.body);
  }

  Future<TokenModel> signIn(Map<String, String> body) async {
    final url = Uri.parse(('$baseUrl$basePath/signin'));
    final response =
        await http.post(url, headers: headers, body: json.encode(body));

    if (response.statusCode == 201) {
      final token = jsonDecode(response.body);
      return TokenModel.fromJson(token);
    }

    throw Exception(response.body);
  }

  Future<UserModel> getUser() async {
    final url = Uri.parse(('$baseUrl$basePath'));

    final pref = await SharedPreferences.getInstance();
    final accessToken = pref.getString('accessToken');

    if (accessToken != null) {
      headers["Authorization"] = 'Bearer $accessToken';
    }

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final user = jsonDecode(response.body);
      return UserModel.fromJson(user);
    }

    throw Exception(response.body);
  }
}
