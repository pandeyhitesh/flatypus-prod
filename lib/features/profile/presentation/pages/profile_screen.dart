import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/features/house/presentation/methods/house_methods.dart';
import 'package:flatypus/features/profile/presentation/widgets/menu_option_card.dart';
import 'package:flatypus/features/profile/presentation/widgets/profile_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  void _onTaskHistoryTap(BuildContext context, WidgetRef ref) {
    // check if house is added
    final isHouseAvailable = HouseMethods.isHouseAvailable(ref: ref);
    if (!isHouseAvailable) return;
    // TODO: implement providers
    // ref.read(taskHistoryProvider.notifier).getTaskHistoryByHouseKey();
    // ref.invalidate(taskHistoryFilterProvider);
    // push(
    //   context,
    //   const TaskHistoryScreen(),
    // );
  }

  void _onClosedTaskTap(BuildContext context, WidgetRef ref) {
    // check if house is added
    final isHouseAvailable = HouseMethods.isHouseAvailable(ref: ref);
    if (!isHouseAvailable) return;
    // TODO: implement providers
    // ref.read(taskHistoryProvider.notifier).getTaskHistoryByHouseKey();
    // push(
    //   context,
    //   const ClosedTasksScreen(),
    // );
  }

  void _onBacklogTaskTap(BuildContext context, WidgetRef ref) {
    // check if house is added
    final isHouseAvailable = HouseMethods.isHouseAvailable(ref: ref);
    if (!isHouseAvailable) return;

    /// ref.read(taskHistoryProvider.notifier).getTaskHistoryByHouseKey();
    // TODO: implement BackloTaskScreen
    // push(
    //   context,
    //   const BacklogTaskScreen(),
    // );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProfileSection(),
          const SizedBox(height: 50),
          MenuOptionCard(
            icon: Icons.history,
            label: 'Task History',
            onTap: (context) => _onTaskHistoryTap(context, ref),
          ),
          MenuOptionCard(
            icon: FontAwesomeIcons.circleStop,
            label: 'Closed Tasks',
            onTap: (context) => _onClosedTaskTap(context, ref),
          ),
          MenuOptionCard(
            icon: FontAwesomeIcons.houseCircleExclamation,
            label: 'Backlog Tasks',
            fontSize: 18,
            onTap: (context) => _onBacklogTaskTap(context, ref),
          ),

          // MenuOptionCard(
          //     icon: FontAwesomeIcons.circleStop,
          //     label: 'Closed Tasks',
          //     onTap: (context) => _onClosedTaskTap(context, ref)),
        ],
      ),
    );
  }
}
