import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback callback;
  final String buttonText;
  final Color buttonColor;

  const ButtonWidget({
    super.key,
    required this.callback,
    required this.buttonText,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(),
      child: Container(
        decoration: BoxDecoration(
          color: buttonColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            buttonText,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}
