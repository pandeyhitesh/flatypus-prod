import 'package:flatypus/core/services/global_context.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/core/utils/methods/show_confirmation_dialog.dart';
import 'package:flatypus/core/utils/snackbar.dart';
import 'package:flatypus/features/common/controllers/custom_week_days_selection.dart';
import 'package:flatypus/features/common/controllers/schedule_selection_controller.dart';
import 'package:flatypus/features/common/controllers/task_assigned_to_controller.dart';
import 'package:flatypus/features/common/controllers/task_date_selection_controller.dart';
import 'package:flatypus/features/space/data/models/space_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SpaceMethods {
  const SpaceMethods._();

  static void onAddNewSpaceButtonTap({
    required WidgetRef ref,
    required String spaceName,
  }) async {
    // TODO: Implement add new space
    // final newSpace = await ref
    //     .read(spacesProvider.notifier)
    //     .addNewSpaceToDB(spaceName: spaceName);
    // if (newSpace != null) {
    //   showSuccessSnackbar(label: "'$spaceName' added to Spaces successfully!");
    //   pop();
    // } else {
    //   showErrorSnackbar(label: 'Failed to add the space. Please try later');
    // }
  }

  static void onDeleteSpaceButtonTap({
    required WidgetRef ref,
    required SpaceModel space,
  }) async {
    final confirmation = await showCustomConfirmationDialog(
      noteText:
          'Note: This will also delete all the tasks associated with this Space',
    );
    if (confirmation == null || !confirmation) return;
    // TODO: Implement delete space
    // final result = await ref
    //     .read(spacesProvider.notifier)
    //     .deleteSpaceById(spaceId: space.id);
    // if (result) {
    //   showSuccessSnackbar(label: "Space '${space.name}' deleted successfully!");
    //   pop();
    // } else {
    //   showErrorSnackbar(label: 'Failed to delete space! Please try later.');
    // }
  }

  static void onAddTaskForSpaceButtonTap({
    required WidgetRef ref,
    required SpaceModel space,
  }) async {
    // TODO: Implement add task for space
    // ref.read(spaceSelectionControllerProvider.notifier).state = space;
    ref.invalidate(scheduleSectionControllerProvider);
    ref.invalidate(customWeekSelectionProvider);
    ref.invalidate(taskDateSelectionControllerProvider);
    ref.invalidate(taskAssignedToProvider);
    // TODO: Implement add task for space -> navigate to add task screen
    // push(GlobalContext.navigationKey.currentContext!, AddTaskScreen());
  }
}
