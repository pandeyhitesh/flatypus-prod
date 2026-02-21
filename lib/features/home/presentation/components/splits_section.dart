import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/theme/borders.dart';
import 'package:flatypus/core/utils/enums.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/features/common/widgets/component_header.dart';
import 'package:flatypus/features/splits/presentation/pages/expense_summary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplitsSection extends ConsumerWidget {
  const SplitsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement house provider
    // ref.watch(houseProvider);
    return SizedBox(
      width: kScreenWidth,
      child: Padding(
        padding: kHorizontalScrPadding,
        child: Container(
          margin: const EdgeInsets.only(top: 40),
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          height: 100,
          decoration: customCardDecoration(
            borderWidth: 0,
            borderColor: Colors.transparent,
          ),
          child: Column(
            children: [
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    componentHeader('Split Expenses', level: Level.small),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: TextStyle(
                          color: AppColors.yellowAccent2,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          letterSpacing: .5,
                        ),
                      ),
                      onPressed: () {
                        push(context, ExpenseSummaryScreen());
                      },
                      child: Text(
                        '+ Add Split',
                        style: TextStyle(
                          color: AppColors.yellowAccent2,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          letterSpacing: .5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Divider(
                  height: 1,
                  color: AppColors.white.withAlpha(alphaFromOpacity(.1)),
                ),
              ),
              Flexible(
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
                            'Split Summary',
                            style: TextStyle(
                              color: AppColors.white.withAlpha(
                                alphaFromOpacity(.9),
                              ),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              letterSpacing: .5,
                            ),
                          ),
                          Text(
                            'Across all splits',
                            style: TextStyle(
                              color: AppColors.white.withAlpha(
                                alphaFromOpacity(.9),
                              ),
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              letterSpacing: .5,
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
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: AppColors.white.withAlpha(
                                alphaFromOpacity(.3),
                              ),
                              size: 16,
                            ),
                            visualDensity: VisualDensity.compact,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // child: Column(
        //   mainAxisSize: MainAxisSize.min,
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     const SizedBox(height: 24),
        //     HomeScreenSectionHeader(
        //       destinationScreen: AllSpacesScreen(),
        //       title: 'Splits',
        //       buttonText: 'Add Split',
        //     ),
        //     const SizedBox(height: 16),
        //     SizedBox(height: 90),
        //   ],
        // ),
      ),
    );
  }
}
