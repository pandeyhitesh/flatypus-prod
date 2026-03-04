import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/features/space/data/models/space_model.dart';
import 'package:flatypus/features/task/data/models/calendar_task.dart';
import 'package:flatypus/features/task/data/models/task_model.dart';
import 'package:flatypus/features/task/presentation/widgets/custom_apt_builder.dart';
import 'package:flatypus/features/profile/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ShowAgendaCalendar extends ConsumerWidget {
  const ShowAgendaCalendar({super.key, required this.agendaCalendarController});
  final CalendarController agendaCalendarController;

  List<CalendarTask> _getDataSource(List<TaskModel> tasks) {
    final List<CalendarTask> calendarTasks = <CalendarTask>[];
    for (TaskModel task in tasks) {
      if (task.scheduledDate != null) {
        calendarTasks.add(
          CalendarTask(
            task.name,
            task.scheduledDate!,
            AppColors.primaryColor,
            false,
            task,
          ),
        );
      }
    }
    return calendarTasks;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement providers
    // final tasks = ref.watch(
    //   tasksProvider.select(
    //     (tList) => tList.where((t) => t.active ?? false).toList(),
    //   ),
    // );
    final tasks = <TaskModel>[];
    return SfCalendar(
      minDate: DateTime.now().subtract(const Duration(days: 60)),
      maxDate: DateTime.now().add(const Duration(days: 60)),

      controller: agendaCalendarController,
      view: CalendarView.schedule,
      dataSource: MeetingDataSource(_getDataSource(tasks)),
      appointmentBuilder:
          (context, calendarAppointmentDetails) =>
              _buildCustomAppointment(context, calendarAppointmentDetails, ref),
      headerStyle: CalendarHeaderStyle(
        backgroundColor: AppColors.yellowAccent.withAlpha(70),
      ),
      // scheduleViewMonthHeaderBuilder: (context, details) {
      //   return Container();
      // },
      scheduleViewSettings: ScheduleViewSettings(
        monthHeaderSettings: MonthHeaderSettings(
          backgroundColor: AppColors.secondaryColor.withAlpha(100),
          height: 70,
          textAlign: TextAlign.left,
        ),
      ),
      scheduleViewMonthHeaderBuilder: (context, details) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.secondaryColor.withAlpha(50),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                monthFormat.format(details.date),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCustomAppointment(context, calendarAppointmentDetails, ref) {
    final calendarTask =
        calendarAppointmentDetails.appointments.first as CalendarTask;
    final task = calendarTask.task;
    // TODO: implement providers
    // final user = ref.read(usersProvider.notifier).getUserByUid(task.assignedTo);
    // final spaces = ref.read(spacesProvider);
    FlatypusUserModel? user;
    final spaces = <SpaceModel>[];
    return CustomAppointmentBuilder(task: task, user: user, spaces: spaces);
  }
}
