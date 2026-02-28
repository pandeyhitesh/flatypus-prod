
import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/features/common/controllers/floating_add_button_controller.dart';
import 'package:flatypus/features/common/controllers/selected_page_controller.dart';
import 'package:flatypus/features/common/widgets/bottom_navigation/custom_bottom_navigation_bar.dart';
import 'package:flatypus/features/common/widgets/custom_text_n_icon_button.dart';
import 'package:flatypus/features/home/presentation/pages/home_screen.dart';
import 'package:flatypus/features/house/presentation/methods/house_methods.dart';
import 'package:flatypus/features/profile/presentation/methods/profile_methods.dart';
import 'package:flatypus/features/profile/presentation/pages/profile_screen.dart';
import 'package:flatypus/features/task/presentation/pages/tasks_screen.dart';
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
  // const ChatRoomScreen(),
  const TasksScreen(),
  // const ManageHouseScreen(),
  const ProfileScreen(),
];

// List<int> appScreensIndex = [0, 1, 2, 3];
enum AppScreens { home, chatroom, tasks, profile }

List<PreferredSizeWidget?> _appBarForScreens(BuildContext context) => [
  null,
  _appBar('Chatroom'),
  _appBar('Tasks'),
  _profileAppBar(context),
];

_appBar(String title) => AppBar(
  title: Text(title),
  centerTitle: true,
  backgroundColor: kBackgroundColor,
);

_profileAppBar(BuildContext context) => AppBar(
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
                await ProfileMethods.onLogoutButtonTap(context, ref);
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
      appBar: _appBarForScreens(context)[selectedIndex],
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
                  // TODO: navigate to add task screen
                  // push(context, AddTaskScreen());
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
