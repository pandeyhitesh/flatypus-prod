import 'package:flutter_riverpod/flutter_riverpod.dart';

class Day {
  final String day;
  final String d;
  final int dayNo;
  bool isSelected;

  Day({
    required this.dayNo,
    required this.day,
    required this.d,
    this.isSelected = false,
  });


  @override
  String toString() {
    return 'Day{day: $day, d: $d, dayNo: $dayNo, isSelected: $isSelected}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Day &&
          runtimeType == other.runtimeType &&
          day == other.day &&
          d == other.d &&
          dayNo == other.dayNo &&
          isSelected == other.isSelected;

  @override
  int get hashCode =>
      day.hashCode ^ d.hashCode ^ dayNo.hashCode ^ isSelected.hashCode;


}

final customWeekDays = <Day>[
  Day(dayNo: 7, day: 'Sunday', d: 'S'),
  Day(dayNo: 1, day: 'Monday', d: 'M'),
  Day(dayNo: 2, day: 'Tuesday', d: 'T'),
  Day(dayNo: 3, day: 'Wednesday', d: 'W'),
  Day(dayNo: 4, day: 'Thursday', d: 'T'),
  Day(dayNo: 5, day: 'Friday', d: 'F'),
  Day(dayNo: 6, day: 'Saturday', d: 'S'),
];

class CustomWeekSelectionNotifier extends StateNotifier<List<Day>> {
  CustomWeekSelectionNotifier() : super(customWeekDays);

  void updateDaySelection(int dayNo) {
    List<Day> tempState = [...state];
    Day selectedDay = tempState.firstWhere((d) => d.dayNo == dayNo);
    final isSelected = selectedDay.isSelected;
    selectedDay.isSelected = !isSelected;
    state = tempState;
  }

  List<String>? get selectedDays {
    try {
      List<String> selectedDays = [];
      state
          .where((day) => day.isSelected)
          .map((d) => selectedDays.add(d.dayNo.toString()))
          .toList();
      return selectedDays;
    } catch (e) {
      return null;
    }
  }
}

final customWeekSelectionProvider =
    StateNotifierProvider<CustomWeekSelectionNotifier, List<Day>>(
  (ref) => CustomWeekSelectionNotifier(),
);
