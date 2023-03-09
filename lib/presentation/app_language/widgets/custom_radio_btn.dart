import 'package:flutter/material.dart';
import 'package:todo_board/domain/core/utilities/colors.dart';

class CustomRadioBtn extends StatelessWidget {
  final bool selected;

  const CustomRadioBtn({
    Key? key,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.0106),
      decoration: buildBoxDecoration(),
      child: Container(
        height: MediaQuery.of(context).size.width * 0.025,
        width: MediaQuery.of(context).size.width * 0.025,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected ? AppColors.primaryColor : AppColors.whiteColor1,
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: AppColors.primaryColor),
    );
  }
}
