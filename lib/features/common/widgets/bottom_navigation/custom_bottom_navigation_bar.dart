import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/features/common/controllers/selected_page_controller.dart';
// import 'package:flatypus/screens/app.dart' show App;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBottomNavigationBar extends ConsumerWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomAppBar(
      padding: EdgeInsets.zero,
      shape: const CircularNotchedRectangle(),
      // elevation: 0,
      // shadowColor: AppColors.white,
      notchMargin: 5.0,
      clipBehavior: Clip.antiAlias,
      surfaceTintColor: Colors.transparent,
      color: AppColors.secondaryColor.withAlpha(200),
      child: BottomNavigationBar(
        currentIndex: ref.watch(selectedPageProvider),
        onTap: (value) {
          ref.read(selectedPageProvider.notifier).state = value;

          final currentScreenName =
              context.findAncestorWidgetOfExactType<Scaffold>()?.key;
          if (currentScreenName != ValueKey('app_screen')) {
            pop();
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        // showSelectedLabels: true,
        // showUnselectedLabels: true,
        // selectedIconTheme: const IconThemeData(
        //   color: AppColors.selectedIconColor,
        //   size: 22,
        // ),
        // unselectedIconTheme: IconThemeData(
        //   color: AppColors.unselectedIconColor,
        //   size: 20,
        // ),
        // selectedLabelStyle: const TextStyle(
        //     color: AppColors.selectedIconColor,
        //     fontSize: 14,
        //     fontWeight: FontWeight.w700,
        //     letterSpacing: .5),
        // unselectedLabelStyle: const TextStyle(
        //     color: AppColors.selectedIconColor,
        //     fontSize: 14,
        //     fontWeight: FontWeight.w500,
        //     letterSpacing: .5),
        // selectedItemColor: AppColors.selectedIconColor,
        unselectedFontSize: 12,
        items: [
          _navBarItem(
            icon: FontAwesomeIcons.house,
            label: 'Home',
            activeIcon: FontAwesomeIcons.houseChimney,
          ),
          _navBarItem(
            icon: FontAwesomeIcons.comments,
            label: 'Chat',
            activeIcon: FontAwesomeIcons.solidComments,
          ),
          _navBarItem(
            icon: FontAwesomeIcons.barsStaggered, //peopleGroup,
            label: 'Tasks',
            activeIcon: FontAwesomeIcons.listCheck, //usersGear,
          ),
          _navBarItem(
            icon: FontAwesomeIcons.person,
            label: 'Profile',
            activeIcon: FontAwesomeIcons.userLarge,
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _navBarItem({
    required IconData icon,
    required String label,
    required IconData activeIcon,
  }) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 3.0),
        child: FaIcon(icon),
      ),
      label: label,
      activeIcon: Padding(
        padding: const EdgeInsets.only(bottom: 3.0),
        child: FaIcon(activeIcon),
      ),
    );
  }
}
