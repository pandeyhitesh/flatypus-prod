import 'package:color_log/color_log.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatypus/core/services/global_context.dart';
import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/core/utils/methods/loading_methods.dart';
import 'package:flatypus/core/utils/methods/show_confirmation_dialog.dart';
import 'package:flatypus/core/utils/methods/show_custom_dialog.dart';
import 'package:flatypus/core/utils/snackbar.dart';
import 'package:flatypus/features/common/controllers/manage_residents_selection.dart';
import 'package:flatypus/features/common/controllers/selected_page_controller.dart';
import 'package:flatypus/features/common/pages/app.dart';
import 'package:flatypus/features/house/domain/entities/house.dart';
import 'package:flatypus/features/house/presentation/methods/add_house_confirmation_dialog.dart';
import 'package:flatypus/features/profile/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HouseMethods {
  const HouseMethods._();

  static void addNewHouseToDB({
    required BuildContext context,
    required WidgetRef ref,
    required String houseName,
    required String houseAddress,
  }) async {
    // TODO: implement addNewHouse method
    // Loader.startLoading(context, ref);
    // final response = await HouseService().createOrGetHouse(
    //   displayName: houseName,
    //   address: houseAddress,
    // );
    // Loader.stopLoading(context, ref);
    // print('Add house response = $response');
    // if (response != null) {
    //   // show success snackbar
    //   if (context.mounted) {
    //     final scaffoldMessenger = ScaffoldMessenger.of(context);
    //     scaffoldMessenger.showSnackBar(
    //       const SnackBar(
    //         content: Text('House Added'),
    //         backgroundColor: AppColors.yellowAccent,
    //         duration: Duration(milliseconds: 2000),
    //       ),
    //     );

    //     // updated state

    //     // pop the screen
    //     pop();
    //   }
    // } else {
    //   // show unsuccessful snack bar
    //   if (context.mounted) {
    //     final scaffoldMessenger = ScaffoldMessenger.of(context);
    //     scaffoldMessenger.showSnackBar(
    //       const SnackBar(
    //         content: Text('Error! Failed to add new house.'),
    //         backgroundColor: AppColors.errorColor,
    //         duration: Duration(milliseconds: 2000),
    //       ),
    //     );
    //   }

    // }
  }

  static void searchHouseByHouseKey({
    required BuildContext context,
    required String houseKey,
    required WidgetRef ref,
  }) async {
    // TODO: implement searchHouse method
    // try {
    //   Loader.startLoading(context, ref);
    //   final response = await HouseService().getHouseByHouseKey(houseKey);
    //   Loader.stopLoading(context, ref);
    //   if (response != null && context.mounted) {
    //     final isHouseAdded = await showAddHouseConfirmationDialog(
    //       pContext: context,
    //       house: response,
    //       ref: ref,
    //     );
    //     if (isHouseAdded == true) {
    //       ref.read(selectedPageProvider.notifier).state = AppScreens.home.index;
    //       pushAndRemoveAll(const App());
    //     }
    //     // show success snack bar
    //     // showSuccessSnackbar(context: context, label: 'label')
    //   } else {
    //     showErrorSnackbar(label: 'No house found with this key');
    //   }
    // } catch (e) {
    //   clog.error('Error: HouseMethods.searchHouseByHouseKey - e: $e');
    // } finally {
    //   Loader.stopLoading(context, ref);
    // }
  }

  static Future<void> addUserToHouse({
    required BuildContext context,
    required House house,
    required WidgetRef ref,
  }) async {
    if (house.houseKey == null) return;
    try {
      // TODO: implement add User to house method
      // Loader.startLoading(context, ref);
      // final currentUser = FirebaseAuth.instance.currentUser;
      // if (currentUser == null) return;
      // final user = UserModel.fromFirebaseUser(currentUser);

      // final isHouseAdded = await HouseService().addUserToHouse(
      //   house.houseKey!,
      //   user,
      // );
      // TODO: implement Providers
      // if (isHouseAdded) {
      // ref.read(houseProvider.notifier).setInitialState(house);
      // ref.invalidate(tasksProvider);
      // ref.invalidate(usersProvider);
      // ref.invalidate(spacesProvider);
      // ref.invalidate(houseProvider);

      // showSuccessSnackbar(label: 'House added successfully!');
      // -- send notifications to flatmates and new user
      // FirebaseFunctionService().callNewUserAddedNotification(
      //   ref: ref,
      //   houseId: house.id,
      //   userId: user.uid,
      // );
      // return;
      // } else {
      //   showErrorSnackbar(label: 'Failed to add house! Please try again');
      // }

      // Loader.stopLoading(context, ref);
      // pop(parameter: isHouseAdded);
    } catch (e) {
      clog.error('Error: HouseMethods.addUserToHouse - e: $e');
    } finally {
      Loader.stopLoading(context, ref);
    }
  }

  // static Future<void> deleteHouseMethodOnTap(WidgetRef ref) async {}

  static Future<void> removeUserFromHouse({
    required BuildContext context,
    required WidgetRef ref,
    String? userId,
  }) async {
    bool currentUser = false;

    try {
      Loader.startLoading(context, ref);
      if (userId == null) {
        final selectedUser = ref.read(manageResidentsSelectionProvider);
        userId = selectedUser?.uid;
      }
      final currentLoggedInUser = FirebaseAuth.instance.currentUser;
      if (currentLoggedInUser?.uid == userId) {
        currentUser = true;
      }
      if (userId == null) return;
      final confirmation = await showCustomConfirmationDialog(
        noteText:
            currentUser
                ? 'This will unlink you from the house and delete all your tasks.'
                : 'This will remove the user from the house and delete all their tasks.',
      );
      if (confirmation == null || !confirmation) return;
      // TODO: get housekey from provider
      // final houseKey = ref.read(houseProvider)?.id;

      // if (houseKey == null) return;
      // TODO: delete all tasks by user
      // final allTasksRemoved = await ref
      //     .read(tasksProvider.notifier)
      //     .updateTasksOnUserRemoval(userId: userId);
      // if (!allTasksRemoved) {
      //   throw Exception();
      // }
      // TODO: Call API service
      // final isUserRemoved = await HouseService().unlinkUserFromHouse(
      //   houseKey: houseKey,
      //   userId: userId,
      // );
      // TODO: implement providers
      // if (isUserRemoved) {
      //   if (currentUser) {
      //     showSuccessSnackbar(label: 'House was unlinked successfully!');
      //     ref.invalidate(tasksProvider);
      //     ref.invalidate(spacesProvider);
      //     ref.invalidate(usersProvider);
      //     ref.invalidate(taskHistoryProvider);
      //     ref.invalidate(taskDetailsProvider);
      //     ref.read(houseProvider.notifier).deleteHouse();
      //   } else {
      //     ref.read(houseProvider.notifier).getHouseFromFS();
      //     showSuccessSnackbar(label: 'Resident was removed successfully!');
      //   }
      //   pop();
      // } else {
      //   throw Exception();
      // }
    } catch (e) {
      showErrorSnackbar(label: 'Failed to unlink house! Please try again');
    } finally {
      Loader.stopLoading(context, ref);
    }
  }

  static bool isHouseAvailable({required WidgetRef ref}) {
    // TODO: implement house provider
    // final house = ref.read(houseProvider);

    // if (house != null) return true;
    // TODO: if house is not added, go to add house screen
    // push(GlobalContext.navigationKey.currentContext!, SearchHouseScreen());
    showSuccessSnackbar(
      label: 'You are not associated with any house. Please add a House first!',
    );
    return false;
  }

  static Future<void> sendWhatsAppMessage(WidgetRef ref) async {
    try {
      // TODO: implement house provider
      // final houseKey = ref.read(houseProvider)?.houseKey;
      String? houseKey;
      if (houseKey == null) throw Exception();
      const appUrl =
          'https://play.google.com/store/apps/details?id=com.pandeyhitesh.expenditure';
      String message =
          "📢 Join your Flat on Flatipus! 🏡\n\nHey! Let's manage your household tasks together on *Flatipus*. Use this *House Key* to join your flatmates:\n\n🔑 *$houseKey*\n\nDownload Flatipus and enter the key to get started! 📲\n\n$appUrl";
      final String encodedMessage = Uri.encodeComponent(message);
      final Uri whatsappUri = Uri.parse("https://wa.me/?text=$encodedMessage");

      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
      } else {
        throw Exception();
      }
    } catch (e) {
      showErrorSnackbar(
        label: 'Unable to open whatsApp at the moment. Please try later!',
      );
    }
  }

  static void copyHouseKey(WidgetRef ref) {
    try {
      // TODO: implement house key provider
      // final houseKey = ref.read(houseProvider)?.houseKey;
      String? houseKey;
      if (houseKey == null) throw Exception();
      Clipboard.setData(ClipboardData(text: houseKey));

      // Show a Snackbar as feedback
      showSuccessSnackbar(label: 'House Key copied to clipboard!');
    } catch (e) {
      showErrorSnackbar(label: 'Failed to copy the House key!');
    }
  }

  static void generateQRCode(BuildContext context, WidgetRef ref) async {
    try {
      // TODO: implement house provider
      // final house = ref.read(houseProvider);
      House? house;
      final houseKey = house?.houseKey;
      final houseName = house?.displayName;
      if (houseKey == null) throw Exception();
      await showCustomDialog<bool>(
        parentContext: context,
        headerText: 'Scan the QR Code to join ${houseName ?? 'the house'}',
        cancellationActionLabel: 'Close',
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: SizedBox(
            height: 200,
            width: 200,
            child: QrImageView(
              data: houseKey,
              version: QrVersions.auto,
              size: 200.0,
              eyeStyle: QrEyeStyle(
                color: AppColors.white,
                eyeShape: QrEyeShape.square,
              ),
              dataModuleStyle: QrDataModuleStyle(
                color: AppColors.white,
                dataModuleShape: QrDataModuleShape.circle,
              ),
            ),
          ),
        ),
      );
    } catch (e) {
      clog.error('Failed to Generate the QR Code for House key!. e: $e');
      showErrorSnackbar(label: 'Failed to Generate the QR Code for House key!');
    }
  }

  // static void scanQRCodeForHouseKey(BuildContext context, WidgetRef ref) async {
  //   try {
  //     final dynamic houseKey = await showCustomDialog<dynamic>(
  //       parentContext: context,
  //       headerText: 'Scan QR Code to join the house',
  //       body: ScanQrForHouseKey(),
  //     );
  //     if (houseKey == null) return;
  //     if (houseKey is! String) return;
  //     if (context.mounted) {
  //       searchHouseByHouseKey(context: context, houseKey: houseKey, ref: ref);
  //     }
  //   } catch (e) {
  //     clog.error('Failed to Scan the QR Code for House key!. e: $e');
  //     showErrorSnackbar(
  //       label:
  //           'Failed to Scan the QR Code for House key!. Enter the house key manually.',
  //     );
  //   }
  // }
}
