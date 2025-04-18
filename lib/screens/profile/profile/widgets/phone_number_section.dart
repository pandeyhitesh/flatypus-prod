import 'package:flatypus/common/methods.dart' show alphaFromOpacity;
import 'package:flatypus/common/methods/show_navigation_bottom_sheet.dart';
import 'package:flatypus/common/widgets/custom_text_n_icon_button.dart';
import 'package:flatypus/screens/profile/profile/widgets/tiny_edit_button.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhoneNumberSection extends ConsumerWidget {
  const PhoneNumberSection({super.key, required this.phoneNumber});
  final String? phoneNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (phoneNumber != null && phoneNumber!.isNotEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '+91 $phoneNumber',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  letterSpacing: .5,
                  color: AppColors.white.withAlpha(alphaFromOpacity(.7)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TinyEditButton(
                  onTap:
                      () => BottomSheetManager.updatePhoneNumber(
                        context: context,
                        ref: ref,
                      ),
                ),
                // child: IconButton(
                //   style: IconButton.styleFrom(
                //     side: BorderSide(
                //       width: 1,
                //       color: AppColors.white.withAlpha(70),
                //     ),
                //     foregroundColor: AppColors.white.withAlpha(200),
                //   ),
                //   onPressed:
                //       () => BottomSheetManager.updatePhoneNumber(
                //         context: context,
                //         ref: ref,
                //       ),
                //   icon: const Icon(Icons.edit, size: 16),
                //   visualDensity: VisualDensity.compact,
                //   padding: EdgeInsets.zero,
                // ),
              ),
            ],
          ),
        ),
      );
    }
    if (phoneNumber == null || phoneNumber!.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextNIconButton(
              label: 'Add Phone Number',
              icon: Icons.phone_android_outlined,
              onTap:
                  () => BottomSheetManager.updatePhoneNumber(
                    context: context,
                    ref: ref,
                  ),
              foregroundColor: AppColors.white.withAlpha(150),
            ),
          ],
        ),
      );
    }
    return const SizedBox();
  }
}
