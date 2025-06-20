import 'package:color_log/color_log.dart';
import 'package:flatypus/common/methods.dart';
import 'package:flatypus/common/methods/validations/house_key_validation.dart';
import 'package:flatypus/common/widgets/text_input_field_custom.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flatypus/theme/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart'
    show CurrencyInputFormatter;

class AmountInput extends StatefulWidget {
  const AmountInput({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.nextFocusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;

  static const _title = 'Enter Amount';
  static const _hintText = '00';

  @override
  State<AmountInput> createState() => _AmountInputState();
}

class _AmountInputState extends State<AmountInput> {
  double _amountFieldWidth = 70;
  final double _amountFieldInitialWidth = 70;
  final double _amountDigitWidth = 10;

  _onAmountChanged(String value) {
    if (value.isEmpty) {
      setState(() {
        _amountFieldWidth = _amountFieldInitialWidth;
      });
    } else {
      setState(() {
        clog.debug('Length: ${value.length}');
        clog.debug(
          'Width: ${_amountFieldInitialWidth + (value.length * _amountDigitWidth)}',
        );
        _amountFieldWidth =
            _amountFieldInitialWidth + (value.length * _amountDigitWidth);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(AmountInput._title, style: mediumHeaderTextStyle),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: kScreenPadding,
            horizontal: 50,
          ),
          child: SizedBox(
            width: _amountFieldWidth,
            child: CustomTextInputField(
              autofocus: true,
              hintText: AmountInput._hintText,
              controller: widget.controller,
              focusNode: widget.focusNode,
              borderType: UnderlineInputBorder,
              textAlign: TextAlign.center,
              fontSize: 26,
              prefixText: '₹ ',
              inputFormatters: [
                CurrencyInputFormatter(
                  leadingSymbol: '',
                  mantissaLength: 0,
                  maxTextLength: 5,
                ),
                LengthLimitingTextInputFormatter(10),
              ],
              onChanged: _onAmountChanged,
              validationFunction: (value) {
                if (!isValidInput(value)) return ' ';
                final amount = double.tryParse(value!);
                if (amount == null || amount <= 0) {
                  return ' ';
                }
                return null;
              },
              onFieldSubmitted: () {
                FocusScope.of(context).requestFocus(widget.nextFocusNode);
              },
            ),
          ),
        ),
      ],
    );
  }
}
