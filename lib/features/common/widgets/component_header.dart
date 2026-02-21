import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/utils/enums.dart';
import 'package:flutter/material.dart';

Widget componentHeader(
  String label, {
  Level level = Level.large,
  bool leftPadding = false,
}) => Padding(
  padding: EdgeInsets.only(left: leftPadding ? 4.0 : 0),
  child: Text(
    label,
    style: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: level == Level.large ? 18 : 14,
      color: AppColors.white,
      fontWeight: FontWeight.w500,
    ),
  ),
);
