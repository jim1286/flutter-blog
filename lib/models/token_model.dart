class TokenModel {
  final String accessToken, refreshToken;

  TokenModel.fromJson(Map<String, dynamic> json)
      : accessToken = json['accessToken'],
        refreshToken = json['refreshToken'];
}
