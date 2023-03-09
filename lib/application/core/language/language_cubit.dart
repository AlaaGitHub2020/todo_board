import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';

class LanguageCubit extends Cubit<String> {
  LanguageCubit() : super(Strings.settingsArrayLanguageString[0]);

  void updateLanguage({required String language}) async {
    emit(language);
  }

  String getLanguage() {
    return state;
  }
}
