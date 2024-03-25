import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final String formType;
  final TextEditingController controller;

  const InputWidget(
      {super.key, required this.formType, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        obscureText: formType == 'password',
        decoration: InputDecoration(
          labelText: formType == 'userName' ? "아이디" : "비밀번호",
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue)),
        ),
      ),
    );
  }
}
