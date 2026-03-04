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
    final associatedHousesAsync = ref.watch(associatedHousesProvider);

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
            associatedHousesAsync.when(
              loading: () => Center(child: CircularProgressIndicator()),
              error: (_, __) => emptyHouseCard(context),
              data: (response) {
                // if no housed associated witht he user yet
                if (response.houses.isEmpty) return emptyHouseCard(context);
                // For now, always use the first house in the list
                final firstHouseId = response.houses.first.id;
                // fetch the house details
                final houseDetailsAsync = ref.watch(
                  getHouseProvider(firstHouseId),
                );

                return houseDetailsAsync.when(
                  loading:
                      () => Expanded(
                        child: Center(child: CircularProgressIndicator()),
                      ),
                  error: (_, __) => emptyHouseCard(context),
                  data: (house) => Expanded(child: HouseInfoCard(house: house)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
