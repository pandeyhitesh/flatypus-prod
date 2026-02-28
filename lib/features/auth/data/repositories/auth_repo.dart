import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatypus/features/auth/data/datasources/auth_remote_ds.dart';
import 'package:flatypus/features/auth/domain/repositories/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthRemoteDataSource service;
  AuthRepositoryImpl(this.service);

  @override
  Future<UserCredential?> signInWithGoogle() async{
    try{
            // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await service.addUserIdInDb(googleAuth?.idToken ?? '');

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print('Inside AuthRepository: $e');
    }
    return null;
  }

  @override
  Future<void> logOut() async{
    await FirebaseAuth.instance.signOut();
    GoogleSignIn().signOut();
  }

  @override
  User? loggedInUser(){
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Future<Map<String, dynamic>> addUserIdInDb(String userId) async {
    return  service.addUserIdInDb(userId);
  }
}