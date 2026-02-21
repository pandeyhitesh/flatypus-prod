import 'package:flatypus/core/utils/methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<DateTime?> selectDateFromCalendar({
  required BuildContext context,
  required WidgetRef ref,
  required StateProvider<DateTime?> dateController,
   DateTime? firstDate,
   DateTime? lastDate,
}) async {
  final selectedDate = await showDatePicker(
    context: context,
    firstDate: firstDate ?? today,
    lastDate: lastDate ?? lastAllowedFutureDate,
    initialDate: ref.read(dateController),
  );

  if (selectedDate != null) {
    ref.read(dateController.notifier).state = selectedDate;
  }
  return selectedDate;
}
