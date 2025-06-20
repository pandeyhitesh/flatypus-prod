import 'package:flatypus/common/methods.dart';
import 'package:flatypus/common/widgets/base_layout.dart';
import 'package:flatypus/screens/splits/expense_home/widgets/create_new_split_button.dart';
import 'package:flatypus/screens/splits/expense_home/widgets/split_group_card.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flatypus/theme/borders.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExpenseSummaryScreen extends StatelessWidget {
  const ExpenseSummaryScreen({super.key});
  AppBar get _appBar =>
      AppBar(title: const Text('Expense Summary'), centerTitle: true);

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      showAppBar: true,
      appBar: _appBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            // height: 100,
            decoration: BoxDecoration(color: AppColors.primaryColor),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Split Balance',
                          style: TextStyle(
                            color: AppColors.white.withAlpha(
                              alphaFromOpacity(.9),
                            ),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: .5,
                            // height: 1.4
                          ),
                        ),
                        Text(
                          'Your net payable amount',
                          style: TextStyle(
                            color: AppColors.white.withAlpha(
                              alphaFromOpacity(.7),
                            ),
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            letterSpacing: .5,
                            // height: 1.4
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '₹1068',
                          style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            letterSpacing: .5,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Transform.rotate(
                            angle: .8,
                            child: Icon(
                              FontAwesomeIcons.circleArrowDown,
                              color: Colors.lightGreenAccent,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: kScreenPadding/2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [CreateNewSplitButton(), SplitGroupCard()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
