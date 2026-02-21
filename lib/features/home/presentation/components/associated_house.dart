import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/core/utils/strings.dart';
import 'package:flatypus/features/common/widgets/component_header.dart';
import 'package:flatypus/features/home/presentation/widgets/empty_house_card.dart';
import 'package:flatypus/features/home/presentation/widgets/house_info_card.dart';
import 'package:flatypus/features/house/domain/entities/house.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssociatedHouse extends ConsumerWidget {
  const AssociatedHouse({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement house provider
    // final house = ref.watch(houseProvider);
    final House? house = null;
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
