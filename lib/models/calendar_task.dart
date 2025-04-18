import 'package:flatypus/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';



class MeetingDataSource extends CalendarDataSource {
  // List<CalendarTask> tasks = [];
  MeetingDataSource(List<CalendarTask> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].from.add(const Duration(hours: 1));
  }

  @override
  String getSubject(int index) {
    return appointments![index].taskName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }

  TaskModel task(int index) {
    return appointments![index].task;
  }
}

class CalendarTask {
  CalendarTask(
      this.taskName, this.from, this.background, this.isAllDay, this.task);

  String taskName;
  DateTime from;
  Color background;
  bool isAllDay;
  TaskModel task;
}
