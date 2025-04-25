import 'package:color_log/color_log.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatypus/common/enums.dart';
import 'package:flatypus/common/methods.dart';
import 'package:flatypus/common/methods/show_navigation_bottom_sheet.dart';
import 'package:flatypus/common/widgets/custom_text_n_icon_button.dart';
import 'package:flatypus/screens/home/widgets/user_profile_image.dart';
import 'package:flatypus/screens/profile/profile/widgets/birth_date_section.dart';
import 'package:flatypus/screens/profile/profile/widgets/phone_number_section.dart';
import 'package:flatypus/state/providers/users_provider.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileSection extends ConsumerStatefulWidget {
  const ProfileSection({super.key});

  @override
  ConsumerState<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends ConsumerState<ProfileSection> {
  String? phoneNumber;
  DateTime? dobMonthDate;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _initialisePhoneNumber();
    });
  }

  void _initialisePhoneNumber() async {
    final loggedInUser = FirebaseAuth.instance.currentUser;
    if (loggedInUser == null) return;
    final usersFromProvider = ref.read(usersProvider);
    if (usersFromProvider.isEmpty) {
      final user = await ref
          .read(usersProvider.notifier)
          .getUserFromFireStore(loggedInUser.uid);
      if (user != null) {
        ref.read(usersProvider.notifier).setUsers([user]);
        setState(() {
          phoneNumber = user.phoneNumber;
          dobMonthDate = user.dobMonthDate;
        });
      }
    } else {
      final user = ref
          .read(usersProvider.notifier)
          .getUserByUid(loggedInUser.uid);
      if (user != null) {
        setState(() {
          phoneNumber = user.phoneNumber;
          dobMonthDate = user.dobMonthDate;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const SizedBox();

    ref.listen(usersProvider, (previous, next) {
      final currentUser = ref
          .read(usersProvider.notifier)
          .getUserByUid(user.uid);
      clog.info('Current User = $currentUser');
      if (currentUser == null) return;
      if (currentUser.phoneNumber != phoneNumber) {
        setState(() {
          phoneNumber = currentUser.phoneNumber;
        });
      }
      if (currentUser.dobMonthDate != dobMonthDate) {
        setState(() {
          dobMonthDate = currentUser.dobMonthDate;
        });
      }
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kScreenPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [userProfileImage(level: Level.large)],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 6),
            child: Text(
              user.displayName!,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(letterSpacing: .5),
            ),
          ),
          Text(
            user.email!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              letterSpacing: .5,
              color: AppColors.white.withAlpha(alphaFromOpacity(.7)),
            ),
          ),
          PhoneNumberSection(phoneNumber: phoneNumber),
          BirthDateSection(dobMonthDate: dobMonthDate),
        ],
      ),
    );
  }
}
