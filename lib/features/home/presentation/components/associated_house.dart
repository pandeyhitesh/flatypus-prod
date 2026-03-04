import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/core/utils/strings.dart';
import 'package:flatypus/features/common/widgets/component_header.dart';
import 'package:flatypus/features/home/presentation/widgets/empty_house_card.dart';
import 'package:flatypus/features/home/presentation/widgets/house_info_card.dart';
import 'package:flatypus/features/house/presentation/providers/house_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssociatedHouse extends ConsumerWidget {
  const AssociatedHouse({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeHouseAsync = ref.watch(activeHouseProvider);

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
            activeHouseAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => emptyHouseCard(context),
              data: (house) => house == null
                  ? emptyHouseCard(context)
                  : Expanded(child: HouseInfoCard(house: house)),
            ),
          ],
        ),
      ),
    );
  }
}
