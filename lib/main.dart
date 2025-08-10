import 'package:clean_arch/core/theme/app_theme.dart';
import 'package:clean_arch/core/theme/bloc/theme_bloc.dart';
import 'package:clean_arch/core/theme/bloc/theme_state.dart';
import 'package:clean_arch/core/theme/theme.dart';
import 'package:clean_arch/feature/auth/presentation/bloc/bloc_auth.dart';
import 'package:clean_arch/feature/auth/presentation/pages/login_page.dart';
import 'package:clean_arch/feature/courses/presentation/bloc/course_bloc.dart';
import 'package:clean_arch/feature/courses/presentation/bloc/course_event.dart';
import 'package:clean_arch/feature/courses/presentation/pages/CoursePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<ThemeBloc>()),
        BlocProvider(create: (_) => di.sl<AuthBloc>()),
        BlocProvider(create: (_) => di.sl<CourseBloc>()..add(FetchCourses())),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            theme: AppsTheme.darkTheme,
            debugShowCheckedModeBanner: false,
            title: 'Clean Architecture App',
            home: LoginPage(),
          );
        },
      ),
    );
  }
}