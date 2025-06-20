import 'package:flatypus/common/methods.dart';
import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton({
    super.key,
    required this.label,
    this.iconData,
    this.navigateTo,
    this.foregroundColor = kBackgroundColor,
    this.function,
    this.verticalPadding,
  });
  final String label;
  final IconData? iconData;
  final Widget? navigateTo;
  final Color foregroundColor;
  final Function? function;
  final double? verticalPadding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: kTransparent,
        surfaceTintColor: kTransparent,
        elevation: 0,
        shadowColor: kTransparent,
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: foregroundColor, width: 1.5),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: verticalPadding ?? 0,
        ),
      ),
      onPressed: () {
        if (function != null) {
          function!();
          return;
        }
        if (navigateTo != null) {
          push(context, navigateTo!);
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (iconData != null)
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Icon(iconData, size: 14, color: foregroundColor),
            ),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: foregroundColor,
              letterSpacing: .5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
