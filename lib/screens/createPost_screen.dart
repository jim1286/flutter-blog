import 'package:flutter/material.dart';
import 'package:flutter_blog/proviers/post.provider.dart';
import 'package:flutter_blog/services/post_service.dart';
import 'package:flutter_blog/widgets/input_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  late SharedPreferences pref;

  @override
  void initState() {
    super.initState();
  }

  Future _createPost() async {
    final title = titleController.text;
    final content = contentController.text;

    Map<String, String> body = {'title': title, 'content': content};

    try {
      await PostService().createPost(body);
      ref.invalidate(postListProvider);
      context.pop();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InputWidget(formType: '제목', controller: titleController),
            const SizedBox(height: 10),
            InputWidget(formType: '본문', controller: contentController),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => _createPost(),
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: const BoxDecoration(color: Colors.black),
                child: const Center(
                  child: Text(
                    "등록",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
