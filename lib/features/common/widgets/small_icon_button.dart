import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SmallIconButton extends StatelessWidget {
  const SmallIconButton({
    super.key,
    this.tooltip,
    required this.icon,
    required this.onTap,
    this.iconSize,
  });
  final String? tooltip;
  final IconData icon;
  final Function onTap;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      icon: FaIcon(
        icon,
        size: iconSize ?? 16,
        color: AppColors.white.withAlpha(200),
      ),
      onPressed: () => onTap.call(),
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
    );
  }
}
