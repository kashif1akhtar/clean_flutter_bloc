import 'dart:ui';

import 'package:clean_arch/core/theme/bloc/theme_event.dart';
import 'package:clean_arch/core/theme/bloc/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app_theme.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(AppsTheme.lightTheme)) {
    on<ToggleTheme>((event, emit) {
      emit(ThemeState(
        state.themeData.brightness == Brightness.light
            ? AppsTheme.darkTheme
            : AppsTheme.lightTheme,
      ));
    });
  }
}