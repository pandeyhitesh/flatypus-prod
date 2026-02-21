import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/features/common/widgets/custom_text_n_icon_button.dart';
import 'package:flatypus/features/profile/presentation/methods/profile_methods.dart';
import 'package:flatypus/features/profile/presentation/widgets/tiny_edit_button.dart';
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
