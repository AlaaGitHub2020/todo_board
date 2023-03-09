import 'package:flutter/material.dart';

class ProfileRowData extends StatelessWidget {
  final String? title;
  final String? value;

  const ProfileRowData({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildTitleText(context),
          SizedBox(width: MediaQuery.of(context).size.width * 0.15),
          buildValueText(context),
        ],
      ),
    );
  }

  Expanded buildValueText(BuildContext context) {
    return Expanded(
      child: Text(
        value!,
        style:
            Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 16),
        textAlign: TextAlign.end,
        maxLines: 1,
      ),
    );
  }

  Text buildTitleText(BuildContext context) {
    return Text(
      title!,
      style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 16),
      overflow: TextOverflow.ellipsis,
    );
  }
}
