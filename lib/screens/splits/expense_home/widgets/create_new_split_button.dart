import 'package:flatypus/common/methods.dart';
import 'package:flatypus/common/widgets/custom_outline_button.dart';
import 'package:flatypus/screens/splits/create_expense_item/enter_amount_screen.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CreateNewSplitButton extends StatelessWidget {
  const CreateNewSplitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SizedBox(
        width: kScreenWidth,
        height: 40,
        child: CustomOutlineButton(
          label: 'Create new split topic',
          foregroundColor: AppColors.yellowAccent2,
          // function: () {},
          navigateTo: EnterAmountScreen(),
        ),
        // child: ElevatedButton(
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: Colors.transparent,
        //       surfaceTintColor: Colors.transparent,
        //       elevation: 0
        //     ),
        //     onPressed: (){}, child: Text('+ Create new split topic')),
      ),
    );
  }
}
