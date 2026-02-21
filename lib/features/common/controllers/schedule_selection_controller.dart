import 'package:flatypus/core/utils/enums.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scheduleSectionControllerProvider = StateProvider<TaskSchedule>(
  (ref) => TaskSchedule.daily,
);
