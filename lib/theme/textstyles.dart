import 'package:flatypus/common/methods.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flutter/material.dart';

const kBodyFontFamily = 'Mukta';
const kAppLogoFontFamily = 'Playwrite_AR';
const kHeaderFontFamily = 'Montserrat';

final hintTextStyle = TextStyle(
    color: AppColors.white.withOpacity(.3),
    fontWeight: FontWeight.normal,
    fontSize: 16,
    letterSpacing: .5,
    fontFamily: kBodyFontFamily);

const inputTextStyle = TextStyle(
    fontSize: 16,
    letterSpacing: .5,
    color: AppColors.white,
    fontFamily: kBodyFontFamily);

final spaceTitleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.white.withOpacity(.9),
    height: 0,
    fontFamily: kHeaderFontFamily);

final reorderableSubTextStyle =
    Theme.of(kGlobalContext).textTheme.bodySmall?.copyWith(
          color: AppColors.white.withAlpha(alphaFromOpacity(.7)),
        );

final taskNameTextStyle = TextStyle(
    fontSize: 18,
    letterSpacing: .1,
    fontWeight: FontWeight.w500,
    color: AppColors.white.withAlpha(230),
    height: 1.2,
    fontFamily: kHeaderFontFamily);
