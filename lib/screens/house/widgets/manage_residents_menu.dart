import 'package:flatypus/common/snackbar.dart';
import 'package:flatypus/screens/house/methods/house_methods.dart';
import 'package:flatypus/state/controllers/manage_residents_selection.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ManageResidentsMenu extends ConsumerWidget {
  const ManageResidentsMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme:
          const IconThemeData(color: AppColors.backgroundColor, size: 28.0),
      backgroundColor: AppColors.secondaryColor,
      visible: true,
      curve: Curves.bounceInOut,
      children: [_menuItem(ref, Icons.exit_to_app, 'Remove From House')],
    );
  }

  SpeedDialChild _menuItem(WidgetRef ref, IconData icon, String label) =>
      SpeedDialChild(
          child: Icon(icon, color: Colors.white),
          backgroundColor: AppColors.yellowAccent2,
          onTap: () {
            final selectedUser = ref.read(manageResidentsSelectionProvider);
            if (selectedUser == null) {
              showErrorSnackbar(label: 'Please select a user from the list');
              return;
            }
            HouseMethods.removeUserFromHouse(ref: ref, userId: selectedUser.uid);
          },
          label: label,
          labelStyle:
              const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: AppColors.primaryColor);
}
