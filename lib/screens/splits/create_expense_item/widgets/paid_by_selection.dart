import 'package:flatypus/common/methods.dart';
import 'package:flatypus/models/user_model.dart';
import 'package:flatypus/screens/splits/create_expense_item/widgets/person_card.dart';
import 'package:flatypus/state/controllers/split_paid_by_controller.dart';
import 'package:flatypus/state/providers/users_provider.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flatypus/theme/borders.dart';
import 'package:flatypus/theme/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaidBySelection extends ConsumerStatefulWidget {
  const PaidBySelection({super.key});

  @override
  ConsumerState<PaidBySelection> createState() => _PaidBySelectionState();
}

class _PaidBySelectionState extends ConsumerState<PaidBySelection> {
  _onPaidByTap() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Consumer(
          builder: (context, ref, _) {
            final users = ref.watch(usersProvider);
            return Padding(
              padding: const EdgeInsets.only(
                top: 12,
                left: 12,
                right: 12,
                bottom: 26,
              ),
              child: Container(
                width: kScreenWidth,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: kBorderRadius,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 10),
                        child: Text('Paid By', style: mediumHeaderTextStyle),
                      ),
                      if (users.isNotEmpty) ...[
                        for (UserModel user in users) PersonCard(user: user),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(splitPaidByControllerProvider);
    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Paid by: '),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 16),
            child: GestureDetector(
              onTap: _onPaidByTap,
              child: PersonCard(user: user, disabled: true),
            ),
          ),
        ],
      ),
    );
  }
}
