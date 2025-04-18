import 'package:flatypus/screens/house/methods/house_methods.dart';
import 'package:flatypus/state/providers/spaces_provider.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flatypus/theme/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/space_model.dart';

Widget spaceSuggestionCard(SpaceModel demoSpace) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: AppColors.primaryColor,
    ),
    child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              suggestedBanner(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        demoSpace.name,
                        style: spaceTitleTextStyle,
                        maxLines: 2,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Consumer(
            builder: (context, ref, child) => IconButton(
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              onPressed: () {
                // check if house is added
                final isHouseAvailable =
                    HouseMethods.isHouseAvailable(ref: ref);
                if (!isHouseAvailable) return;
                ref.read(spacesProvider.notifier).addNewSpaceToDB(
                      spaceName: demoSpace.name,
                    );
              },
              icon: Icon(
                Icons.add_circle,
                size: 24,
                color: AppColors.secondaryColor.withOpacity(.7),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget suggestedBanner() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Suggested',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.white.withOpacity(.5),
          ),
        ),
      ],
    );
