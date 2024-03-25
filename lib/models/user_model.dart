class UserModel {
  final String userId, userName;

  UserModel.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        userName = json['userName'];
}
