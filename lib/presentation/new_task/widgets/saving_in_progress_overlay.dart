import 'package:flutter/material.dart';
import 'package:todo_board/domain/core/utilities/colors.dart';
import 'package:todo_board/generated/l10n.dart';
import 'package:todo_board/presentation/core/loading.dart';

class SavingInProgressOverlay extends StatelessWidget {
  final bool isSaving;

  const SavingInProgressOverlay({
    Key? key,
    required this.isSaving,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isSaving,
      child: AnimatedContainer(
        duration: const Duration(microseconds: 150),
        color: isSaving ? Colors.black.withOpacity(0.8) : Colors.transparent,
        child: Visibility(
          visible: isSaving,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(child: Container()),
              isSaving ? const Loading(fullScreen: true) : Container(),
              const SizedBox(height: 10),
              buildSavingText(context),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildSavingText(BuildContext context) {
    return Expanded(
      child: Text(
        S.of(context).saving,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: AppColors.whiteColor1),
      ),
    );
  }
}
