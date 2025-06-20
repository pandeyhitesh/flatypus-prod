import 'package:flatypus/common/methods.dart';
import 'package:flatypus/common/widgets/custom_text_n_icon_button.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<T?> showCustomDialog<T>({
  required BuildContext parentContext,
  required String headerText,
  required Widget body,
  Widget? confirmationAction,
  String? cancellationActionLabel,
}) async {
  return await showCupertinoDialog(
    context: parentContext,

    builder:
        (context) => Consumer(
          builder: (context, ref, child) {
            return AlertDialog(
              backgroundColor: AppColors.primaryColor,
              surfaceTintColor: Colors.transparent,
              title: Text(headerText),
              titleTextStyle: Theme.of(parentContext).textTheme.headlineSmall,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [body],
              ),
              shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
              actionsAlignment:
                  confirmationAction == null
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.spaceAround,
              actionsOverflowAlignment: OverflowBarAlignment.end,
              actions: [
                SizedBox(
                  width: kScreenWidth / 3,
                  child: CustomTextNIconButton(
                    label: cancellationActionLabel ?? 'Cancel',
                    icon: Icons.cancel_outlined,
                    onTap: () => pop(parameter: false),
                    foregroundColor: AppColors.errorColor,
                  ),
                ),
                confirmationAction ?? const SizedBox.shrink(),
              ],
            );
          },
        ),
  );
}
