import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TinyEditButton extends StatelessWidget {
  const TinyEditButton({super.key, required this.onTap});
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 26,
        width: 30,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColors.white.withAlpha(70)),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Center(
            child: FittedBox(
              child: FaIcon(
                FontAwesomeIcons.pencil,
                color: AppColors.white.withAlpha(alphaFromOpacity(.9)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
