import 'package:cached_network_image/cached_network_image.dart';
import 'package:color_log/color_log.dart';
import 'package:flatypus/common/methods.dart';
import 'package:flatypus/models/user_model.dart';
import 'package:flatypus/state/controllers/split_paid_by_controller.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flatypus/theme/borders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PersonCard extends ConsumerWidget {
  const PersonCard({super.key, required this.user, this.disabled = false});
  final UserModel? user;
  final bool disabled;

  void _onTap(WidgetRef ref) {
    clog.debug('Person card ontap called');
    ref.read(splitPaidByControllerProvider.notifier).state = user;
    pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedUser = ref.watch(splitPaidByControllerProvider);
    final isSelected = user != null && selectedUser == user;
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: InkWell(
        onTap: disabled ? null : () => _onTap(ref),
        child: Container(
          decoration: customCardDecoration(
            borderRadius: 15,
            borderColor: isSelected ? AppColors.yellowAccent2 : null,
            borderWidth: isSelected ? 1.5 : null,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child:
                user == null
                    ? Text('-- Not Selected --')
                    : Row(
                      children: [
                        Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: AppColors.secondaryColor,
                              width: 1.5,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(1),
                            child:
                                user!.photoURL != null
                                    ? ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.network(user!.photoURL!),
                                    )
                                    : Center(
                                      child: Icon(
                                        FontAwesomeIcons.solidUser,
                                        size: 18,
                                        color: Colors.white70,
                                      ),
                                    ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          user!.displayName ?? 'User',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            letterSpacing: .5,
                          ),
                        ),
                      ],
                    ),
          ),
        ),
      ),
    );
  }
}
