import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSolidButton extends StatelessWidget {
  const CustomSolidButton({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textStyle,
    this.onTap,
    this.hPadding,
    this.vPadding,
  });
  final String label;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final Function? onTap;
  final double? hPadding;
  final double? vPadding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.secondaryColor,
        padding: EdgeInsets.symmetric(
          vertical: vPadding ?? 12,
          horizontal: hPadding ?? 0,
        ),
      ),
      onPressed: () => onTap?.call(),
      child: Text(
        label,
        style:
            textStyle ??
            const TextStyle(color: AppColors.backgroundColor, fontSize: 16),
      ),
    );
  }
}
