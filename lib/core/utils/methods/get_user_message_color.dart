
import 'dart:math' show Random;

import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
Color getUserColor(String senderId) {
  final int hash = senderId.hashCode;
  final Random random = Random(hash); // Seed for consistency

  // Convert base color to HSL for manipulation
  final HSLColor baseHsl = HSLColor.fromColor(AppColors.yellowAccent2);

  // Vary the hue slightly (±20° around the base hue of ~20°)
  final double hueVariation = (hash % 40 - 20).toDouble(); // -20 to +20
  final double newHue = (baseHsl.hue + hueVariation) % 360;

  // Vary lightness slightly (±10% around 55%) for distinction
  final double lightnessVariation = (hash % 20 - 10) / 100.0; // -0.1 to +0.1
  final double newLightness = (baseHsl.lightness + lightnessVariation).clamp(
    0.45,
    0.65,
  );

  // Keep saturation close to the base (43%) but allow slight variation
  final double saturationVariation =
      (hash % 10 - 5) / 100.0; // -0.05 to +0.05
  final double newSaturation = (baseHsl.saturation + saturationVariation)
      .clamp(0.35, 0.55);

  // Create the new color
  return HSLColor.fromAHSL(
    1.0, // Full opacity
    newHue,
    newSaturation,
    newLightness,
  ).toColor();
}