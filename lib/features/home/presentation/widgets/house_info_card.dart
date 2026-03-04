import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/utils/enums.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/features/common/widgets/custom_outline_navigation_button.dart';
import 'package:flatypus/features/common/widgets/text_with_icon_header.dart';
import 'package:flatypus/features/home/presentation/widgets/multiple_users_image_stack.dart';
import 'package:flatypus/features/house/domain/entities/house.dart';
import 'package:flatypus/features/house/presentation/pages/manage_house_screen.dart';
import 'package:flatypus/features/house/presentation/widgets/house_name_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HouseInfoCard extends StatelessWidget {
  const HouseInfoCard({super.key, required this.house});

  final House? house;

  @override
  Widget build(BuildContext context) {
    if (house == null) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            displayHouseKey(house!),
            // textWithIconHeader(
            //   value: house?.houseKey ?? 'House Id',
            //   icon: Icons.key,
            //   fontSize: 16,
            //   iconSize: 18,
            // ),
            houseDetailsTab(house!),
            userDetailsTab(context),
          ],
        ),
      ),
    );
  }

  static Widget displayHouseKey(House house, {Level level = Level.medium}) {
    final double fontSize = level == Level.small ? 14 : 16;
    return Flexible(
      fit: FlexFit.tight,
      flex: 2,
      child: Padding(
        padding:
            level == Level.small
                ? EdgeInsets.zero
                : const EdgeInsets.fromLTRB(16, 3, 16, 0),
        child: textWithIconHeader(
          value: house.houseKey ?? 'House Id',
          icon: Icons.key,
          fontSize: fontSize,
          iconSize: fontSize + 2,
          letterSpacing: .5,
          fontColor: AppColors.white.withOpacity(.7),
        ),
      ),
    );
  }

  static Widget userDetailsTab(
    BuildContext context, {
    Level level = Level.medium,
  }) {
    if (level == Level.small) return const SizedBox();
    return Flexible(
      fit: FlexFit.tight,
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(flex: 1, child: MultipleUsersImageStack()),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Consumer(
                  builder:
                      (context, ref, child) => CustomOutlineNavigationButton(
                        label: 'Manage',
                        navigateTo: const ManageHouseScreen(),
                        foregroundColor: kBackgroundColor,
                        function: () => push(context, ManageHouseScreen()),
                        // ref.read(selectedPageProvider.notifier).state = 2,
                        // update selected screen index for "Manage House" screen
                      ),
                ),
                // child: ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: kTransparent,
                //     surfaceTintColor: kTransparent,
                //     elevation: 0,
                //     shadowColor: kTransparent,
                //     visualDensity: VisualDensity.compact,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(30),
                //       side: BorderSide(
                //         color: kBackgroundColor,
                //         width: 1.5,
                //       ),
                //     ),
                //   ),
                //   onPressed: () => push(context, AddAHouseScreen()),
                //   child: Row(
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       Text(
                //         'Manage',
                //         style: TextStyle(
                //           fontSize: 12,
                //           color: kBackgroundColor,
                //           letterSpacing: .5,
                //         ),
                //       ),
                //       const SizedBox(
                //         width: 3,
                //       ),
                //       Icon(
                //         Icons.arrow_forward_rounded,
                //         size: 14,
                //         color: kBackgroundColor,
                //       ),
                //     ],
                //   ),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget houseDetailsTab(House house, {Level level = Level.medium}) {
    final double? fontSize = level == Level.small ? 18 : null;
    final double? adrFontSize = level == Level.small ? 14 : null;
    return Flexible(
      flex: 4,
      fit: FlexFit.tight,
      child: Container(
        child: Padding(
          padding:
              level == Level.small
                  ? EdgeInsets.zero
                  : const EdgeInsets.fromLTRB(16, 0, 16, 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              displayHouseNameText(
                label: house.displayName ?? "House Name NA",
                fontSize: fontSize,
              ),
              displayAddressText(label: house.address, fontSize: adrFontSize),
            ],
          ),
        ),
      ),
    );
  }
}
