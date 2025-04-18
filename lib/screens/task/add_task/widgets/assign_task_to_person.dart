import 'package:flatypus/screens/task/add_task/widgets/assigned_user_card.dart';
import 'package:flatypus/state/controllers/task_assigned_to_controller.dart';
import 'package:flatypus/state/providers/house_provider.dart';
import 'package:flatypus/state/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/methods.dart';
import '../../../../theme/app_colors.dart';

class AssignTaskToPerson extends ConsumerWidget {
  const AssignTaskToPerson({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final houseController = ref.watch(houseProvider);
    final usersController = ref.watch(usersProvider);
    final assignmentController = ref.watch(taskAssignedToProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: kScreenWidth,
        child: DropdownButton<String>(
          value: assignmentController?.uid,
          hint: Text(
            '-- Select Assignee --',
            style: TextStyle(
              color: AppColors.white.withOpacity(.5),
            ),
          ),
          items: houseController?.users!.map((usr) {
            final user = ref.read(usersProvider.notifier).getUserByUid(usr);
            return DropdownMenuItem(
              value: usr,
              child: AssignedUserCard(user: user),
            );
          }).toList(),
          onChanged: (selectedUid) async {
            if (selectedUid == null) return;
            // final selectedUser = await UserServices().getUserByUid(selectedUid);
            final selectedUser =
                ref.read(usersProvider.notifier).getUserByUid(selectedUid);
            if (selectedUser == null) return;
            ref.read(taskAssignedToProvider.notifier).state = selectedUser;
          },
          padding: EdgeInsets.zero,
          style: TextStyle(
            color: AppColors.white.withOpacity(.8),
            fontSize: 14,
            letterSpacing: .5,
            fontWeight: FontWeight.w400,
            overflow: TextOverflow.ellipsis,
          ),
          dropdownColor: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(15),
          iconEnabledColor: AppColors.white.withOpacity(.5),
        ),
      ),
    );
  }
}
