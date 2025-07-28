class AuthResponseModel {
  final bool isSuccess;
  final String? accessToken;
  final String? message;

  AuthResponseModel({
    required this.isSuccess,
    required this.accessToken,
    required this.message,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      isSuccess: json['isSuccess'] as bool,
      accessToken: json['accessToken'] != null
          ? json['accessToken'] as String
          : null,
      message: json['message'] != null ? json['message'] as String : null,
    );
  }

  static AuthResponseModel fromMap(Map<String, dynamic> map) =>
      AuthResponseModel.fromJson(map);
}
