import 'package:flutter/material.dart';
import 'package:flutter_blog/services/user_service.dart';
import 'package:flutter_blog/widgets/input_widget.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final idController = TextEditingController();
  final pwController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future _printLatestValue() async {
    final userName = idController.text;
    final password = pwController.text;
    Map<String, String> body = {'userName': userName, 'password': password};

    try {
      var res = await UserService().signUp(body);
      print(res);
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
            InputWidget(formType: '아이디', controller: idController),
            const SizedBox(height: 10),
            InputWidget(formType: '비밀번호', controller: pwController),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: const BoxDecoration(color: Colors.black),
              child: Center(
                child: GestureDetector(
                  onTap: () => _printLatestValue(),
                  child: const Text(
                    "회원가입",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
