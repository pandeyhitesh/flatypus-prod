import 'package:flatypus/core/utils/methods.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final taskDateSelectionControllerProvider = StateProvider<DateTime?>(
  (ref) => today,
);
