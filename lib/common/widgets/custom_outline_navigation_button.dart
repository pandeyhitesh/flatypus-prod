import 'package:flutter/material.dart';

import '../methods.dart';

class CustomOutlineNavigationButton extends StatelessWidget {
  const CustomOutlineNavigationButton(
      {super.key,
      required this.label,
      this.navigateTo,
      this.foregroundColor = kBackgroundColor,
      this.function,
      this.verticalPadding});
  final String label;
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
          side: BorderSide(
            color: foregroundColor,
            width: 1.5,
          ),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: 12, vertical: verticalPadding ?? 0),
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
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: foregroundColor,
              letterSpacing: .5,
            ),
          ),
          const SizedBox(
            width: 3,
          ),
          Icon(
            Icons.arrow_forward_rounded,
            size: 14,
            color: foregroundColor,
          ),
        ],
      ),
    );
  }
}
