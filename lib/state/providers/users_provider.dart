import 'package:flatypus/models/user_model.dart';
import 'package:flatypus/state/notifires/users_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final usersProvider = StateNotifierProvider<UsersNotifier, List<UserModel>>(
  (ref) => UsersNotifier(ref),
);
