import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/features/house/presentation/pages/search_house.dart';
import 'package:flutter/material.dart';

Widget emptyHouseCard(BuildContext context) => Expanded(
  child: Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          addHouseButton(context),
          emptyHouseLabel(),
        ],
      ),
    ),
  ),
);

Widget addHouseButton(BuildContext context) => Padding(
  padding: const EdgeInsets.only(top: 8.0, right: 10),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          visualDensity: VisualDensity.compact,
          surfaceTintColor: Colors.transparent,
          backgroundColor: AppColors.secondaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
          // padding: EdgeInsets.zero,
        ),
        onPressed: () => push(context, SearchHouse()),
        child: const Text(
          'Add House',
          style: TextStyle(
            fontSize: 12,
            color: AppColors.backgroundColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      )
    ],
  ),
);

Widget emptyHouseLabel() => Expanded(
  child: Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
      child: Text(
        'You are not associated with any House. Please add a house to get started.',
        style: TextStyle(
          color: AppColors.white.withOpacity(.7),
        ),
      ),
    ),
  ),
);