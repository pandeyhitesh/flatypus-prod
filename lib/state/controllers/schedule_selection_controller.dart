import 'package:flatypus/common/enums.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scheduleSectionControllerProvider =
    StateProvider<TaskSchedule>((ref) => TaskSchedule.daily);
