import 'package:clean_arch/core/theme/bloc/theme_bloc.dart';
import 'package:clean_arch/feature/auth/data/datasource/remote_data_source.dart';
import 'package:clean_arch/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:clean_arch/feature/auth/domain/repository/auth_repository.dart';
import 'package:clean_arch/feature/auth/domain/usecases/user_login.dart';
import 'package:clean_arch/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:clean_arch/feature/auth/presentation/bloc/bloc_auth.dart';
import 'package:clean_arch/feature/courses/data/data_source/course_local_db.dart';
import 'package:clean_arch/feature/courses/data/data_source/remote_data_source.dart';
import 'package:clean_arch/feature/courses/data/repository/course_repository_impl.dart';
import 'package:clean_arch/feature/courses/domain/repository/course_repository.dart';
import 'package:clean_arch/feature/courses/domain/usecases/create_course.dart';
import 'package:clean_arch/feature/courses/domain/usecases/get_course.dart';
import 'package:clean_arch/feature/courses/presentation/bloc/course_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'core/database/database_helper.dart';


final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  sl.registerFactory(() => AuthBloc(login: sl(), signup: sl()));
  sl.registerFactory(() => CourseBloc(sl(), sl()));
  sl.registerFactory(() => ThemeBloc());

  // Use Cases
  sl.registerLazySingleton(() => UserLogin(sl()));
  sl.registerLazySingleton(() => UserSignUp(sl()));
  sl.registerLazySingleton(() => GetCourses(sl()));
  sl.registerLazySingleton(() => CreateCourse(sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<CourseRepository>(() => CourseRepositoryImpl(sl(), sl()));

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<CourseRemoteDataSource>(() => CourseRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<CourseLocalDataSource>(() => CourseLocalDataSourceImpl(sl()));

  // Core
  sl.registerLazySingleton(() => DatabaseHelper.instance);
  sl.registerLazySingleton(() => http.Client());
}