import 'package:flatypus/common/enums.dart';
import 'package:flatypus/common/methods.dart';
import 'package:flatypus/common/widgets/input_field_header.dart';
import 'package:flatypus/common/widgets/text_input_field_custom.dart';
import 'package:flatypus/screens/task/add_task/methods/add_task_methods.dart';
import 'package:flatypus/screens/task/add_task/widgets/assign_task_to_person.dart';
import 'package:flatypus/screens/task/add_task/widgets/custom_week_selection.dart';
import 'package:flatypus/screens/task/add_task/widgets/date_selection.dart';
import 'package:flatypus/screens/task/add_task/widgets/select_schedule_dropdown.dart';
import 'package:flatypus/screens/task/add_task/widgets/select_space_dropdown.dart';
import 'package:flatypus/state/controllers/schedule_selection_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/app_colors.dart';

class AddTaskScreen extends ConsumerWidget {
  AddTaskScreen({super.key});

  static const screenTitle = 'Add new task';

  final _taskNameController = TextEditingController();

  get _appBar => AppBar(
        backgroundColor: kBackgroundColor,
        title: const Text(
          screenTitle,
          style: TextStyle(color: AppColors.white),
        ),
        centerTitle: true,
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleController = ref.watch(scheduleSectionControllerProvider);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: _appBar,
      body: SafeArea(
        child: SizedBox(
          height: kScreenHeight,
          width: kScreenHeight,
          child: Stack(
            children: [
              Padding(
                padding: kHorizontalScrPadding,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      // task Name input
                      inputFieldHeader('Task Name'),
                      CustomTextInputField(
                        hintText: 'Enter a name for the task',
                        controller: _taskNameController,
                        borderType: UnderlineInputBorder,
                        horzPadding: true,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // associated Space input
                      inputFieldHeader('Associated Space'),
                      const SelectSpaceDropdown(),
                      const SizedBox(
                        height: 16,
                      ),
                      // Select schedule type
                      inputFieldHeader('Select a Schedule'),
                      const SelectScheduleDropdown(),
                      const SizedBox(
                        height: 16,
                      ),
                      // custom week selection
                      ..._customWeekSelectionSection(ref, scheduleController),
                      // Date selection
                      inputFieldHeader('Starts from'),
                      const TaskDateSelection(),
                      const SizedBox(
                        height: 16,
                      ),
                      // assign to a person
                      inputFieldHeader('Assign to'),
                      const AssignTaskToPerson(),
                      const SizedBox(height: 200)
                    ],
                  ),
                ),
              ),
              _addTaskButton(context, ref),
            ],
          ),
        ),
      ),
    );
  }

  _customWeekSelectionSection(WidgetRef ref, TaskSchedule schedule) {
    return schedule == TaskSchedule.customWeek
        ? [
            inputFieldHeader('Select Days'),
            const CustomWeekSelection(),
            const SizedBox(
              height: 16,
            ),
          ]
        : [];
  }

  _addTaskButton(BuildContext context, WidgetRef ref) {
    return Positioned(
      bottom: 0,
      child: SizedBox(
        width: kScreenWidth,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kScreenPadding,
            vertical: kScreenPadding,
          ),
          child: ElevatedButton(
            onPressed: () => AddTaskMethods.addTaskButtonOnTap(
              context: context,
              ref: ref,
              taskName: _taskNameController.text,
            ),
            child: const Text('Add Task'),
          ),
        ),
      ),
    );
  }
}
