import 'package:flatypus/common/methods.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

final border = OutlineInputBorder(
  borderRadius: BorderRadius.circular(16),
  borderSide: BorderSide(
    color: AppColors.white.withOpacity(.5),
    width: 1,
    style: BorderStyle.solid,
  ),
);

final enabledBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(16),
  borderSide: BorderSide(
    color: AppColors.white.withOpacity(.5),
    width: 1,
    style: BorderStyle.solid,
  ),
);

final focusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(16),
  borderSide: const BorderSide(
    color: AppColors.yellowAccent,
    width: 1.5,
    style: BorderStyle.solid,
  ),
);

final errorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(16),
  borderSide: const BorderSide(
    color: AppColors.errorColor,
    width: 1,
    style: BorderStyle.solid,
  ),
);

// underline input borders
final ulBorder = UnderlineInputBorder(
  borderSide: BorderSide(
    color: AppColors.white.withOpacity(.5),
    width: 1,
  ),
);

final ulEnabledBorder = UnderlineInputBorder(
  borderSide: BorderSide(
    color: AppColors.white.withOpacity(.5),
    width: 1,
  ),
);

const ulFocusedBorder = UnderlineInputBorder(
  borderSide: BorderSide(
    color: AppColors.yellowAccent,
    width: 2,
  ),
);

const ulErrorBorder = UnderlineInputBorder(
  borderSide: BorderSide(
    color: AppColors.errorColor,
    width: 1,
  ),
);

final kClickableCardDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(15),
  color: AppColors.clickableCardColor,
  border: Border.all(
    color: AppColors.white.withAlpha(alphaFromOpacity(.3)),
    width: 1,
  ),
  boxShadow: [
    BoxShadow(
      color: AppColors.white.withAlpha(alphaFromOpacity(.01)),
      blurRadius: 3,
      spreadRadius: 1,
    )
  ],
);

final kCardDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(15),
  color: AppColors.primaryColor,
  border: Border.all(
    color: AppColors.white.withAlpha(alphaFromOpacity(.3)),
    width: 1,
  ),
  boxShadow: [
    BoxShadow(
      color: AppColors.white.withAlpha(alphaFromOpacity(.01)),
      blurRadius: 3,
      spreadRadius: 1,
    )
  ],
);

BoxDecoration customCardDecoration(
        {Color? bgColor,
        double? borderRadius,
        Color? borderColor,
        Color? shadowColor,
        double? borderWidth}) =>
    BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius ?? 15),
      color: bgColor ?? AppColors.primaryColor,
      border: Border.all(
        color: (borderColor ?? AppColors.white).withOpacity(.3),
        width: borderWidth ?? 1,
      ),
      boxShadow: [
        BoxShadow(
          color: (shadowColor ?? AppColors.white).withOpacity(.01),
          blurRadius: 3,
          spreadRadius: 1,
        )
      ],
    );

// Border Radius
final kMenuCardBorderRadius = BorderRadius.circular(12);
const kMenuCardPadding = EdgeInsets.symmetric(horizontal: 20, vertical: 8);
const kTaskCardPadding = EdgeInsets.symmetric(horizontal: 18, vertical: 14);
const kTaskCardMargin = EdgeInsets.only(top: 16);
