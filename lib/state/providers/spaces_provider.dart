import 'package:flatypus/models/space_model.dart';
import 'package:flatypus/state/notifires/spaces_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final spacesProvider = StateNotifierProvider<SpacesNotifier, List<SpaceModel>>(
    (ref) => SpacesNotifier(ref));
