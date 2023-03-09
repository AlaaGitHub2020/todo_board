import 'package:flutter/material.dart';

DropdownMenuItem<String> buildItemState({
  required String value,
  required String text,
}) {
  return DropdownMenuItem(
    value: value,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text),
    ),
  );
}
