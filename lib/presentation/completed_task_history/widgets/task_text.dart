import 'package:flutter/material.dart';

class TaskText extends StatelessWidget {
  final String taskAttributeName;
  final String taskAttributeValue;
  final bool textStyleLabelSmall;

  const TaskText({
    Key? key,
    required this.taskAttributeName,
    required this.taskAttributeValue,
    this.textStyleLabelSmall = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$taskAttributeName$taskAttributeValue",
      style: textStyleLabelSmall
          ? Theme.of(context).textTheme.labelSmall
          : Theme.of(context).textTheme.displayMedium,
    );
  }
}
