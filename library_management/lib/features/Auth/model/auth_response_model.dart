class AuthResponseModel {
  final bool isSuccess;
  final String? accessToken;
  final String? message;
  final List<String> roles;

  const AuthResponseModel({
    required this.isSuccess,
    this.accessToken,
    this.message,
    required this.roles,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      isSuccess: (json['isSuccess'] as bool?) ?? false,
      accessToken: json['accessToken'] as String?,
      message: json['message'] as String?,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
    );
  }

  Map<String, dynamic> toJson() => {
    'isSuccess': isSuccess,
    'accessToken': accessToken,
    'message': message,
    'roles': roles,
  };
}
