import 'package:clean_arch/core/error/exceptions.dart';
import 'package:clean_arch/feature/auth/data/datasource/remote_data_source.dart';
import 'package:clean_arch/feature/auth/data/models/user_request_model.dart';
import 'package:clean_arch/feature/auth/domain/entities/user.dart';
import 'package:clean_arch/feature/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> currentUser() {
    // TODO: implement currentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({required String email, required String password})  async {
    try {
      final user = await remoteDataSource.login(UserRequestModel(email: email, password: password));
      return Right(user);
    } catch (e) {
      print("Whats error"+e.toString());
      return Left(Failure('Login failed'));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({required String name, required String email, required String password}) async {
    try {
      final user = await remoteDataSource.signup(UserRequestModel(email: email, password: password));
      return Right(user);
    } catch (e) {
      return Left(Failure('Signup failed'));
    }
  }
}