import 'package:flatypus/core/services/global_context.dart';
import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flutter/material.dart';

showSuccessSnackbar({
  required String label,
}) {
  final context = GlobalContext.navigationKey.currentContext;
  if (context != null && context.mounted) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: kBackgroundColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: AppColors.yellowAccent,
          duration: const Duration(milliseconds: 2000),
        ),
      );
  }
}

showErrorSnackbar({
  required String label,
}) {
  final context = GlobalContext.navigationKey.currentContext;
  if (context != null && context.mounted) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: kBackgroundColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          elevation: 16,
          backgroundColor: AppColors.errorColor,
          duration: const Duration(milliseconds: 2000),
          dismissDirection: DismissDirection.startToEnd,
          clipBehavior: Clip.antiAlias,
        ),
      );
  }
}
