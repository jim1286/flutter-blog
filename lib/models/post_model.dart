class PostModel {
  final String id, title, content, createdAt, updatedAt;
  final String? subTitle;

  PostModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        subTitle = json['subTitle'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];
}
