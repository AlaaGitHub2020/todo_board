import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';

class AnimatedImage extends StatefulWidget {
  const AnimatedImage({Key? key}) : super(key: key);

  @override
  State<AnimatedImage> createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage> {
  late RiveAnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = OneShotAnimation(
      'spinning',
      autoplay: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.5,
        child: RiveAnimation.asset(
          fit: BoxFit.contain,
          Strings.icLoading,
          controllers: [_controller],
        ),
      ),
    );
  }
}
