import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/theme/borders.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/features/common/widgets/text_with_icon_header.dart';
import 'package:flatypus/features/task/data/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClosedTaskCard extends ConsumerWidget {
  const ClosedTaskCard({super.key, required this.task});
  final TaskModel task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement space provider
    // final space = ref
    //     .read(spacesProvider.notifier)
    //     .getSpaceNameBySpaceId(task.spaceId);
    String? space;
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: GestureDetector(
        onTap: () {
          // TODO: implement provides
          // ref.read(taskDetailsProvider.notifier).initiateTask(task);
          // push(context, TaskDetailsScreen(task: task));
        },
        child: Container(
          decoration: kClickableCardDecoration,
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 6, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [_taskName(task.name), _taskSpace(space)],
            ),
          ),
        ),
      ),
    );
  }

  Widget _taskName(String? name) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Text(
      name ?? 'N/A',
      style: TextStyle(
        fontSize: 18,
        letterSpacing: .1,
        fontWeight: FontWeight.w400,
        color: AppColors.white.withAlpha(alphaFromOpacity(.9)),
        height: 1.2,
      ),
      maxLines: 3,
      // softWrap: false,
      overflow: TextOverflow.ellipsis,
    ),
  );

  Widget _taskSpace(String? space) => textWithIconHeader(
    value: 'Space: ${space ?? 'Deleted Space'}',
    icon: Icons.living_rounded,
    fontSize: 14,
    iconSize: 18,
  );
}
