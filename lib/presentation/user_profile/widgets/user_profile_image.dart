import 'package:flutter/material.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Image.asset(
        Strings.icLogo,
        height: MediaQuery.of(context).size.width * 0.35,
      ),
    );
  }
}
