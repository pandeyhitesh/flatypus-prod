import 'package:flatypus/common/methods.dart';
import 'package:flatypus/common/widgets/empty_content_place_holder.dart';
import 'package:flatypus/screens/task/closed_tasks/widgets/closed_task_card.dart';
import 'package:flatypus/state/providers/tasks_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClosedTasksScreen extends ConsumerWidget {
  const ClosedTasksScreen({super.key});

  get _appBar => AppBar(
        backgroundColor: kBackgroundColor,
        surfaceTintColor: kTransparent,
        title: const Text('Closed Tasks'),
        centerTitle: true,
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final closedTasks = ref
        .watch(tasksProvider
            .select((list) => list.where((tsk) => !(tsk.active ?? false))))
        .toList();
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: _appBar,
      body: SafeArea(
          child: Padding(
        padding: kHorizontalScrPadding,
        child: Column(
          children: [
            if(closedTasks.isNotEmpty)
            Expanded(
                child: ListView.builder(
                    itemCount: closedTasks.length,
                    itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  index + 1 == closedTasks.length ? 100.0 : 0),
                          child: ClosedTaskCard(task: closedTasks[index]),
                        ))),
            if (closedTasks.isEmpty)
              const Flexible(
                  child: EmptyContentPlaceHolder(
                    label: 'No Tasks available',
                  ))
          ],
        ),
      )),
    );
  }
}
