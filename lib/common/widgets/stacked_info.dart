import 'package:flatypus/theme/app_colors.dart';
import 'package:flutter/material.dart';

class Position {
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;

  const Position({this.left, this.right, this.top, this.bottom});
}

class StackedInfo extends StatelessWidget {
  const StackedInfo(
      {super.key,
      this.showIcon = true,
      required this.label,
      this.iconColor = primaryIconColor,
      this.position = bottomLeftPosition,
      this.iconData,
      this.textPaddingRight,
      this.backgroundColor,
      this.textColor});
  final bool showIcon;
  final String label;
  final Color iconColor;
  final IconData? iconData;
  final Position position;
  final double? textPaddingRight;
  final Color? backgroundColor;
  final Color? textColor;

  static const Color primaryIconColor = Colors.green;
  static const Color secondaryIconColor = AppColors.yellowAccent;
  static const Position bottomLeftPosition = Position(left: 0, bottom: 0);
  static const Position topRightPosition = Position(right: 0, top: 0);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: position.left,
        right: position.right,
        top: position.top,
        bottom: position.bottom,
        child: Container(
          height: 30,
          decoration: BoxDecoration(
              color: backgroundColor ?? Colors.white.withAlpha(200),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomLeft: Radius.circular(15),
              )),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (showIcon || iconData != null)
                iconData != null
                    ? Icon(iconData, size: 18, color: iconColor)
                    : Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            color: iconColor,
                            borderRadius: BorderRadius.circular(50)),
                      ),
              Padding(
                padding: EdgeInsets.only(
                    left: showIcon ? 6.0 : 0, right: textPaddingRight ?? 0),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    letterSpacing: .3,
                    fontWeight: FontWeight.w400,
                    color: textColor ?? Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
