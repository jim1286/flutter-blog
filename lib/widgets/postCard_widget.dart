import 'package:flutter/material.dart';

class PostCardWidget extends StatelessWidget {
  final String title, content;
  final String? subTitle;
  final VoidCallback? callback;

  const PostCardWidget(
      {super.key,
      required this.title,
      required this.content,
      this.callback,
      this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          Text(content),
          if (subTitle != null) Text(subTitle as String),
        ],
      ),
    );
  }
}
