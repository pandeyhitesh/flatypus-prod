import 'package:flutter/material.dart';

Widget displayHouseNameText({
  String? label,
  double? fontSize,
}) {
  return Text(
    label ?? '',
    style: TextStyle(fontSize: fontSize ?? 18),
  );
}

Widget displayAddressText({
  String? label,
  double? fontSize,
}) {
  return Text(
    label ?? '',
    style: TextStyle(fontSize: fontSize ?? 14),
  );
}
