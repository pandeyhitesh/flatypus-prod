import 'package:flatypus/common/methods.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flatypus/theme/borders.dart';
import 'package:flutter/material.dart';

class MenuOptionCard extends StatelessWidget {
  const MenuOptionCard({super.key, required this.onTap, required this.icon, required this.label, this.fontSize});
  final void Function(BuildContext) onTap;
  final IconData icon;
  final String label;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kMenuCardPadding,
      child: InkWell(
        onTap: () => onTap(context),
        borderRadius: kMenuCardBorderRadius,
        child: Container(
          height: 50,
          width: kScreenWidth,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: kMenuCardBorderRadius,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: fontSize ?? 22),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                 label,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(letterSpacing: .5),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
