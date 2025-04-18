import 'package:flatypus/theme/textstyles.dart';
import 'package:flutter/material.dart';

import '../../../common/strings.dart';
import '../../../theme/app_colors.dart';

class AppNameLogo extends StatelessWidget {
  const AppNameLogo({super.key, this.fontSize, this.color, this.label});
  final double? fontSize;
  final Color? color;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label ?? AppStrings.appName,
      style: TextStyle(
        fontFamily: kAppLogoFontFamily,
        fontSize: fontSize ?? 24,
        color: color ?? AppColors.white,
        fontWeight: FontWeight.bold,
      ),
      maxLines: 1,
      softWrap: false,
      overflow: TextOverflow.visible,
    );
  }
}

// Widget get appNameLogo => const Expanded(
//       child: Text(
//         AppStrings.appName,
//         style: TextStyle(
//           fontFamily: 'Playwrite_AR',
//           fontSize: 24,
//           color: AppColors.white,
//           fontWeight: FontWeight.bold,
//         ),
//         maxLines: 1,
//         softWrap: false,
//         overflow: TextOverflow.visible,
//       ),
//     );
