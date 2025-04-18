import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatypus/common/methods.dart';
import 'package:flatypus/models/house_model.dart';
import 'package:flatypus/models/user_model.dart';
import 'package:flatypus/screens/house/widgets/manage_residents_menu.dart';
import 'package:flatypus/state/controllers/manage_residents_selection.dart';
import 'package:flatypus/state/providers/house_provider.dart';
import 'package:flatypus/state/providers/users_provider.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageResidentsScreen extends ConsumerWidget {
  const ManageResidentsScreen({super.key});
  get _appBar => AppBar(
        title: const Text('Manage Residents'),
        centerTitle: true,
        backgroundColor: kBackgroundColor,
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final house = ref.watch(houseProvider);
    List<UserOrder> users = [...?house?.userOrder];
    final loggedInUser = FirebaseAuth.instance.currentUser;
    final currentUser =
        users.firstWhereOrNull((u) => u.uid == loggedInUser?.uid);
    users.remove(currentUser);
    final userSelectionController = ref.watch(manageResidentsSelectionProvider);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: _appBar,
      floatingActionButton: const ManageResidentsMenu(),
      body: Padding(
        padding: kHorizontalScrPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = ref
                          .read(usersProvider.notifier)
                          .getUserByUid(users[index].uid);
                      return _residentCheckItem(
                          ref: ref,
                          user: user,
                          isSelected: userSelectionController == user);
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _residentCheckItem(
      {UserModel? user, required WidgetRef ref, required bool isSelected}) {
    return GestureDetector(
      onTap: () {
        if (user == null) return;
        final notifier = ref.read(manageResidentsSelectionProvider.notifier);
        notifier.state = !isSelected ? user : null;
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.primaryColor.withAlpha(200),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 2, color: AppColors.primaryColor)),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              value: isSelected,
              onChanged: (updatedSelection) {
                if (user == null) return;
                final notifier =
                    ref.read(manageResidentsSelectionProvider.notifier);
                notifier.state = (updatedSelection == true) ? user : null;
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              activeColor: AppColors.secondaryColor,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?.displayName ?? 'User Name',
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      letterSpacing: .3,
                      fontSize: 16),
                ),
                Text(
                  user?.email ?? 'Email: N/A',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      letterSpacing: .3,
                      fontSize: 13,
                      color: AppColors.white.withAlpha(200)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
