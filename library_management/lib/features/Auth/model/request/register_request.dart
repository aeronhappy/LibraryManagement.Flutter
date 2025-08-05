class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final List<String> rolesId;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.rolesId,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRequest(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      rolesId: List<String>.from(json['rolesId']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'rolesId': rolesId,
    };
  }
}
