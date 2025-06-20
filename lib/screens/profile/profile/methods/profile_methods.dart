import 'package:color_log/color_log.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatypus/common/methods.dart';
import 'package:flatypus/common/methods/date_selection.dart'
    show selectDateFromCalendar;
import 'package:flatypus/common/methods/show_confirmation_dialog.dart';
import 'package:flatypus/common/snackbar.dart';
import 'package:flatypus/screens/authentication/auth_screen.dart';
import 'package:flatypus/state/controllers/task_date_selection_controller.dart';
import 'package:flatypus/state/providers/auth_provider.dart';
import 'package:flatypus/state/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileMethods {
  ProfileMethods._();

  static Future<void> onLogoutButtonTap(BuildContext context, WidgetRef ref) async {
    try {
      final confirmation = await showCustomConfirmationDialog(
        header: 'Logout!',
        noteText: 'Do you want to logout for sure?',
      );
      if (confirmation ?? false) {
        await ref.read(authProvider.notifier).logout(context);
        pushAndRemoveAll(const AuthScreen());
        showSuccessSnackbar(label: 'Logout successful!');
      }
    } catch (e) {
      showErrorSnackbar(
        label: 'Error occurred while logging out. Please try later!',
      );
      clog.error(e.toString());
    }
  }

  static Future<void> onEditDateOfBirthButtonTap({
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    try {
      final dob = await selectDateFromCalendar(
        context: context,
        ref: ref,
        dateController: taskDateSelectionControllerProvider,
        firstDate: DateTime(today.year-100, 1,1),
        lastDate: today,
      );
      clog.checkSuccess(true, 'Dob : $dob');
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;
      ref
          .read(usersProvider.notifier)
          .updateDateOfBirth(userId: user.uid, dateOfBirth: dob);
      showSuccessSnackbar(label: 'Date of birth updated successfully!');
    } catch (e) {
      showErrorSnackbar(
        label: 'Error occurred while updating date of birth. Please try later!',
      );
      clog.error(e.toString());
    }
  }
}
