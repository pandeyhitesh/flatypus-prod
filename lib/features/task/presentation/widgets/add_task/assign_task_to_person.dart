import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/features/common/controllers/task_assigned_to_controller.dart';
import 'package:flatypus/features/house/domain/entities/house.dart';
import 'package:flatypus/features/task/presentation/widgets/add_task/assigned_user_card.dart';
import 'package:flatypus/features/profile/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssignTaskToPerson extends ConsumerWidget {
  const AssignTaskToPerson({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement providers
    // final houseController = ref.watch(houseProvider);
    // final usersController = ref.watch(usersProvider);
    House? houseController;
    final assignmentController = ref.watch(taskAssignedToProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: kScreenWidth,
        child: DropdownButton<String>(
          value: assignmentController?.id,
          hint: Text(
            '-- Select Assignee --',
            style: TextStyle(color: AppColors.white.withOpacity(.5)),
          ),
          items:
              houseController?.members!.map((usr) {
                // TODO: get user from provider
                // final user = ref.read(usersProvider.notifier).getUserByUid(usr);
                FlatypusUserModel? user;
                return DropdownMenuItem(
                  value: usr.id,
                  child: AssignedUserCard(user: user),
                );
              }).toList(),
          onChanged: (selectedUid) async {
            if (selectedUid == null) return;

            /// final selectedUser = await UserServices().getUserByUid(selectedUid);
            // TODO: implement providers
            // final selectedUser = ref
            //     .read(usersProvider.notifier)
            //     .getUserByUid(selectedUid);
            FlatypusUserModel? selectedUser;
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
