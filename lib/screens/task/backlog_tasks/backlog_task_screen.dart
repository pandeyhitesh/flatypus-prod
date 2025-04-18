import 'package:flatypus/common/methods.dart';
import 'package:flatypus/screens/task/backlog_tasks/widgets/show_backlog_task_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BacklogTaskScreen extends ConsumerWidget {
  const BacklogTaskScreen({super.key});

  get _appBar => AppBar(
        backgroundColor: kBackgroundColor,
        surfaceTintColor: kTransparent,
        title: const Text('Backlog Tasks'),
        centerTitle: true,
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: _appBar,
      body: SafeArea(
          child: Padding(
        padding: kHorizontalScrPadding,
        child: const ShowBacklogTaskList(),
      )),
    );
  }
}
