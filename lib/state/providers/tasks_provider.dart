import 'package:flatypus/models/task_model.dart';
import 'package:flatypus/state/notifires/tasks_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final tasksProvider = StateNotifierProvider<TasksNotifier, List<TaskModel>>(
  (ref) => TasksNotifier(ref),
);
