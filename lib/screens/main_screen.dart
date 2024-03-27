import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blog/proviers/post.provider.dart';
import 'package:flutter_blog/widgets/button_widget.dart';
import 'package:flutter_blog/widgets/postCard_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  late SharedPreferences pref;

  Future initPref() async {
    pref = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();

    initPref();
  }

  void _logout() {
    pref.remove('accessToken');
    pref.remove('refreshToken');
    context.go('/login');
  }

  void _navigateToCreatePostScreen() {
    context.go('/post/create');
  }

  @override
  Widget build(BuildContext context) {
    final postList = ref.watch(postListProvider);

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
      body: Column(
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
                postList.when(
                  data: (postList) {
                    if (postList.isEmpty) {
                      return const Text('empty');
                    }

                    return SizedBox(
                      width: 400,
                      height: 400,
                      child: ListView.separated(
                        itemCount: postList.length,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        itemBuilder: (context, index) {
                          var post = postList[index];

                          return PostCardWidget(
                            title: post.title,
                            content: post.content,
                            subTitle: post.subTitle,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 40,
                          );
                        },
                      ),
                    );
                  },
                  error: (error, stack) => const Center(child: Text("error")),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
