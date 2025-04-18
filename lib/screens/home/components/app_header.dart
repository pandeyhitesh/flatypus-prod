import 'package:flatypus/common/enums.dart';
import 'package:flatypus/screens/app.dart';
import 'package:flatypus/screens/home/widgets/app_name_logo.dart';
import 'package:flatypus/screens/home/widgets/user_profile_image.dart';
import 'package:flatypus/state/controllers/selected_page_controller.dart';
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
