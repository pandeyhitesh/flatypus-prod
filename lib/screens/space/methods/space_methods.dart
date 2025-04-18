import 'package:flatypus/common/methods.dart';
import 'package:flatypus/common/snackbar.dart';
import 'package:flatypus/models/space_model.dart';
import 'package:flatypus/screens/task/add_task/add_task_screen.dart';
import 'package:flatypus/services/global_context.dart';
import 'package:flatypus/state/controllers/custom_week_days_selection.dart';
import 'package:flatypus/state/controllers/schedule_selection_controller.dart';
import 'package:flatypus/state/controllers/space_selection_controller.dart';
import 'package:flatypus/state/controllers/task_assigned_to_controller.dart';
import 'package:flatypus/state/controllers/task_date_selection_controller.dart';
import 'package:flatypus/state/providers/spaces_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/methods/show_confirmation_dialog.dart';

class SpaceMethods {
  const SpaceMethods._();

  static void onAddNewSpaceButtonTap({
    required WidgetRef ref,
    required String spaceName,
  }) async {
    final newSpace = await ref
        .read(spacesProvider.notifier)
        .addNewSpaceToDB(spaceName: spaceName);
    if (newSpace != null) {
      showSuccessSnackbar(label: "'$spaceName' added to Spaces successfully!");
      pop();
    } else {
      showErrorSnackbar(label: 'Failed to add the space. Please try later');
    }
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
    final result = await ref
        .read(spacesProvider.notifier)
        .deleteSpaceById(spaceId: space.id);
    if (result) {
      showSuccessSnackbar(label: "Space '${space.name}' deleted successfully!");
      pop();
    } else {
      showErrorSnackbar(label: 'Failed to delete space! Please try later.');
    }
  }

  static void onAddTaskForSpaceButtonTap({
    required WidgetRef ref,
    required SpaceModel space,
  }) async {
    ref.read(spaceSelectionControllerProvider.notifier).state = space;
    ref.invalidate(scheduleSectionControllerProvider);
    ref.invalidate(customWeekSelectionProvider);
    ref.invalidate(taskDateSelectionControllerProvider);
    ref.invalidate(taskAssignedToProvider);
    push(GlobalContext.navigationKey.currentContext!, AddTaskScreen());
  }
}
