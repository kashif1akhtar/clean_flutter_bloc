import 'package:equatable/equatable.dart';

class UserRequestModel extends Equatable {
  final String email;
  final String password;

  UserRequestModel({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  @override
  List<Object> get props => [email, password];
}