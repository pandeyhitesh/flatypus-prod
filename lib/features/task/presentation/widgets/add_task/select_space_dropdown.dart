import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/features/common/controllers/space_selection_controller.dart';
import 'package:flatypus/features/space/data/models/space_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectSpaceDropdown extends ConsumerWidget {
  const SelectSpaceDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement providers
    List<SpaceModel> spaces = [];
    // final spaces = ref.watch(spacesProvider);
    final spaceController = ref.watch(spaceSelectionControllerProvider);
    return SizedBox(
      // width: kScreenWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: FittedBox(
          child: DropdownButton<SpaceModel>(
            value: spaceController,
            hint: Text(
              '-- Select Space --',
              style: TextStyle(color: AppColors.white.withOpacity(.5)),
            ),
            items:
                spaces
                    .map(
                      (sp) => DropdownMenuItem<SpaceModel>(
                        value: sp,
                        child: Text(sp.name),
                      ),
                    )
                    .toList(),
            onChanged:
                (newValue) =>
                    ref.read(spaceSelectionControllerProvider.notifier).state =
                        newValue,
            padding: EdgeInsets.zero,
            style: TextStyle(
              color: AppColors.white.withOpacity(.8),
              fontSize: 14,
              letterSpacing: .5,
              fontWeight: FontWeight.w400,
              overflow: TextOverflow.ellipsis,
            ),
            dropdownColor: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(15),
            iconEnabledColor: AppColors.white.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}
