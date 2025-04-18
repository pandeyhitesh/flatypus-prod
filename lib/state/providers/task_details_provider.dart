import 'package:flatypus/models/task_model.dart';
import 'package:flatypus/state/notifires/task_details_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final taskDetailsProvider =
    StateNotifierProvider<TaskDetailsNotifier, TaskModel?>(
        (ref) => TaskDetailsNotifier(ref));
