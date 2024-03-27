import 'package:flutter/material.dart';

class PostCardWidget extends StatelessWidget {
  final String id, title, content;
  final String? subTitle;
  final void Function(String) callback;

  const PostCardWidget(
      {super.key,
      required this.id,
      required this.title,
      required this.content,
      required this.callback,
      this.subTitle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(id),
      child: Container(
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
      ),
    );
  }
}
