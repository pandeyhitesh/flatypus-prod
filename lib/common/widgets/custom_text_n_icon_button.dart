import 'package:flatypus/common/enums.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../methods.dart';

class CustomTextNIconButton extends StatelessWidget {
  const CustomTextNIconButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.buttonPadding,
    this.foregroundColor = AppColors.white,
    this.backgroundColor = kBackgroundColor,
    this.leftPadding = 8,
    this.borderRadius = 10,
    this.level = Level.small,
  });
  final String label;
  final IconData icon;
  final Function onTap;
  final Color foregroundColor;
  final Color? backgroundColor;
  final Level level;
  final double leftPadding;
  final EdgeInsets? buttonPadding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding),
      child: Container(
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: backgroundColor,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              visualDensity: VisualDensity.compact,
              foregroundColor: foregroundColor,
              backgroundColor: foregroundColor.withOpacity(.1),
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              alignment: Alignment.center,
              padding:
                  buttonPadding ?? const EdgeInsets.only(left: 16, right: 12)),
          onPressed: () => onTap(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 14, letterSpacing: .3, fontWeight: FontWeight.w600),
                ),
              ),
              if (label.isNotEmpty) const SizedBox(width: 5),
              Icon(
                icon,
                size: _iconSizeBasedOnLevel(level),
                color: foregroundColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

double _iconSizeBasedOnLevel(Level level) {
  switch (level) {
    case Level.small:
      return 16;
    case Level.medium:
      return 20;
    case Level.large:
      return 24;
  }
}
