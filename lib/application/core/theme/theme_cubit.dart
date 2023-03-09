import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/domain/core/utilities/app_theme.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<AppThemeState> {
  ThemeCubit() : super(LightThemeState());

  toggleDarkMode() {
    if (state is LightThemeState) {
      emit(DarkThemeState());
    } else {
      emit(LightThemeState());
    }
  }

  setDarkMode() {
    emit(DarkThemeState());
  }
}
