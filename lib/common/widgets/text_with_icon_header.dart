import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

Widget textWithIconHeader(
        {required String value,
        required IconData icon,
        double iconSize = 16,
        double fontSize = 12,
        Color? iconColor = Colors.white60,
        Color? fontColor,
        double letterSpacing = .1}) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: iconColor,
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontSize: fontSize,
                letterSpacing: letterSpacing,
                fontWeight: FontWeight.w400,
                color: fontColor ?? AppColors.white.withOpacity(.9),
              ),
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
