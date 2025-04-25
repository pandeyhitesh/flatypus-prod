import 'package:flatypus/common/methods.dart';
import 'package:flatypus/common/widgets/bottom_navigation/custom_bottom_navigation_bar.dart';
import 'package:flatypus/common/widgets/custom_text_n_icon_button.dart';
import 'package:flatypus/screens/chatroom/chat_screen.dart';
import 'package:flatypus/screens/home/home_screen.dart';
import 'package:flatypus/screens/house/manage_house_screen.dart';
import 'package:flatypus/screens/house/methods/house_methods.dart';
import 'package:flatypus/screens/profile/profile/methods/profile_methods.dart';
import 'package:flatypus/screens/profile/profile/profile_screen.dart';
import 'package:flatypus/screens/task/add_task/add_task_screen.dart';
import 'package:flatypus/screens/task/tasks/tasks_screen.dart';
import 'package:flatypus/services/cloud_messaging/firebase_function_service.dart';
import 'package:flatypus/state/controllers/floating_add_button_controller.dart';
import 'package:flatypus/state/controllers/selected_page_controller.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

List<Widget> _appScreens = [
  const HomeScreen(),
  const ChatRoomScreen(),
  const TasksScreen(),
  // const ManageHouseScreen(),
  const ProfileScreen(),
];

// List<int> appScreensIndex = [0, 1, 2, 3];
enum AppScreens { home, chatroom, tasks, profile }

List<PreferredSizeWidget?> _appBarForScreens = [
  null,
  _appBar('Chatroom'),
  _appBar('Tasks'),
  _profileAppBar,
];

_appBar(String title) => AppBar(
  title: Text(title),
  centerTitle: true,
  backgroundColor: kBackgroundColor,
);

get _profileAppBar => AppBar(
  backgroundColor: kBackgroundColor,
  surfaceTintColor: kTransparent,
  actions: [
    Consumer(
      builder:
          (_, ref, __) => Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CustomTextNIconButton(
              label: 'Log Out',
              icon: Icons.logout,
              onTap: () async {
                await ProfileMethods.onLogoutButtonTap(ref);
              },
              foregroundColor: AppColors.yellowAccent,
            ),
          ),
    ),
  ],
);

class _AppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(selectedPageProvider);
    return Scaffold(
      key: ValueKey('app_screen'),
      resizeToAvoidBottomInset: true,
      appBar: _appBarForScreens[selectedIndex],
      backgroundColor: AppColors.backgroundColor,
      floatingActionButton:
          ref.watch(floatingAddButtonControllerProvider)
              ? FloatingActionButton(
                onPressed: () {
                  // check if house is added
                  final isHouseAvailable = HouseMethods.isHouseAvailable(
                    ref: ref,
                  );
                  if (!isHouseAvailable) return;
                  push(context, AddTaskScreen());
                },
                backgroundColor: AppColors.yellowAccent2,
                tooltip: 'Add New Task',
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const FaIcon(
                  FontAwesomeIcons.plus,
                  color: AppColors.white,
                ),
              )
              : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: SafeArea(child: _appScreens[selectedIndex]),
    );
  }
}
