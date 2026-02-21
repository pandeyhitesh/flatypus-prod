import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({
    super.key,
    required this.ref,
    required this.controller,
    required this.provider,
    required this.activeText,
    required this.inactiveText,
    this.width,
  });
  final WidgetRef ref;
  final bool controller;
  final StateProvider<bool> provider;
  final String activeText;
  final String inactiveText;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      value: controller,
      onToggle: (value) => ref.read(provider.notifier).state = value,
      activeText: activeText,
      activeTextColor: AppColors.white.withAlpha(240),
      inactiveTextColor: AppColors.white.withAlpha(240),
      activeColor: AppColors.yellowAccent.withAlpha(100),
      inactiveText: inactiveText,
      inactiveColor: AppColors.primaryColor,
      valueFontSize: 10,
      activeIcon: const Icon(FontAwesomeIcons.angleRight, color: Colors.black),
      inactiveIcon: const Icon(
        FontAwesomeIcons.angleRight,
        color: Colors.black,
      ),
      showOnOff: true,
      height: 30,
      width: width ?? 90,
      padding: 6,
      toggleColor: AppColors.white.withAlpha(240),
      inactiveSwitchBorder: Border.all(
        color: (AppColors.white).withAlpha(150),
        width: .5,
      ),
      duration: const Duration(milliseconds: 200),
    );
  }
}
