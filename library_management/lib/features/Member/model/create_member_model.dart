class CreateMemberModel {
  final String name;
  final String email;

  CreateMemberModel({required this.name, required this.email});

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email};
  }
}
