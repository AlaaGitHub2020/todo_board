import 'package:flutter/material.dart';
import 'package:todo_board/domain/core/utilities/colors.dart';
import 'package:todo_board/presentation/app_language/widgets/custom_radio_btn.dart';

class LanguageRadioBtn extends StatelessWidget {
  final String languageName;
  final bool selected;
  final GestureTapCallback? onSelectLanguageBtn;

  const LanguageRadioBtn({
    Key? key,
    required this.languageName,
    required this.selected,
    required this.onSelectLanguageBtn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelectLanguageBtn,
      child: Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.width * 0.024,
            bottom: MediaQuery.of(context).size.width * 0.024),
        decoration: buildBoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildLanguageText(context),
            CustomRadioBtn(selected: selected),
          ],
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: AppColors.primaryColor,
        ),
      ),
    );
  }

  Text buildLanguageText(BuildContext context) {
    return Text(
      languageName,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
