import 'package:flutter/material.dart';
import 'package:todo_board/domain/core/utilities/colors.dart';
import 'package:todo_board/generated/l10n.dart';
import 'package:todo_board/presentation/core/custom_snackbar.dart';


class SnackBars {
  static showSuccess(BuildContext context, String text) {
    SnackBar snackBar = CustomSnackBar(
      context: context,
      backgroundColor: AppColors.greenColor2,
      icon: Icon(
        Icons.thumb_up,
        color: Theme.of(context).iconTheme.color,
      ),
      text: text,
    );
    showSnackBar(context, snackBar);
  }

  static showDefaultError(BuildContext context) {
    showError(context, S.of(context).genericError);
  }

  static showError(BuildContext context, String text) {
    SnackBar snackBar = CustomSnackBar(
      context: context,
      icon: Icon(
        Icons.error,
        color: Theme.of(context).iconTheme.color,
      ),
      backgroundColor: AppColors.errorColor,
      text: text,
    );
    showSnackBar(context, snackBar);
  }

  static showSnackBar(BuildContext context, SnackBar snackBar) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
