import 'package:flutter/material.dart';
import 'package:flutter_blog/services/user_service.dart';
import 'package:flutter_blog/widgets/input_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final idController = TextEditingController();
  final pwController = TextEditingController();
  late SharedPreferences pref;

  Future initPref() async {
    pref = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    initPref();
  }

  Future _printLatestValue() async {
    final userName = idController.text;
    final password = pwController.text;

    Map<String, String> body = {'userName': userName, 'password': password};

    try {
      var token = await UserService().signIn(body);
      await pref.setString('accessToken', token.accessToken);
      await pref.setString('refreshToken', token.refreshToken);

      context.go('/');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InputWidget(formType: '아이디', controller: idController),
            const SizedBox(height: 10),
            InputWidget(formType: '비밀번호', controller: pwController),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => _printLatestValue(),
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: const BoxDecoration(color: Colors.black),
                child: const Center(
                  child: Text(
                    "로그인",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("아이디가 없으신가요?"),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      context.push('/signUp');
                    },
                    child: const Text(
                      "회원가입",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
