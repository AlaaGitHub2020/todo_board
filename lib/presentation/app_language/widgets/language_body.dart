import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_board/application/core/language/application_language_cubit.dart';
import 'package:todo_board/application/core/language/language_cubit.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';
import 'package:todo_board/generated/l10n.dart';
import 'package:todo_board/presentation/app_language/widgets/language_radio_btn.dart';

import '../../../../main.dart';

class LanguageBody extends StatelessWidget {
  const LanguageBody({Key? key}) : super(key: key);

  void onSelectLanguage(BuildContext context, String language) {
    log.i("onSelectLanguage Started");
    context.read<LanguageCubit>().updateLanguage(language: language);
  }

  onPressedSave(BuildContext context) async {
    log.i("onPressedSave Started");
    String language = context.read<LanguageCubit>().getLanguage();
    await SharedPreferences.getInstance().then((value) {
      value.setString(Strings.cApplicationLanguage, language);
      context
          .read<ApplicationLanguageCubit>()
          .updateApplicationLanguage(language);
      context.router.pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> settingsArray = [
      S.of(context).english,
      S.of(context).arabic,
    ];
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () => onPressedSave(context),
                child: Text(S.of(context).save)),
            SizedBox(height: MediaQuery.of(context).size.width * 0.05),
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: Strings.settingsArrayLanguageString.length,
              itemBuilder: (BuildContext context, int index) {
                return BlocBuilder<LanguageCubit, String>(
                  builder: (context, languageSate) {
                    return LanguageRadioBtn(
                      languageName: settingsArray[index],
                      selected: (languageSate ==
                          Strings.settingsArrayLanguageString[index]),
                      onSelectLanguageBtn: () => onSelectLanguage(
                          context, Strings.settingsArrayLanguageString[index]),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
