import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/utils/enums.dart';
import 'package:flutter/material.dart';

Widget userProfileImage(
    {String? photoURL, Level level = Level.medium, Function? onTap}) {
  if (photoURL == null) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const SizedBox();
    }
    photoURL = user.photoURL ?? '';
  }

  final double size = level == Level.large ? 100 : level == Level.medium ? 40 : 35;
  final double pdSize = level == Level.small ? 1 : 3;
  return InkWell(
    onTap: onTap == null ? null : () => onTap(),
    borderRadius: BorderRadius.circular(100),
    child: Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: AppColors.yellowAccent,
          width: 1.5,
        ),
      ),
      padding: EdgeInsets.all(pdSize),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.network(
          photoURL ?? '',
          height: 0,
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}
