import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SpaceNameTag extends StatelessWidget {
  const SpaceNameTag(
      {super.key, required this.spaceName, this.isCompact = false});
  final String spaceName;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.yellowAccent.withOpacity(.5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 3,
        ),
        child: Text(
          spaceName,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.white,
              height: isCompact ? 0 : null),
          maxLines: 2,
          softWrap: false,
          overflow: TextOverflow.fade,
        ),
      ),
    );
  }
}
