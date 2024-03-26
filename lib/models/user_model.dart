class UserModel {
  final String id, userName;

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userName = json['userName'];
}
