import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_board/presentation/core/widgets/responcive_header.dart';
import 'package:todo_board/presentation/core/widgets/responcive_side_image_icon.dart';

class ForgotPasswordPage extends StatelessWidget {
  final String? email;

  const ForgotPasswordPage({Key? key, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ForgotPasswordScreen(
      email: email,
      headerMaxExtent: 200,
      headerBuilder: headerIcon(Icons.lock),
      sideBuilder: sideIcon(Icons.lock),
    );
  }
}
