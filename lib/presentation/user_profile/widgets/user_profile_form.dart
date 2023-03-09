import 'package:flutter/material.dart';
import 'package:todo_board/generated/l10n.dart';
import 'package:todo_board/presentation/user_profile/widgets/account_information_text.dart';
import 'package:todo_board/presentation/user_profile/widgets/profile_row_data.dart';
import 'package:todo_board/presentation/user_profile/widgets/user_profile_image.dart';

class UserProfileForm extends StatelessWidget {
  final userProfile;

  const UserProfileForm({
    Key? key,
    required this.userProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          const UserProfileImage(),
          buildSizedBox(),
          const AccountInformationText(),
          buildSizedBox(),
          ProfileRowData(
            title: S.of(context).userName,
            value: userProfile.userProfile.userName.getOrCrash(),
          ),
          buildSizedBox(),
          ProfileRowData(
            title: S.of(context).email,
            value: userProfile.userProfile.emailAddress.getOrCrash(),
          ),
        ],
      ),
    );
  }

  Widget buildSizedBox() => const SizedBox(height: 8);
}
