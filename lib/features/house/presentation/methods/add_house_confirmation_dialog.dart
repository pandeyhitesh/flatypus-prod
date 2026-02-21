import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/utils/enums.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/features/common/controllers/loading_controller.dart';
import 'package:flatypus/features/common/widgets/custom_text_n_icon_button.dart';
import 'package:flatypus/features/common/widgets/loading_overlay_screen.dart';
import 'package:flatypus/features/home/presentation/widgets/house_info_card.dart';
import 'package:flatypus/features/house/data/model/house_model.dart';
import 'package:flatypus/features/house/presentation/methods/house_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<bool?> showAddHouseConfirmationDialog({
  required BuildContext pContext,
  required HouseModel house,
  required WidgetRef ref,
}) async {
  if (!pContext.mounted) return false;

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
            HouseInfoCard.displayHouseKey(house, level: Level.small),
            // textWithIconHeader(value: house.houseKey??'House Id', icon: Icons.key,fontSize: 16, iconSize: 18),
            HouseInfoCard.houseDetailsTab(house, level: Level.small),
          ],
        ),
      ),
    );
  }

  return await showCupertinoDialog(
    context: pContext,
    builder: (_) {
      return Consumer(
        builder: (dialogContext, ref, _) {
          final isLoading = ref.watch(loadingControllerProvider);
          print('House from dialog = $isLoading}');
          return AlertDialog(
            backgroundColor: AppColors.primaryColor,
            surfaceTintColor: Colors.transparent,
            title: const Text('House found! Please confirm to add.'),
            titleTextStyle: Theme.of(dialogContext).textTheme.headlineSmall,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  width: kScreenWidth,
                  child: houseInfoCard(),
                ),
                if (isLoading)
                  Padding(
                    padding: const EdgeInsets.only(top: 14.0),
                    child: SizedBox(
                      height: 50,
                      width: kScreenWidth,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 26,
                            width: 26,
                            child: ShowLoadingOverlay(
                              isFullScreen: false,
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18.0,
                            ),
                            child: Text(
                              'Adding house...',
                              style:
                                  Theme.of(dialogContext).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            actions:
                isLoading
                    ? null
                    : [
                      isLoading
                          ? SizedBox.shrink()
                          : SizedBox(
                            width: kScreenWidth / 3,
                            child: CustomTextNIconButton(
                              label: 'Cancel',
                              icon: Icons.cancel_outlined,
                              onTap: () => pop(parameter: false),
                              foregroundColor: AppColors.errorColor,
                            ),
                          ),

                      isLoading
                          ? SizedBox.shrink()
                          : SizedBox(
                            width: kScreenWidth / 3,
                            child: CustomTextNIconButton(
                              label: 'Add',
                              icon: Icons.add_business_outlined,
                              onTap:
                                  () => HouseMethods.addUserToHouse(
                                    context: dialogContext,
                                    house: house,
                                    ref: ref,
                                  ),
                              foregroundColor: AppColors.yellowAccent2,
                            ),
                          ),
                    ],
            actionsAlignment: MainAxisAlignment.spaceAround,
            actionsOverflowAlignment: OverflowBarAlignment.end,
            actionsPadding: EdgeInsets.fromLTRB(16, 8, 16, 24),
          );
        },
      );
    },
  );
}
