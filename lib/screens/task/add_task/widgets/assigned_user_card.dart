import 'package:flatypus/models/user_model.dart';
import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';

class AssignedUserCard extends StatelessWidget {
  const AssignedUserCard(
      {super.key,
      this.user,
      this.height,
      this.fontSize,
      this.initialsOnly = false});

  final UserModel? user;
  final double? height;
  final double? fontSize;
  final bool initialsOnly;

  String getInitials(String? string) {
    if (string == null) return '';
    final sList = string.split(' ');
    print(sList);
    String initials = '';
    for (String s in sList) {
      initials += s[0].toUpperCase();
    }
    return initials;
  }

  @override
  Widget build(BuildContext context) {
    final userName = user?.displayName ?? user?.email ?? 'User';
    final displayText = initialsOnly ? getInitials(userName) : userName;
    return Container(
      height: height ?? 30,
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                user?.photoURL ?? '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.error_outline,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0, right: initialsOnly ? 8 : 16),
              child: Text(
                displayText,
                style: TextStyle(
                    fontSize: fontSize ?? 13,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryColor,
                    letterSpacing: .5,
                    height: 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
