import 'package:flatypus/models/house_model.dart';
import 'package:flatypus/state/notifires/house_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final houseProvider =
    StateNotifierProvider<HouseNotifier, HouseModel?>((ref) => HouseNotifier(ref));
