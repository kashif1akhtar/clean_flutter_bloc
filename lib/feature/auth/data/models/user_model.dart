import 'package:clean_arch/core/error/failures.dart';

import '../../domain/entities/user.dart';

class UserModel extends User {
  final String? firstName;
  final String? lastName;
  final String? loginToken;
  final String? role;
  final String? photo;
  final String? languagePreference;
  final bool? isProfileCompleted;
  final String? lastLogin;

  UserModel({
    required String? id, // Changed to nullable
    required String? email, // Changed to nullable
    this.firstName,
    this.lastName,
    this.loginToken,
    this.role,
    this.photo,
    this.languagePreference,
    this.isProfileCompleted,
    this.lastLogin,
  }) : super(id: id!, email: email!);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    if (data == null) {
      throw Failure('Invalid response: data is null');
    }
    if (data['id'] == null || data['email'] == null) {
      throw Failure('Invalid response: id or email is missing');
    }

    return UserModel(
      id: data['id'] as String,
      email: data['email'] as String,
      firstName: data['first_name'] as String?,
      lastName: data['last_name'] as String?,
      loginToken: data['loginToken'] as String?,
      role: data['role'] as String?,
      photo: data['photo'] as String?,
      languagePreference: data['language_preference'] as String?,
      isProfileCompleted: data['is_profile_completed'] as bool?,
      lastLogin: data['last_login'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'loginToken': loginToken,
      'role': role,
      'photo': photo,
      'language_preference': languagePreference,
      'is_profile_completed': isProfileCompleted,
      'last_login': lastLogin,
    };
  }
}