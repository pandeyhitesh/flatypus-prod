

import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String? displayName;
  final String? email;
  final String? photoURL;
  final String? phoneNumber;
  final bool? emailVerified;
  final DateTime? dob;

  UserModel({
    required this.uid,
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoURL,
    this.emailVerified,
    this.dob
  });

  UserModel copyWith({
    String? uid,
    String? displayName,
    String? email,
    String? photoURL,
    String? phoneNumber,
    bool? emailVerified,
    DateTime? dob,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photoURL: photoURL ?? this.photoURL,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      emailVerified: emailVerified ?? this.emailVerified,
      dob: dob ?? this.dob,
    );
  }

  // Factory method to create a UserModel from a Firebase User
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uid: user.uid,
      displayName: user.displayName,
      email: user.email,
      phoneNumber: user.phoneNumber,
      photoURL: user.photoURL,
      emailVerified: user.emailVerified,

    );
  }

  // Method to convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,
      'emailVerified': emailVerified,
      'dateOfBirth': dob?.toIso8601String() ?? '',
    };
  }

  // Method to create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      displayName: json['displayName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      photoURL: json['photoURL'],
      emailVerified: json['emailVerified'],
      dob: json['dateOfBirth'] != null && json['dateOfBirth'].isNotEmpty ? DateTime.parse(json['dateOfBirth']) : null,
    );
  }


}
