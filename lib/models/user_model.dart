import 'dart:io';

class User {
  final String? id;
  String? name;
  String? email;
  String? password;
  String? confirmPassword;
  File? avatar;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.confirmPassword,
    this.avatar
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name' : name,
      'email' : email,
      'password' : password,
      'password_confirmation': confirmPassword,
      'avatar': avatar
    };
  }
}