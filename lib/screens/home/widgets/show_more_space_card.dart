import 'package:flatypus/common/widgets/custom_outline_navigation_button.dart';
import 'package:flatypus/screens/space/all_spaces_screen.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

class ShowMoreSpaceCard extends StatelessWidget {
  const ShowMoreSpaceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.primaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 12.0, bottom: 12,),
            child: SizedBox(
              height: 32,
              child: CustomOutlineNavigationButton(
                label: 'Show more',
                navigateTo: const AllSpacesScreen(),
                foregroundColor: AppColors.white.withAlpha(200),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
