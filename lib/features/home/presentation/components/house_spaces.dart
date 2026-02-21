import 'package:flatypus/constants/demo_data.dart';
import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/features/common/widgets/component_header.dart';
import 'package:flatypus/features/common/widgets/custom_grid_view.dart';
import 'package:flatypus/features/home/presentation/widgets/home_screen_section_header.dart';
import 'package:flatypus/features/home/presentation/widgets/space_card.dart';
import 'package:flatypus/features/home/presentation/widgets/space_suggestion_card.dart';
import 'package:flatypus/features/space/data/models/space_model.dart';
import 'package:flatypus/features/space/presentation/pages/add_space_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HouseSpacesSection extends ConsumerStatefulWidget {
  const HouseSpacesSection({super.key, this.showAllElements = false});
  final bool showAllElements;

  @override
  ConsumerState<HouseSpacesSection> createState() => _HouseSpacesSectionState();
}

class _HouseSpacesSectionState extends ConsumerState<HouseSpacesSection> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //TODO: read housekey, spaces from providers
      // ref.read(houseProvider)?.houseKey;
      // await ref.read(spacesProvider.notifier).getSpacesByhouseKey();
    });
  }

  get _emptySpacesSuggestionCards => List.generate(
    suggestedSpaces.length,
    (index) => spaceSuggestionCard(suggestedSpaces[index]),
  );

  List<Widget> _selectedSpacesCards(List<SpaceModel> spaces) {
    if (widget.showAllElements || spaces.length < 4) {
      return spaces.map((sp) => SpaceCard(space: sp)).toList();
    } else {
      List<Widget> widgets = spaces
          .map((sp) => SpaceCard(space: sp))
          .toList()
          .sublist(0, widget.showAllElements ? null : 3);
      widgets.add(
        SpaceCard(space: suggestedSpaces.first, isShowMoreCard: true),
      );
      return widgets;
    }
  }

  @override
  Widget build(BuildContext context) {
    //TODO: implement the providers
    // ref.watch(houseProvider);
    // final selectedSpaces = ref.watch(spacesProvider);
    final selectedSpaces = <SpaceModel>[];
    return Padding(
      padding: kHorizontalScrPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          HomeScreenSectionHeader(
            destinationScreen: AddSpaceScreen(),
            title: 'Available Spaces',
            buttonText: 'Add Space',
          ),
          const SizedBox(height: 16),
          SizedBox(
            // height: 90,
            child:
                selectedSpaces.isNotEmpty
                    ? customGridView(
                      children: _selectedSpacesCards(selectedSpaces),
                      physics: const NeverScrollableScrollPhysics(),
                    )
                    : customGridView(
                      children: _emptySpacesSuggestionCards,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
          ),
        ],
      ),
    );
  }
}
