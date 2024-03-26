import 'dart:convert';
import 'package:flutter_blog/models/post_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String baseUrl = dotenv.get("BASE_URI");

class PostService {
  static const String basePath = '/post';
  final Map<String, String> headers = {'Content-Type': 'application/json'};

  Future<List<PostModel>> getAllPostList() async {
    final url = Uri.parse(('$baseUrl$basePath/postList/all'));

    final pref = await SharedPreferences.getInstance();
    final accessToken = pref.getString('accessToken');
    final List<PostModel> postList = [];

    if (accessToken != null) {
      headers["Authorization"] = 'Bearer $accessToken';
    }

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final models = jsonDecode(response.body);

      for (var model in models) {
        postList.add(PostModel.fromJson(model));
      }
      return postList;
    }

    throw Exception(response.body);
  }
}
