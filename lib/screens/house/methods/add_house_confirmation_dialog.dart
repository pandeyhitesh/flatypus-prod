import 'package:flatypus/common/enums.dart';
import 'package:flatypus/common/methods.dart';
import 'package:flatypus/common/widgets/custom_text_n_icon_button.dart';
import 'package:flatypus/models/house_model.dart';
import 'package:flatypus/screens/home/widgets/house_info_card.dart';
import 'package:flatypus/screens/house/methods/house_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/app_colors.dart';

Future<bool> showAddHouseConfirmationDialog({
  required BuildContext context,
  required HouseModel house,
}) async {
  print('House from dialog = $house');
  if (!context.mounted) return false;

  Widget houseInfoCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HouseInfoCard.displayhouseKey(house, level: Level.small),
            // textWithIconHeader(value: house.houseKey??'House Id', icon: Icons.key,fontSize: 16, iconSize: 18),
            HouseInfoCard.houseDetailsTab(house, level: Level.small),
          ],
        ),
      ),
    );
  }

  return await showCupertinoDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.primaryColor,
      surfaceTintColor: Colors.transparent,
      title: const Text('House found! Please confirm to add.'),
      titleTextStyle: TextStyle(
        color: AppColors.white.withOpacity(.9),
        fontSize: 16,
      ),
      content: SizedBox(
        height: 100,
        width: kScreenWidth,
        child: houseInfoCard(),
      ),
      actions: [
        SizedBox(
          width: kScreenWidth / 3,
          child: CustomTextNIconButton(
            label: 'Cancel',
            icon: Icons.cancel_outlined,
            onTap: () => pop(
              parameter: false,
            ),
            foregroundColor: AppColors.errorColor,
          ),
        ),
        Consumer(
          builder: (context, ref, child) => SizedBox(
            width: kScreenWidth / 3,
            child: CustomTextNIconButton(
              label: 'Add',
              icon: Icons.add_business_outlined,
              onTap: () => HouseMethods.addUserToHouse(
                  context: context, house: house, ref: ref),
              foregroundColor: AppColors.yellowAccent2,
            ),
          ),
        ),
      ],
      actionsAlignment: MainAxisAlignment.spaceAround,
      actionsOverflowAlignment: OverflowBarAlignment.end,
      actionsPadding: EdgeInsets.fromLTRB(16, 8, 16, 24),
    ),
  );
}
