import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/features/common/controllers/calendar_agenda_view_mode_controller.dart';
import 'package:flatypus/features/common/controllers/display_tasks_date_selection.dart';
import 'package:flatypus/features/common/widgets/custom_switch.dart';
import 'package:flatypus/features/common/widgets/custom_text_n_icon_button.dart';
import 'package:flatypus/features/space/data/models/space_model.dart';
import 'package:flatypus/features/task/data/models/task_model.dart';
import 'package:flatypus/features/task/presentation/widgets/show_agenda_calendar.dart';
import 'package:flatypus/features/task/presentation/widgets/show_timeline_tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key});

  @override
  ConsumerState<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> {
  List<TaskModel> _selectedTasks = [];
  final DatePickerController _timelineCalendarController =
      DatePickerController();
  final CalendarController _agendaCalendarController = CalendarController();

  void _scrollCalendarToToday() {
    final isAgenda = ref.read(calendarAgendaViewModeProvider);
    if (isAgenda) {
      setState(() {
        _agendaCalendarController.displayDate = today;
      });
    } else {
      if (mounted) {
        // _timelineCalendarController.setDateAndAnimate(today);
        ref.read(displayTasksSelectedDateProvider.notifier).state = today;
        _timelineCalendarController.animateToDate(
          today,
          duration: const Duration(milliseconds: 100),
        );
      }
    }
  }

  Future<void> _tasksSelectionBasedOnSelectedDate(DateTime? date) async {
    // TODO: imeplement providers
    // final tasksResult = await ref
    //     .read(tasksProvider.notifier)
    //     .getFilteredTasks(date: date, selfTasks: false);
    // setState(() {
    //   _selectedTasks = tasksResult;
    // });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(displayTasksSelectedDateProvider.notifier).state = today;
      _tasksSelectionBasedOnSelectedDate(today);
      _timelineCalendarController.animateToDate(
        today,
        duration: const Duration(milliseconds: 300),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement providers
    // final tasks = ref.watch(tasksProvider);
    // final spaces = ref.watch(spacesProvider);
    final spaces = <SpaceModel>[];
    final controller = ref.watch(calendarAgendaViewModeProvider);

    ref.listen(displayTasksSelectedDateProvider, (previous, next) {
      if (previous != next) {
        _tasksSelectionBasedOnSelectedDate(next);
      }
    });

    ref.listen(calendarAgendaViewModeProvider, (previous, isAgendaMode) {
      if (previous != isAgendaMode) {
        if (isAgendaMode) {
          _tasksSelectionBasedOnSelectedDate(today);
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _scrollCalendarToToday();
          }
        });
      }
    });

    //TODO: implement providers
    // ref.listen(tasksProvider, (previous, next) {
    //   if (previous == next) return;
    //   _tasksSelectionBasedOnSelectedDate(
    //     ref.read(displayTasksSelectedDateProvider),
    //   );
    // });

    return SizedBox(
      height: kScreenHeight,
      width: kScreenWidth,
      child: Padding(
        padding: kHorizontalScrPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomSwitch(
                    ref: ref,
                    controller: controller,
                    provider: calendarAgendaViewModeProvider,
                    activeText: 'Agenda View',
                    inactiveText: 'Timeline View',
                    width: 120,
                  ),
                  CustomTextNIconButton(
                    label: 'Today',
                    icon: Icons.today,
                    onTap: _scrollCalendarToToday,
                    backgroundColor: AppColors.clickableCardColor,
                    borderRadius: 15,
                  ),
                ],
              ),
            ),
            if (!controller)
              Expanded(
                child: ShowTimelineTasks(
                  selectedTasks: _selectedTasks,
                  spaces: spaces,
                  timelineCalendarController: _timelineCalendarController,
                ),
              ),
            if (controller)
              Expanded(
                child: ShowAgendaCalendar(
                  agendaCalendarController: _agendaCalendarController,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
