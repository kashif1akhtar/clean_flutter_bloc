import 'package:clean_arch/core/error/failures.dart';
import 'package:clean_arch/core/usecase/usecase.dart';
import 'package:clean_arch/feature/auth/domain/entities/user.dart';
import 'package:clean_arch/feature/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';


class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
