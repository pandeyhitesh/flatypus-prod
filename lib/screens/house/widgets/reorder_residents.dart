import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatypus/common/snackbar.dart';
import 'package:flatypus/common/widgets/custom_outline_button.dart';
import 'package:flatypus/common/widgets/loading_overlay_screen.dart';
import 'package:flatypus/screens/house/methods/house_methods.dart';
import 'package:flatypus/screens/house/widgets/manage_residents_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/methods.dart';
import '../../../common/widgets/component_header.dart';
import '../../../state/providers/house_provider.dart';
import '../../../state/providers/users_provider.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/textstyles.dart';

class ReorderResidents extends ConsumerStatefulWidget {
  const ReorderResidents({super.key});

  @override
  ConsumerState<ReorderResidents> createState() => _ReorderResidentsState();
}

class _ReorderResidentsState extends ConsumerState<ReorderResidents> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _residentsSection(context, ref),
          ),
        ],
      ),
    );
  }

  _residentsSection(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.secondary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.secondary.withOpacity(0.15);
    final users = ref.watch(usersProvider);
    final house = ref.watch(houseProvider);
    final userOrder = house?.userOrder ?? [];
    final listHeight = userOrder.length * 75.0;
    return [
      const SizedBox(height: kScreenPadding),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          componentHeader('Residents'),
          IconButton(
            onPressed: () => push(context, const ManageResidentsScreen()),
            icon: const Icon(Icons.settings, size: 20, color: AppColors.white),
            visualDensity: VisualDensity.compact,
          )
        ],
      ),
      const SizedBox(height: 8),
      SizedBox(
        height: listHeight,
        child: Stack(
          children: [
            ReorderableListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final user = ref
                    .read(usersProvider.notifier)
                    .getUserByUid(userOrder[index].uid);
                final phoneNo = user?.phoneNumber;
                final phoneNumberText = (phoneNo == null || phoneNo.isEmpty)
                    ? 'Phone No. N/A'
                    : phoneNo;
                return ListTile(
                  key: Key('$index'),
                  tileColor: index.isEven ? evenItemColor : oddItemColor,
                  // title: Text(users[index].displayName!),
                  title: Text(user?.displayName ?? 'Name'),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.email ?? 'Email N/A',
                        style: reorderableSubTextStyle,
                      ),
                      Text(
                        phoneNumberText,
                        style: reorderableSubTextStyle,
                      ),
                    ],
                  ),
                  leading: Container(
                    width: 40,
                    height: 40,
                    color: AppColors.primaryColor,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        user?.photoURL ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                          Icons.error_outline,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  trailing: Icon(
                    Icons.reorder,
                    color: AppColors.white.withOpacity(.7),
                  ),
                );
              },
              itemCount: userOrder.length,
              onReorder: (oldIndex, newIndex) async {
                setState(() {
                  isLoading = true;
                });
                final success = await ref
                    .read(houseProvider.notifier)
                    .reorderUsers(oldIndex, newIndex);
                if (success) {
                  showSuccessSnackbar(
                      label: 'Residents order updated successfully!');
                } else {
                  showErrorSnackbar(label: 'Failed to update resident order!');
                }
                setState(() {
                  isLoading = false;
                });
              },
            ),
            if (isLoading) ShowLoadingOverlay(),
            // Container(
            //     color: ,
            //     child: Center(child: CircularProgressIndicator()))
          ],
        ),
      ),
      //exit House button
      _exitHouse(context)
    ];
  }

  Widget _exitHouse(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        width: kScreenWidth,
        child: CustomOutlineButton(
          foregroundColor: AppColors.yellowAccent,
          label: 'Exit House',
          iconData: Icons.exit_to_app,
          function: () {
            final currentUserId = FirebaseAuth.instance.currentUser?.uid;
            HouseMethods.removeUserFromHouse(context: context, ref: ref, userId: currentUserId);
          },
          verticalPadding: 18,
        ),
      ),
    );
  }
}
