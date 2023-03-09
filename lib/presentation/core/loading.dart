import 'package:flutter/material.dart';
import 'package:todo_board/domain/core/utilities/colors.dart';
import 'package:todo_board/presentation/core/animated_image.dart';

class Loading extends StatelessWidget {
  final bool fullScreen;

  const Loading({Key? key, this.fullScreen = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return fullScreen
        ? const AnimatedImage()
        : Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
  }
}
