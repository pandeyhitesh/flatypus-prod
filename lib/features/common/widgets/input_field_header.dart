import 'package:flutter/material.dart';
import 'package:flatypus/core/utils/enums.dart';
import 'component_header.dart';

Widget inputFieldHeader(String label) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
  child: componentHeader(label, level: Level.medium),
);
