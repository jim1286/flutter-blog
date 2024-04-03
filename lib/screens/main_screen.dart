import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blog/proviers/post_provider.dart';
import 'package:flutter_blog/widgets/button_widget.dart';
import 'package:flutter_blog/widgets/postCard_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late SharedPreferences pref;

  Future initPref() async {
    pref = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();

    initPref();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PostProvider>(context, listen: false).getAllPostList();
    });
  }

  void _logout() {
    pref.remove('accessToken');
    pref.remove('refreshToken');
    context.go('/login');
  }

  void _navigateToCreatePostScreen() {
    context.go('/post/create');
  }

  void _navigateToPostScreen(String postId) {
    context.go('/post/$postId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          "메인 페이지",
          style: TextStyle(
              color: Colors.green, fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
      body: Consumer<PostProvider>(
        builder: (context, ref, child) {
          return Column(
            children: [
              const SizedBox(height: 30),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonWidget(
                          callback: _navigateToCreatePostScreen,
                          buttonText: "글 작성",
                          buttonColor: Colors.blue,
                        ),
                        const SizedBox(width: 10),
                        ButtonWidget(
                          callback: _logout,
                          buttonText: "로그아웃",
                          buttonColor: Colors.red,
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    ref.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ref.postList != null
                            ? SizedBox(
                                width: 400,
                                height: 400,
                                child: ListView.separated(
                                  itemCount: ref.postList!.length,
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  itemBuilder: (context, index) {
                                    var post = ref.postList![index];

                                    return PostCardWidget(
                                      id: post.id,
                                      title: post.title,
                                      content: post.content,
                                      subTitle: post.subTitle,
                                      callback: _navigateToPostScreen,
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      width: 40,
                                    );
                                  },
                                ))
                            : const Text("Empty")
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
