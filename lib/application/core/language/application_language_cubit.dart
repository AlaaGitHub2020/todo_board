import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';
import 'package:todo_board/main.dart';

class ApplicationLanguageCubit extends Cubit<Locale> {
  ApplicationLanguageCubit()
      : super(const Locale(Strings.cEnglishLanguageCodeSupported,
            Strings.cEnglishLanguageCodeSupported));

  void updateApplicationLanguage(String applicationLanguage) async {
    log.i("updateApplicationLanguage Started");
    late Locale locale;

    switch (applicationLanguage) {
      case Strings.cEnglishLanguageStringSupported:
        locale = const Locale(Strings.cEnglishLanguageCodeSupported,
            Strings.cEnglishLanguageCodeSupported);
        break;

      case Strings.cArabicLanguageStringSupported:
        locale = const Locale(Strings.cArabicLanguageCodeSupported,
            Strings.cArabicLanguageCodeSupported);
        break;

      default:
        locale = const Locale(Strings.cEnglishLanguageCodeSupported,
            Strings.cEnglishLanguageCodeSupported);
    }
    emit(locale);
  }

  String selectDefaultApplicationLanguageDependOnDeviceLanguage() {
    log.i("selectDefaultApplicationLanguageDependOnDeviceLanguage Started");
    final String defaultLocale =
        kIsWeb ? Strings.cEnglishLanguageCodeSupported : Platform.localeName;
    String defaultApplicationLanguageCode = defaultLocale.split("_")[0];
    late String languageString;
    switch (defaultApplicationLanguageCode) {
      case Strings.cEnglishLanguageCodeSupported:
        languageString = Strings.cEnglishLanguageStringSupported;
        return languageString;
      case Strings.cArabicLanguageCodeSupported:
        languageString = Strings.cArabicLanguageStringSupported;
        return languageString;

      default:
        languageString = Strings.cEnglishLanguageStringSupported;
        return languageString;
    }
  }
}
