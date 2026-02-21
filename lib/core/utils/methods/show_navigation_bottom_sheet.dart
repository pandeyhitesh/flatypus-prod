import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/core/utils/snackbar.dart';
import 'package:flatypus/features/common/widgets/bottom_navigation/update_phone_number.dart';
import 'package:flatypus/features/profile/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomSheetManager {
  static Future<T?> showCustomBottomSheet<T>({
    required BuildContext context,
    required Widget widget,
  }) async {
    return await showModalBottomSheet<T>(
      context: context,
      backgroundColor: AppColors.backgroundColor,
      useSafeArea: true,
      elevation: 30,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: kScreenPadding,
            horizontal: kScreenPadding,
          ),
          child: SizedBox(
            width: kScreenWidth,
            child: widget,
            // child: Column(
            //   mainAxisSize: MainAxisSize.min,
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [widget],
            // ),
          ),
        );
      },
    );
  }

  static Future<bool> updatePhoneNumber({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    try {
      String? phoneNumber;
      final loggedInUser = FirebaseAuth.instance.currentUser;
      if (loggedInUser == null) {
        throw Exception('Failed to get current loggedIn user');
      }
      // TODO: implement users provider
      // final usersFromProvider = ref.read(usersProvider);
      final usersFromProvider = <UserModel>[];
      if (usersFromProvider.isEmpty) {
        final user = UserModel.fromFirebaseUser(loggedInUser);
        //TODO: add user to Provider
        // ref.read(usersProvider.notifier).setUsers([user]);
        phoneNumber = user.phoneNumber;
      } else {
        //TODO: add user to provider state
        // final user = ref
        //     .read(usersProvider.notifier)
        //     .getUserByUid(loggedInUser.uid);
        // phoneNumber = user?.phoneNumber;
      }
      await showCustomBottomSheet(
        context: context,
        widget: UpdatePhoneNumber(
          phoneNumber: phoneNumber,
          userId: loggedInUser.uid,
        ),
      );
    } catch (e) {
      showErrorSnackbar(label: e.toString());
    }

    return false;
  }
}
