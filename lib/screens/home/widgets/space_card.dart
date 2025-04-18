import 'package:flatypus/common/methods.dart';
import 'package:flatypus/models/space_model.dart';
import 'package:flatypus/screens/home/widgets/show_more_space_card.dart';
import 'package:flatypus/screens/space/manage_space_screen.dart';
import 'package:flatypus/services/global_context.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flatypus/theme/borders.dart';
import 'package:flatypus/theme/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../space/methods/space_methods.dart';

class SpaceCard extends StatelessWidget {
  const SpaceCard({
    super.key,
    required this.space,
    this.isShowMoreCard = false,
  });
  final SpaceModel space;
  final bool isShowMoreCard;

  @override
  Widget build(BuildContext context) {
    return isShowMoreCard
        ? const ShowMoreSpaceCard()
        : Container(
            decoration: kCardDecoration,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12),
                    child: Text(
                      space.name,
                      style: spaceTitleTextStyle,
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: _buttonsRowSection(),
                ),
              ],
            ),
          );
  }

  Widget _buttonsRowSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _manageSpaceIconButton(),
          _addTaskForSpaceButton(),
        ],
      ),
    );
  }

  Widget _manageSpaceIconButton() => IconButton(
        onPressed: () => push(
          GlobalContext.navigationKey.currentContext!,
          ManageSpaceScreen(space: space),
        ),
        icon: const Icon(
          Icons.settings,
          color: AppColors.white,
          size: 16,
        ),
        visualDensity: VisualDensity.compact,
        padding: EdgeInsets.zero,
      );

  Widget _addTaskForSpaceButton() {
    return Consumer(
      builder: (context, ref, _) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          visualDensity: VisualDensity.compact,
          backgroundColor: AppColors.backgroundColor,
          surfaceTintColor: kTransparent,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        ),
        onPressed: () =>
            SpaceMethods.onAddTaskForSpaceButtonTap(ref: ref, space: space),
        child: const Text(
          'Add Task',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 10,
            letterSpacing: .5,
          ),
        ),
      ),
    );
  }
}
