import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';


Widget alternativeScreenButton({required BuildContext context, required String label,required void Function() onTap,}) {
  return TextButton(
    onPressed: onTap,
    child: Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        color: AppColors.white,
        letterSpacing: .5,
      ),
    ),
  );
}