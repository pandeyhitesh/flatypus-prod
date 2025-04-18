import 'package:flatypus/common/methods.dart';
import 'package:flatypus/screens/home/components/assigned_tasks.dart';
import 'package:flatypus/screens/home/components/associated_house.dart';
import 'package:flatypus/screens/home/components/house_spaces.dart';
import 'package:flatypus/screens/home/widgets/app_name_logo.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/app_header.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await HouseService().getHouseByUserId();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kScreenHeight,
      width: kScreenWidth,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          const SliverAppBar(
            // title: ApplicationHeader(),
            pinned: true,
            centerTitle: false,
            // toolbarHeight: 100,
            backgroundColor: kBackgroundColor,
            expandedHeight: 100,
            elevation: 100,

            surfaceTintColor: AppColors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: ApplicationHeader(),
              expandedTitleScale: 1.35,
              titlePadding:
                  EdgeInsets.symmetric(horizontal: kScreenPadding, vertical: 8),
              collapseMode: CollapseMode.parallax,
              centerTitle: false,
            ),
          ),
          SliverToBoxAdapter(
            child: columns(),
          ),
        ],
      ),
    );
  }

  Widget columns() => const Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ApplicationHeader(),
            SizedBox(height: 48),
            AssociatedHouse(),
            AssignedTasks(title: 'Tasks for the Day', taskForDay: true),
            HouseSpacesSection(),
            AssignedTasks(title: 'Backlog Tasks'),
            SizedBox(
                height: 200,
                child: Center(
                    child: AppNameLogo(fontSize: 34, color: Colors.white10)))
          ]);
}
