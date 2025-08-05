class RoleModel {
  final String id;
  final String name;

  RoleModel({required this.id, required this.name});

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(id: json['id'] as String, name: json['name'] as String);
  }

  static RoleModel fromMap(Map<String, dynamic> map) => RoleModel.fromJson(map);
}
