import 'package:color_log/color_log.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String? displayName;
  final String? email;
  final String? photoURL;
  final String? phoneNumber;
  final bool? emailVerified;
  final DateTime? dobMonthDate;

  UserModel({
    required this.uid,
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoURL,
    this.emailVerified,
    this.dobMonthDate,
  });

  UserModel copyWith({
    String? uid,
    String? displayName,
    String? email,
    String? photoURL,
    String? phoneNumber,
    bool? emailVerified,
    DateTime? dobMonthDate,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photoURL: photoURL ?? this.photoURL,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      emailVerified: emailVerified ?? this.emailVerified,
      dobMonthDate: dobMonthDate ?? this.dobMonthDate,
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
      // 'dateOfBirth': dob?.toIso8601String() ?? '',
      'dobMonthDate': dateToDobMDString(dobMonthDate),
    };
  }

  // Method to create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    clog.info('UserModel JSON = $json');
    return UserModel(
      uid: json['uid'],
      displayName: json['displayName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      photoURL: json['photoURL'],
      emailVerified: json['emailVerified'],
      dobMonthDate: dobMDStringToDate(json['dobMonthDate']),
    );
  }

  static DateTime? dobMDStringToDate(dynamic dobMD) {
    if (dobMD == null || dobMD.isEmpty) return null;
    final parts = dobMD.split('-');
    if (parts.length == 2) {
      final month = int.tryParse(parts[0]);
      final day = int.tryParse(parts[1]);
      if (month != null && day != null) {
        return DateTime(DateTime.now().year, month, day);
      }
    }
    return null;
  }

  static String? dateToDobMDString(DateTime? date) {
    return date == null
        ? ''
        : '${(date.month).toString().padLeft(2, '0')}-${(date.day).toString().padLeft(2, '0')}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          displayName == other.displayName &&
          email == other.email &&
          photoURL == other.photoURL &&
          phoneNumber == other.phoneNumber &&
          emailVerified == other.emailVerified &&
          dobMonthDate == other.dobMonthDate;

  @override
  int get hashCode =>
      uid.hashCode ^
      displayName.hashCode ^
      email.hashCode ^
      photoURL.hashCode ^
      phoneNumber.hashCode ^
      emailVerified.hashCode ^
      dobMonthDate.hashCode;
}
