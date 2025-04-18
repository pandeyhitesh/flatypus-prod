import 'package:flatypus/state/controllers/custom_week_days_selection.dart';

import '../common/enums.dart';

class TaskModel {
  String id;
  String name;
  String? assignedTo;
  DateTime? scheduledDate;
  bool isCompleted;
  String? completedBy;
  DateTime? completedDate;
  String? spaceId;
  String? houseKey;
  TaskSchedule? schedule;
  List<Day>? weekDays;
  bool? isSkipped;
  bool? active;
  List<String>? activities;

  TaskModel({
    required this.id,
    required this.name,
    this.assignedTo,
    required this.scheduledDate,
    this.isCompleted = false,
    this.completedBy,
    this.completedDate,
    this.spaceId,
    this.houseKey,
    this.schedule,
    this.weekDays,
    this.isSkipped,
    this.active,
    this.activities,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json['id'],
        name: json['name'],
        assignedTo: json['assignedTo'],
        scheduledDate: json['scheduledDate'] == null
            ? null
            : DateTime.parse(json['scheduledDate']),
        isCompleted: json['isCompleted'],
        isSkipped: json['isSkipped'],
        completedBy: json['completedBy'],
        spaceId: json['spaceId'],
        houseKey: json['houseKey'],
        schedule:
            TaskSchedule.values.firstWhere((sh) => sh.name == json['schedule']),
        completedDate: json['completedDate'] != null
            ? DateTime.parse(json['completedDate'])
            : null,
        weekDays: json['weekDays'] != null
            ? _parseWeekDays(json['weekDays'] as List<dynamic>)
            : null,
        active: json['active'],
        activities: json['activities'] != null
            ? List<String>.from(json['activities'])
            : [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'assignedTo': assignedTo,
        'scheduledDate': scheduledDate?.toIso8601String(),
        'isCompleted': isCompleted,
        'isSkipped': isSkipped,
        'completedBy': completedBy,
        'spaceId': spaceId,
        'schedule': schedule?.name,
        'houseKey': houseKey,
        'completedDate': completedDate?.toIso8601String(),
        'weekDays': schedule != TaskSchedule.customWeek
            ? null
            : weekDays
                ?.where((d) => d.isSelected)
                .map((day) => day.dayNo.toString())
                .toList(),
        'active': active,
        'activities': activities ?? [],
      };

  static List<Day> _parseWeekDays(List<dynamic> dayNumbers) {
    return customWeekDays
        .map((day) => Day(
              dayNo: day.dayNo,
              day: day.day,
              d: day.d,
              isSelected: dayNumbers.any((d) => d == day.dayNo.toString()),
            ))
        .toList();

    return dayNumbers.map((dayNo) {
      // Find the Day object by dayNo
      Day day =
          customWeekDays.firstWhere((day) => day.dayNo.toString() == dayNo);

      // Return a new Day object with isSelected set to true
      return Day(
        dayNo: day.dayNo,
        day: day.day,
        d: day.d,
        isSelected: true,
      );
    }).toList();
  }

  @override
  String toString() {
    return 'TaskModel{id: $id, name: $name, assignedTo: $assignedTo, scheduledDate: $scheduledDate, isCompleted: $isCompleted, completedBy: $completedBy, completedDate: $completedDate, spaceId: $spaceId,houseKey: $houseKey, schedule: $schedule, weekDays: $weekDays, active: $active, activities: $activities}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          assignedTo == other.assignedTo &&
          scheduledDate == other.scheduledDate &&
          isCompleted == other.isCompleted &&
          isSkipped == other.isSkipped &&
          completedBy == other.completedBy &&
          completedDate == other.completedDate &&
          spaceId == other.spaceId &&
          schedule == other.schedule &&
          active == other.active;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      assignedTo.hashCode ^
      scheduledDate.hashCode ^
      isCompleted.hashCode ^
      isSkipped.hashCode ^
      completedBy.hashCode ^
      completedDate.hashCode ^
      spaceId.hashCode ^
      schedule.hashCode ^
      isSkipped.hashCode ^
      active.hashCode;

  TaskModel copyWith({
    String? id,
    String? name,
    String? assignedTo,
    DateTime? scheduledDate,
    bool? isCompleted,
    String? completedBy,
    DateTime? completedDate,
    String? spaceId,
    String? houseKey,
    TaskSchedule? schedule,
    List<Day>? weekDays,
    bool? isSkipped,
    bool? active,
    List<String>? activities,
    bool copyExact = false,
  }) =>
      TaskModel(
          id: id ?? this.id,
          name: name ?? this.name,
          scheduledDate:
              copyExact ? scheduledDate : scheduledDate ?? this.scheduledDate,
          assignedTo: copyExact ? assignedTo : assignedTo ?? this.assignedTo,
          isCompleted: isCompleted ?? this.isCompleted,
          isSkipped: isCompleted ?? this.isSkipped,
          completedBy: completedBy ?? this.completedBy,
          spaceId: spaceId ?? this.spaceId,
          houseKey: houseKey ?? this.houseKey,
          schedule: schedule ?? this.schedule,
          completedDate: completedDate ?? this.completedDate,
          weekDays: weekDays ?? this.weekDays,
          active: active ?? this.active,
          activities: activities ?? this.activities);
}
