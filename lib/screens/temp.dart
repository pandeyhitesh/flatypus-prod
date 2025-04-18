
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home Screen'),
            SizedBox(
              height: 70,
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    user?.photoURL ?? '',
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Text('Hello ${user?.displayName}'),
            ElevatedButton(
              onPressed: _onLogoutButtonPressed,
              child: Text('Logout'),
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('books')
                    .doc()
                    .set({'title': 'title', 'author': 'author', 'userId': user?.uid});
              },
              child: Text('Add a book'),
            ),
          ],
        ),
      ),
    );
  }

  void _onLogoutButtonPressed() {
    FirebaseAuth.instance.signOut();
  }
}
