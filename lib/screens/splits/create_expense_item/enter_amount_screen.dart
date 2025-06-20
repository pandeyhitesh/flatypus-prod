import 'package:flatypus/common/methods.dart';
import 'package:flatypus/common/widgets/base_layout.dart';
import 'package:flatypus/common/widgets/custom_solid_button.dart';
import 'package:flatypus/common/widgets/text_input_field_custom.dart';
import 'package:flatypus/screens/splits/create_expense_item/widgets/amount_input.dart';
import 'package:flatypus/screens/splits/create_expense_item/widgets/description_input.dart';
import 'package:flatypus/screens/splits/create_expense_item/widgets/paid_by_selection.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:intl/intl.dart';

class EnterAmountScreen extends StatefulWidget {
  const EnterAmountScreen({super.key});

  @override
  State<EnterAmountScreen> createState() => _EnterAmountScreenState();
}

class _EnterAmountScreenState extends State<EnterAmountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _amountFocus = FocusNode();
  final _descController = TextEditingController();
  final _descFocus = FocusNode();

  _onContinueTap() {
    if (_formKey.currentState!.validate()) {
      return;
    }
  }

  @override
  void initState() {
    _amountController.text = '0';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      showAppBar: true,
      appBar: AppBar(title: const Text('Add Expense')),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kScreenPadding,
                vertical: 100,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AmountInput(
                    controller: _amountController,
                    focusNode: _amountFocus,
                    nextFocusNode: _descFocus,
                  ),
                  DescriptionInput(
                    controller: _descController,
                    focusNode: _descFocus,
                  ),
                  PaidBySelection(),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: kScreenPadding,
                horizontal: kScreenPadding,
              ),
              child: SizedBox(
                width: kScreenWidth - 2 * kScreenPadding,
                height: 45,
                child: CustomSolidButton(
                  label: 'Continue',
                  backgroundColor: AppColors.yellowAccent2,
                  onTap: _onContinueTap,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
