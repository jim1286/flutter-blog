import 'package:flutter/material.dart';
import 'package:flutter_blog/models/post_model.dart';
import 'package:flutter_blog/services/post_service.dart';

class PostProvider with ChangeNotifier {
  bool isLoading = false;
  final _postService = PostService();

  PostModel? _post;
  List<PostModel>? _postList;

  PostModel? get post => _post;
  List<PostModel>? get postList => _postList;

  getAllPostList() async {
    isLoading = true;
    _postList = await _postService.getAllPostList();
    isLoading = false;
    notifyListeners();
  }

  getPostByPostId(String postId) async {
    isLoading = true;
    _post = await _postService.getPostById(postId);
    isLoading = false;
    notifyListeners();
  }
}
