import 'package:flutter/material.dart';

import 'package:flatypus/common/enums.dart';
import 'package:flatypus/common/methods.dart';
import 'package:flatypus/screens/splits/expense_topic/expense_topic_screen.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flatypus/theme/borders.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExpenseItemCard extends StatelessWidget {
  const ExpenseItemCard({
    super.key,
    // required this.title,
    // this.subtitle,
    // required this.amount,
    // required this.transactionType,
    // required this.leadingIcon,
    // required this.leadingDate,
  });

  // final String title;
  // final String? subtitle;
  // final double amount;
  // final ExpenseTransactionType transactionType;
  // final IconData leadingIcon;
  // final DateTime leadingDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: InkWell(
        onTap: () {
          push(context, ExpenseTopicScreen());
        },
        child: Container(
          height: 60,
          decoration: customCardDecoration(
            bgColor: AppColors.clickableCardColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          color: AppColors.primaryColor,
                          child: Icon(FontAwesomeIcons.peopleGroup),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Demo Split Name',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'You get back',
                      style: TextStyle(
                        color: Colors.lightGreenAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '₹234',
                      style: TextStyle(
                        color: Colors.lightGreenAccent,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
