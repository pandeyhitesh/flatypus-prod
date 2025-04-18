import 'package:flatypus/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FilterItem extends StatelessWidget {
  const FilterItem(
      {super.key,
      required this.label,
      required this.isSelected,
      this.color = AppColors.yellowAccent2,
      required this.icon,
      this.iconSize = 14, required this.onTap});
  final String label;
  final bool isSelected;
  final Color color;
  final IconData icon;
  final double iconSize;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> onTap.call(),
      child: Container(
        // height: 34,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isSelected ? color : Colors.transparent,
            border: Border.all(width: 1.5, color: AppColors.yellowAccent2)),
        margin: const EdgeInsets.only(right: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon,
                  size: iconSize, color: isSelected ? AppColors.white : color),
              Padding(
                padding: const EdgeInsets.only(left: 6.0, right: 8.0),
                child: Text(label,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: .5,
                        color: isSelected ? AppColors.white : color)),
              ),
              isSelected
                  ? const Icon(FontAwesomeIcons.check,
                      color: AppColors.white, size: 16)
                  : Icon(FontAwesomeIcons.solidCircle, color: color, size: 6)
            ],
          ),
        ),
      ),
    );
  }
}
