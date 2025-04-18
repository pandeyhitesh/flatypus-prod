import 'package:flatypus/common/methods.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final taskDateSelectionControllerProvider =
    StateProvider<DateTime?>((ref) => today);
