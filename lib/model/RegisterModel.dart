class UserModel {
  final int? id;
  final String name;
  final String email;
  final String password;
  final String? role;
  final String? avatar;
  final DateTime? creationAt;
  final DateTime? updatedAt;
  final String? message;
  final String? access_token;
  final  String? refresh_token;

  UserModel({
    this.message,
    this.access_token,
    this.refresh_token,
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.role,
    this.avatar,
    this.creationAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      message: json['message'],
      access_token: json['access_token'],
      refresh_token: json['refresh_token'],
      role: json['role'],
      avatar: json['avatar'],
      creationAt: json['creationAt'] != null
          ? DateTime.tryParse(json['creationAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token':access_token,
      'refresh_token':refresh_token,
      'message':message,
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'avatar': avatar,
      'creationAt': creationAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
