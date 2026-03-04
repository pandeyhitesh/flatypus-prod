import 'package:color_log/color_log.dart';
import 'package:flatypus/features/profile/domain/entities/user.dart';

class FlatypusUserModel extends FlatypusUser {
  FlatypusUserModel({
    required super.id,
    super.name,
    super.email,
    super.phoneNumber,
    super.photoURL,
    super.dobMonthDate,
  });

  // Factory method to create a FlatypusUserModel from a Firebase User
  // factory FlatypusUserModel.fromFirebaseUser(User user) {
  //   return FlatypusUserModel(
  //     id: user.uid,
  //     name: user.displayName,
  //     email: user.email,
  //     phoneNumber: user.phoneNumber,
  //     photoURL: user.photoURL,
  //     emailVerified: user.emailVerified,
  //   );
  // }

  // Method to convert FlatypusUserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'photo_url': photoURL,
      // 'dateOfBirth': dob?.toIso8601String() ?? '',
      // 'dobMonthDate': dateToDobMDString(dobMonthDate),
    };
  }

  // Method to create FlatypusUserModel from JSON
  factory FlatypusUserModel.fromJson(Map<String, dynamic> json) {
    clog.info('FlatypusUserModel JSON = $json');
    return FlatypusUserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      photoURL: json['photo_url'],
      // dobMonthDate: dobMDStringToDate(json['dobMonthDate']),
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
}
