import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/features/common/widgets/component_header.dart';
import 'package:flatypus/features/house/presentation/methods/house_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreenSectionHeader extends ConsumerWidget {
  const HomeScreenSectionHeader({
    super.key,
    required this.destinationScreen,
    required this.title,
    required this.buttonText,
  });
  final String title;
  final String buttonText;
  final Widget destinationScreen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        componentHeader(title),
        Container(
          height: 30,
          padding: const EdgeInsets.symmetric(vertical: 1.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              visualDensity: VisualDensity.compact,
              backgroundColor: AppColors.yellowAccent2,
              surfaceTintColor: kTransparent,
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            onPressed: () {
              // check if house is added
              final isHouseAvailable = HouseMethods.isHouseAvailable(ref: ref);
              if (!isHouseAvailable) return;
              // if house available, navigate to Add space screen
              push(context, destinationScreen);
            },
            child: Text(
              buttonText,
              style: TextStyle(
                color: AppColors.backgroundColor,
                fontWeight: FontWeight.w700,
                fontSize: 12,
                letterSpacing: .5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
