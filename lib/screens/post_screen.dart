import 'package:flutter/material.dart';
import 'package:flutter_blog/proviers/post_provider.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {
  final String postId;

  const PostScreen({super.key, required this.postId});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PostProvider>(context, listen: false)
          .getPostByPostId(widget.postId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.green,
        ),
        body: Consumer<PostProvider>(builder: (context, ref, child) {
          return ref.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ref.post != null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(ref.post!.title),
                          if (ref.post!.subTitle != null)
                            Text(ref.post!.subTitle as String),
                          Text(ref.post!.content)
                        ],
                      ),
                    )
                  : const Text("Empty");
        }));
  }
}
