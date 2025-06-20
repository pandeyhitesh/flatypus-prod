import 'package:flatypus/common/methods.dart';
import 'package:flatypus/common/methods/validations/house_key_validation.dart';
import 'package:flatypus/common/widgets/text_input_field_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DescriptionInput extends StatelessWidget {
  const DescriptionInput({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  static const _hintText = 'This Expense was for ...';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kScreenPadding),
      child: CustomTextInputField(
        hintText: _hintText,
        controller: controller,
        focusNode: focusNode,
        borderType: OutlineInputBorder,
        textAlign: TextAlign.center,
        fontSize: 16,
        inputFormatters: [LengthLimitingTextInputFormatter(50)],
        validationFunction: (value) {
          if (!isValidInput(value)) return 'Add a description to continue';
          return null;
        },
        onFieldSubmitted: (){
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }
}
