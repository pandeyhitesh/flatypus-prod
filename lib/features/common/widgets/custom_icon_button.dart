import 'package:flatypus/core/utils/enums.dart';
import 'package:flatypus/features/common/widgets/custom_text_n_icon_button.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    this.label,
    required this.icon,
    required this.onTap,
    required this.foregroundColor,
  });
  final String? label;
  final IconData icon;
  final Function onTap;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return CustomTextNIconButton(
      label: label ?? '',
      icon: icon,
      onTap: onTap,
      foregroundColor: foregroundColor,
      leftPadding: 0,
      level: Level.medium,
      buttonPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}
