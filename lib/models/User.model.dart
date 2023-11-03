class UserModel {
  String email;
  String name;
  String taxId;
  String role;
  int hospitalUnit;

  UserModel({
    required this.email,
    required this.name,
    required this.taxId,
    required this.role,
    required this.hospitalUnit,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'taxId': taxId,
      'role': role,
      'hospitalUnit': hospitalUnit,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      name: json['name'],
      taxId: json['taxId'],
      role: json['role'],
      hospitalUnit: json['hospitalUnit'],
    );
  }
}
