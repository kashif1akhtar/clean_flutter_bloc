import 'package:clean_arch/feature/auth/domain/usecases/user_login.dart';
import 'package:clean_arch/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:clean_arch/feature/auth/presentation/bloc/auth_event.dart';
import 'package:clean_arch/feature/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserLogin login;
  final UserSignUp signup;

  AuthBloc({required this.login, required this.signup}) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await login(UserLoginParams(email: event.email, password: event.password));
      result.fold(
            (failure) => emit(AuthError(failure.message)),
            (user) => emit(AuthAuthenticated(user)),
      );
    });

    on<SignupEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await signup(UserSignUpParams(email: event.email, password: event.password,name: event.email));
      result.fold(
            (failure) => emit(AuthError(failure.message)),
            (user) => emit(AuthAuthenticated(user)),
      );
    });
  }
}