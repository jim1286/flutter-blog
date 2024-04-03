import 'dart:convert';
import 'package:flutter_blog/models/post_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String baseUrl = dotenv.get("BASE_URI");

class PostService {
  static const String basePath = '/post';
  final Map<String, String> headers = {'Content-Type': 'application/json'};

  Future<String> createPost(Map<String, String> body) async {
    final url = Uri.parse(('$baseUrl$basePath'));
    final pref = await SharedPreferences.getInstance();
    final accessToken = pref.getString('accessToken');

    if (accessToken != null) {
      headers["Authorization"] = 'Bearer $accessToken';
    }

    final response =
        await http.post(url, headers: headers, body: json.encode(body));

    if (response.statusCode == 201) {
      return response.body;
    }

    throw Exception(response.body);
  }

  Future<List<PostModel>> getAllPostList() async {
    final url = Uri.parse(('$baseUrl$basePath/postList/all'));
    final pref = await SharedPreferences.getInstance();
    final accessToken = pref.getString('accessToken');

    if (accessToken != null) {
      headers["Authorization"] = 'Bearer $accessToken';
    }

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final posts = jsonDecode(response.body);

      return posts
          .map<PostModel>((model) => PostModel.fromJson(model))
          .toList();
    }

    throw Exception(response.body);
  }

  Future<PostModel> getPostById(String postId) async {
    final url = Uri.parse(('$baseUrl$basePath/$postId'));
    final pref = await SharedPreferences.getInstance();
    final accessToken = pref.getString('accessToken');

    if (accessToken != null) {
      headers["Authorization"] = 'Bearer $accessToken';
    }

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final post = jsonDecode(response.body);

      return PostModel.fromJson(post);
    }

    throw Exception(response.body);
  }
}
