import 'package:flatypus/models/task_history_model.dart';
import 'package:flatypus/state/notifires/task_history_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final taskHistoryProvider =
    StateNotifierProvider<TaskHistoryNotifier, List<TaskHistoryModel>>(
        (ref) => TaskHistoryNotifier(ref));
