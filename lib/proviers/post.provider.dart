import 'package:flutter_blog/models/post_model.dart';
import 'package:flutter_blog/services/post_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postListProvider = FutureProvider.autoDispose<List<PostModel>>(
    (ref) => PostService().getAllPostList());
