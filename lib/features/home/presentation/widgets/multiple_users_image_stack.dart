import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatypus/core/utils/enums.dart';
import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/features/home/presentation/widgets/user_profile_image.dart';
import 'package:flatypus/features/house/domain/entities/member.dart';
import 'package:flatypus/features/profile/presentation/providers/members_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MultipleUsersImageStack extends ConsumerWidget {
  MultipleUsersImageStack({super.key});

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement providers
    final List<Member> members = ref.watch(membersProvider);
    // final users = <FlatypusUserModel>[];
    // houseAsync.when(
    //   loading: () => const SizedBox(),
    //   error: (_, __) => const SizedBox(),
    //   data: (house) {
    //     final members = house?.members;
    //     if (members == null || members.isEmpty) return const SizedBox();
    //     return  
    //   }
    // );
    return SizedBox(child: _showUserStack(members, context));
    // return SizedBox(
    //   child: FutureBuilder(
    //     future: HouseService().getUsersInRoom(ref: ref),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData && snapshot.data != null) {
    //         return _showUserStack(snapshot.data!, context);
    //       } else {
    //         return const SizedBox();
    //       }
    //     },
    //   ),
    // );
  }

  Widget _showUserStack(List<Member> userList, BuildContext context) {
    final count = userList.length > 4 ? userList.length - 4 : null;
    final userCount = userList.length < 5 ? userList.length : 4;
    return Stack(
      children: List.generate(
        userCount,
        (index) => _individualImage(index, userList[index], count: count),
      ),
    );
  }

  Widget _individualImage(int index, Member? member, {int? count}) {
    if (member == null) return const SizedBox();
    return Positioned(
      left: index * 23,
      child: Stack(
        children: [
          userProfileImage(photoURL: member.photoURL, level: Level.small),
          if (index == 3 && count != null)
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColors.primaryColor.withOpacity(.7),
              ),
              margin: const EdgeInsets.all(3),
              child: Center(
                child: Text(
                  '+$count',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  softWrap: false,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
