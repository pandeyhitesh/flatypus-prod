import 'package:flatypus/core/utils/app_screens.dart';
import 'package:flatypus/core/utils/enums.dart';
import 'package:flatypus/features/common/controllers/selected_page_controller.dart';
import 'package:flatypus/features/home/presentation/widgets/app_name_logo.dart';
import 'package:flatypus/features/home/presentation/widgets/user_profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApplicationHeader extends StatelessWidget {
  const ApplicationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero, //fromLTRB(24, 24, 16, 20),
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(child: AppNameLogo()),
            Flexible(
              child: Consumer(builder: (context, ref, _) => userProfileImage(
                level: Level.medium,
                onTap: () => ref.read(selectedPageProvider.notifier).state = AppScreens.profile.index,
                // update selected screen index for "Manage House" screen,
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
