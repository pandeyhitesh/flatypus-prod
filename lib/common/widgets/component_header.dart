import 'package:flatypus/common/enums.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

Widget componentHeader(
  String label, {
  Level level = Level.large,
  bool leftPadding = false,
}) =>
    Padding(
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
