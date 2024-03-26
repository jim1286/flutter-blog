import 'package:flutter/material.dart';
import 'package:flutter_blog/models/post_model.dart';
import 'package:flutter_blog/services/post_service.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Future<List<PostModel>> postList;
  late SharedPreferences pref;

  Future initPref() async {
    pref = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();

    postList = PostService().getAllPostList();
    initPref();
  }

  void _logout() {
    pref.remove('accessToken');
    pref.remove('refreshToken');
    context.go('/login');
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
      body: Column(
        children: [
          const SizedBox(height: 30),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => _logout(),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "로그아웃",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              FutureBuilder(
                future: postList,
                builder: (context, snapshot) {
                  print(snapshot.data);
                  if (snapshot.hasData) {
                    return Column(children: [
                      for (var post in snapshot.data!) Text(post.title)
                    ]);
                  }

                  return const Text('...');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
