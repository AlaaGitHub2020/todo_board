import 'package:flutter/material.dart';
import 'package:todo_board/generated/l10n.dart';

class AccountInformationText extends StatelessWidget {
  const AccountInformationText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      S.of(context).accountInformation,
      style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 16),
    );
  }
}
