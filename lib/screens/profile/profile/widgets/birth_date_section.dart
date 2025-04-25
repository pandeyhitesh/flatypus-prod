import 'package:color_log/color_log.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatypus/common/methods.dart'
    show alphaFromOpacity, dobMonthDateFormat, fullDateFormat;
import 'package:flatypus/common/methods/date_selection.dart';
import 'package:flatypus/common/methods/show_navigation_bottom_sheet.dart';
import 'package:flatypus/common/widgets/custom_text_n_icon_button.dart';
import 'package:flatypus/models/user_model.dart';
import 'package:flatypus/screens/profile/profile/methods/profile_methods.dart';
import 'package:flatypus/screens/profile/profile/widgets/tiny_edit_button.dart';
import 'package:flatypus/state/controllers/task_date_selection_controller.dart';
import 'package:flatypus/state/providers/users_provider.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BirthDateSection extends ConsumerWidget {
  const BirthDateSection({super.key, required this.dobMonthDate});
  final DateTime? dobMonthDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (dobMonthDate != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: const Icon(
                  FontAwesomeIcons.cakeCandles,
                  size: 16,
                  color: AppColors.white,
                ),
              ),
              Text(
                dobMonthDateFormat.format(dobMonthDate!),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  letterSpacing: .5,
                  color: AppColors.white.withAlpha(alphaFromOpacity(.7)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TinyEditButton(
                  onTap:
                      () => ProfileMethods.onEditDateOfBirthButtonTap(
                        context: context,
                        ref: ref,
                      ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    if (dobMonthDate == null) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextNIconButton(
              label: 'Add Birthday',
              icon: FontAwesomeIcons.cakeCandles,
              onTap:
                  () => ProfileMethods.onEditDateOfBirthButtonTap(
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
