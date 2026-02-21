import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flutter/material.dart';

class ShowLoadingOverlay extends StatelessWidget {
  const ShowLoadingOverlay({
    super.key,
    this.isFullScreen = true,
    this.backgroundColor,
    this.indicatorColor,
  });
  final bool isFullScreen;
  final Color? backgroundColor;
  final Color? indicatorColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isFullScreen ? kScreenHeight : null,
      width: isFullScreen ? kScreenWidth : null,
      color: backgroundColor ?? Colors.white10,
      child: Center(
        child: CircularProgressIndicator(
          color: indicatorColor ?? AppColors.yellowAccent,
          strokeWidth: 5,
          strokeCap: StrokeCap.round,
        ),
      ),
    );
  }
}
