import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../services/global_context.dart';
import '../../theme/app_colors.dart';
import '../methods.dart';
import '../widgets/custom_text_n_icon_button.dart';

Future<bool?> showCustomConfirmationDialog({
  String? header,
  String? noteText,
  String? confirmText,
  String? cancelText,
}) async {
  return await showCupertinoDialog(
    context: GlobalContext.navigationKey.currentContext!,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.secondaryColor,
      title: Text(header ?? 'Do you confirm?'),
      titleTextStyle: const TextStyle(
        fontSize: 16,
        letterSpacing: .5,
        color: AppColors.primaryColor,
        fontWeight: FontWeight.w500,
      ),
      content: noteText == null
          ? null
          : Text(
              noteText,
              style: const TextStyle(
                color: AppColors.primaryColor,
              ),
            ),
      shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actionsOverflowAlignment: OverflowBarAlignment.end,
      // actionsPadding: EdgeInsets.only(bottom: 0),
      actions: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              // width: kScreenWidth / 3,
              child: Center(
                child: CustomTextNIconButton(
                  label: cancelText ?? 'Cancel',
                  icon: Icons.cancel_outlined,
                  onTap: () => pop(
                    parameter: false,
                  ),
                  foregroundColor: AppColors.errorColor,
                ),
              ),
            ),
            SizedBox(
              // width: kScreenWidth / 3,
              child: CustomTextNIconButton(
                label: confirmText ?? 'Confirm',
                icon: Icons.done,
                onTap: () => pop(
                  parameter: true,
                ),
                foregroundColor: AppColors.yellowAccent2,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
