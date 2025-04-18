import 'package:color_log/color_log.dart';
import 'package:flatypus/models/user_model.dart';
import 'package:flatypus/services/firestore/user_services.dart';
import 'package:flatypus/state/providers/house_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsersNotifier extends StateNotifier<List<UserModel>> {
  UsersNotifier(this.ref) : super([]) {
    getUsersFromFireStore();
  }

  StateNotifierProviderRef ref;

  Future<void> getUsersFromFireStore() async {
    final users = ref.watch(houseProvider)?.users;
    if (users == null || users.isEmpty) return;
    List<UserModel> usersFromFS = [];
    for (String uid in users.toSet()) {
      final usr = await UserServices().getUserByUid(uid);
      if (usr == null) continue;
      usersFromFS.add(usr);
    }
    state = usersFromFS;
  }

  void setUsers(List<UserModel> users) => state = users;

  UserModel? getUserByUid(String? uid) {
    if (uid == null) return null;
    int index = state.indexWhere((usr) => usr.uid == uid);
    if (index < 0) return null;
    return state.elementAt(index);
  }

  Future<UserModel?> getUserFromFireStore(String uid) async {
    final usr = await UserServices().getUserByUid(uid);
    clog.info('User DOB = ${usr?.dob}');
    return usr;
  }

  Future<bool> updatePhoneNumber({
    required String? userId,
    required String? phoneNumber,
  }) async {
    final userInfo = {"phoneNumber": phoneNumber};
    final result = await UserServices().updateUserInformation(
      userInfo: userInfo,
      userId: userId,
    );
    if (!result) return false;
    List<UserModel> tempList = [...state];
    final index = tempList.indexWhere((u) => u.uid == userId);
    if (index != -1) {
      final user = tempList[index];
      final updatedUser = user.copyWith(phoneNumber: phoneNumber);
      tempList.removeAt(index);
      tempList.insert(index, updatedUser);
    }
    state = tempList;
    return true;
  }

  Future<bool> updateDateOfBirth({
    required String? userId,
    required DateTime? dateOfBirth,
  }) async {
    // final result = await UserServices()
    //     .updateUserPhoneNumber(phoneNumber: phoneNumber, userId: userId);
    final userInfo = {"dateOfBirth": dateOfBirth?.toIso8601String()};
    final result = await UserServices().updateUserInformation(
      userInfo: userInfo,
      userId: userId,
    );
    if (!result) return false;
    List<UserModel> tempList = [...state];
    final index = tempList.indexWhere((u) => u.uid == userId);
    if (index != -1) {
      final user = tempList[index];
      final updatedUser = user.copyWith(dob: dateOfBirth);
      tempList.removeAt(index);
      tempList.insert(index, updatedUser);
    }
    state = tempList;
    return true;
  }
}
