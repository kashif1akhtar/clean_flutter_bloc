import 'dart:convert';
import 'package:clean_arch/core/constants/constants.dart';
import 'package:clean_arch/core/error/failures.dart';
import 'package:clean_arch/feature/auth/data/models/user_request_model.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';


abstract class AuthRemoteDataSource {
  Future<UserModel> login(UserRequestModel request);
  Future<UserModel> signup(UserRequestModel request);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<UserModel> login(request) async {
    final response = await client.post(
      Uri.parse(Constants.baseUrl+'/api/v1/user/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': request.email, 'password': request.password}),
    );

    print("Response login"+response.body.toString());
    print("Response code"+response.statusCode.toString());

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Failure('Login failed');
    }
  }

  @override
  Future<UserModel> signup(request) async {
    final response = await client.post(
      Uri.parse(Constants.baseUrl+'/api/v1/user'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': request.email, 'password': request.password}),
    );

    if (response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Failure('Signup failed');
    }
  }
}