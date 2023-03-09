import 'package:flutter/material.dart';
import 'package:todo_board/domain/core/utilities/colors.dart';

class DisabledBtn extends StatelessWidget {
  final String text;
  final bool fixedSize;

  const DisabledBtn({Key? key, required this.text, this.fixedSize = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            fixedSize: fixedSize
                ? MaterialStateProperty.all(
                    Size.fromWidth(MediaQuery.of(context).size.width * 0.30))
                : null,
            backgroundColor: MaterialStateProperty.all(AppColors.grayColor1)),
        onPressed: null,
        child: Text(text));
  }
}
