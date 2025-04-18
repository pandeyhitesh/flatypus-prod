import 'package:flatypus/common/widgets/bottom_navigation/custom_bottom_navigation_bar.dart';
import 'package:flatypus/common/widgets/small_icon_button.dart';
import 'package:flatypus/common/widgets/text_with_icon_header.dart';
import 'package:flatypus/models/house_model.dart';
import 'package:flatypus/screens/house/add_a_house.dart';
import 'package:flatypus/screens/house/methods/house_methods.dart';
import 'package:flatypus/screens/house/widgets/house_name_text.dart';
import 'package:flatypus/screens/house/widgets/reorder_residents.dart';
import 'package:flatypus/state/providers/house_provider.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../common/methods.dart';
import '../../common/widgets/custom_text_n_icon_button.dart';

class ManageHouseScreen extends ConsumerWidget {
  const ManageHouseScreen({super.key});
  get _appBar => AppBar(
    title: Text('Manage House'),
    centerTitle: true,
    backgroundColor: kBackgroundColor,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final house = ref.watch(houseProvider);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: _appBar,
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: SizedBox(
        height: kScreenHeight,
        width: kScreenWidth,
        child: SingleChildScrollView(
          child: Padding(
            padding: kHorizontalScrPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: kScreenPadding),
                _manageButtonSection(ref: ref, context: context, house: house),
                ..._houseDetailsSection(house: house, ref: ref),
                const ReorderResidents(),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _houseDetailsSection({HouseModel? house, required WidgetRef ref}) => [
    const SizedBox(height: 24),
    displayHouseNameText(label: house?.displayName, color: AppColors.white),
    const SizedBox(height: 5),
    displayAddressText(
      label: house?.address,
      color: AppColors.white,
      maxLines: 3,
    ),
    SizedBox(
      width: kScreenWidth,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: textWithIconHeader(
              value: house?.houseKey ?? 'House Key N/A',
              icon: Icons.key,
              iconSize: 14,
              fontSize: 16,
            ),
          ),
          Positioned(
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SmallIconButton(
                  tooltip: 'Copy to clipboard',
                  icon: FontAwesomeIcons.solidCopy,
                  onTap: () => HouseMethods.copyHouseKey(ref),
                ),
                SmallIconButton(
                  tooltip: 'Sent to WhatsApp',
                  icon: FontAwesomeIcons.whatsapp,
                  onTap: () => HouseMethods.sendWhatsAppMessage(ref),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ];

  _manageButtonSection({
    required WidgetRef ref,
    required BuildContext context,
    required HouseModel? house,
  }) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // customTextNIconButton(
      //   label: 'Delete',
      //   icon: Icons.delete,
      //   onTap: () {
      //     // HouseMethods.deleteHouseMethodOnTap(ref);
      //   },
      //   foregroundColor: AppColors.errorColor,
      // ),
      CustomTextNIconButton(
        label: 'Edit',
        icon: Icons.edit_note_outlined,
        onTap: () => push(context, AddAHouseScreen(house: house)),
        foregroundColor: AppColors.yellowAccent2,
      ),
    ],
  );
}
