import 'package:color_log/color_log.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/core/utils/methods/date_selection.dart';
import 'package:flatypus/core/utils/methods/show_confirmation_dialog.dart';
import 'package:flatypus/core/utils/snackbar.dart';
import 'package:flatypus/features/auth/presentation/pages/auth_screen.dart';
import 'package:flatypus/features/auth/presentation/providers/auth_providers.dart';
import 'package:flatypus/features/common/controllers/task_date_selection_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileMethods {
  ProfileMethods._();

  static Future<void> onLogoutButtonTap(
    BuildContext context,
    WidgetRef ref,
  ) async {
    try {
      final confirmation = await showCustomConfirmationDialog(
        header: 'Logout!',
        noteText: 'Do you want to logout for sure?',
      );
      if (confirmation ?? false) {
        ref.read(logoutProvider);
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
        firstDate: DateTime(today.year - 100, 1, 1),
        lastDate: today,
      );
      clog.checkSuccess(true, 'Dob : $dob');
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;
      // TODO: implement providers
      // ref
      //     .read(usersProvider.notifier)
      //     .updateDateOfBirth(userId: user.uid, dateOfBirth: dob);
      showSuccessSnackbar(label: 'Date of birth updated successfully!');
    } catch (e) {
      showErrorSnackbar(
        label: 'Error occurred while updating date of birth. Please try later!',
      );
      clog.error(e.toString());
    }
  }
}
