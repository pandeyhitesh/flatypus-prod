import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmptyContentPlaceHolder extends StatelessWidget {
  const EmptyContentPlaceHolder({super.key, this.icon, this.label});
  final IconData? icon;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon ?? FontAwesomeIcons.boxOpen,
                size: 50, color: Colors.white24),
            const SizedBox(height: 12),
            Text(
              label ?? 'No Content',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.white24),
            )
          ],
        ),
      ),
    );
  }
}
