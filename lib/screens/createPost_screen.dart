import 'package:flutter/material.dart';
import 'package:flutter_blog/proviers/post_provider.dart';
import 'package:flutter_blog/services/post_service.dart';
import 'package:flutter_blog/widgets/input_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
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
    await PostService().createPost(body);
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);

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
              onTap: () async {
                try {
                  await _createPost();

                  postProvider.getAllPostList();
                  context.pop();
                } catch (e) {
                  print(e);
                }
              },
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
