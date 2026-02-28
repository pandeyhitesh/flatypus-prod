import 'package:firebase_auth/firebase_auth.dart';



abstract class AuthRepository {
  Future<UserCredential?> signInWithGoogle();
  Future<void> logOut();
  User? loggedInUser();
  // Future<Map<String, dynamic>> addUserIdInDb(String userId);
}