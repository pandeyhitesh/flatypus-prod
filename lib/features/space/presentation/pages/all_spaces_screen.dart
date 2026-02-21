import 'package:flatypus/core/services/global_context.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/features/common/widgets/custom_grid_view.dart';
import 'package:flatypus/features/home/presentation/widgets/space_card.dart';
import 'package:flatypus/features/space/data/models/space_model.dart';
import 'package:flatypus/features/space/presentation/pages/add_space_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flatypus/core/theme/app_colors.dart';

class AllSpacesScreen extends ConsumerWidget {
  const AllSpacesScreen({super.key});

  get _appBar => AppBar(
    title: const Text('Spaces'),
    centerTitle: true,
    backgroundColor: kBackgroundColor,
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: IconButton(
          onPressed:
              () => push(
                GlobalContext.navigationKey.currentContext!,
                AddSpaceScreen(),
              ),
          icon: const Icon(Icons.add_business_outlined, color: AppColors.white),
          tooltip: 'Add new Space',
        ),
      ),
    ],
  );

  List<Widget> _selectedSpacesCards(List<SpaceModel> spaces) =>
      spaces.map((sp) => SpaceCard(space: sp)).toList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Implement get all spaces
    // final spaces = ref.watch(spacesProvider);
    final spaces = <SpaceModel>[];
    return Scaffold(
      appBar: _appBar,
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kScreenPadding),
          child: customGridView(children: _selectedSpacesCards(spaces)),
        ),
      ),
    );
  }
}
