import 'package:flutter/material.dart';

Widget customText({
  required String text,
  Color color = Colors.black,
  required double fontSize,
}) {
  return Text(
    text,
    style: TextStyle(color: color, fontSize: fontSize),
  );
}
