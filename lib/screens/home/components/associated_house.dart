import 'package:flatypus/common/methods.dart';
import 'package:flatypus/common/strings.dart';
import 'package:flatypus/state/providers/house_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/widgets/component_header.dart';
import '../widgets/empty_house_card.dart';
import '../widgets/house_info_card.dart';

class AssociatedHouse extends ConsumerWidget {
  const AssociatedHouse({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final house = ref.watch(houseProvider);
    return Padding(
      padding: kHorizontalScrPadding,
      child: SizedBox(
        height: 180,
        width: kScreenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            componentHeader(AppStrings.associatedHouse),
            if (house != null) Expanded(child: HouseInfoCard(house: house)),
            if (house == null) emptyHouseCard(context),
          ],
        ),
      ),
    );
  }
  //
  // Widget houseInfoCard(HouseModel house, BuildContext context) => Expanded(
  //       child: Padding(
  //         padding: const EdgeInsets.only(top: 8.0),
  //         child: Container(
  //           decoration: BoxDecoration(
  //             color: AppColors.secondaryColor,
  //             borderRadius: BorderRadius.circular(16),
  //           ),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.end,
  //             crossAxisAlignment: CrossAxisAlignment.stretch,
  //             children: [
  //               _displayhouseKey(house),
  //               // textWithIconHeader(value: house.houseKey??'House Id', icon: Icons.key,fontSize: 16, iconSize: 18),
  //               _houseDetailsTab(house),
  //               _userDetailsTab(context),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
}
