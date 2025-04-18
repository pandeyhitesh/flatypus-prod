import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatypus/common/snackbar.dart';
import 'package:flatypus/models/user_model.dart';
import 'package:flatypus/services/firestore/collentions.dart';

class UserServices {
  final _fbInstance = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final collection = FSCollections.users;

  Future<void> createNewUser() async {
    final user = _fbInstance.currentUser;
    if (user == null) return;
    final userFromDb =
        await _db
            .collection(collection)
            .where("uid", isEqualTo: user.uid)
            .get();
    print('User Snapshot = ${userFromDb.docs}');
    if (userFromDb.docs.isNotEmpty) return;
    final newUser = UserModel.fromFirebaseUser(user);
    await _db.collection(collection).doc().set(newUser.toJson());
    print("new user added to DB, $newUser");
  }

  Future<UserModel?> getUserByUid(String uid) async {
    final responseSS =
        await _db.collection(collection).where("uid", isEqualTo: uid).get();
    if (responseSS.docs.isNotEmpty) {
      return UserModel.fromJson(responseSS.docs.first.data());
    }
    return null;
  }

  Future<bool> updateUserInformation({
    required Map<String, dynamic> userInfo,
    required String? userId,
  }) async {
    try {
      final document = _db.collection(collection).doc(userId);
      await document.update(userInfo);
      return true;
    } catch (e) {
      showErrorSnackbar(label: e.toString());
    }
    return false;
  }
}
