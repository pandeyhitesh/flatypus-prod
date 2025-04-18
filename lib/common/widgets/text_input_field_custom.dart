import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/borders.dart';
import '../../theme/textstyles.dart';

class CustomTextInputField extends StatelessWidget {
  const CustomTextInputField({
    super.key,
    required this.hintText,
    required this.controller,
    this.focusNode,
    this.validationFunction,
    this.maxLength,
    this.inputFormatters,
    this.keyBoardType,
    this.suffixIcon,
    this.suffixOnTap,
    this.borderType = OutlineInputBorder,
    this.horzPadding = false,
    this.onFieldSubmitted,
    this.onTap,
    this.onChanged,
  });
  final String hintText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validationFunction;
  final Type borderType;
  final bool horzPadding;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyBoardType;
  final IconData? suffixIcon;
  final Function? suffixOnTap;
  final Function? onFieldSubmitted;
  final Function? onTap;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horzPadding ? 6.0 : 0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintTextStyle,
          border: borderType == OutlineInputBorder ? border : ulBorder,
          enabledBorder:
              borderType == OutlineInputBorder
                  ? enabledBorder
                  : ulEnabledBorder,
          focusedBorder:
              borderType == OutlineInputBorder
                  ? focusedBorder
                  : ulFocusedBorder,
          errorBorder:
              borderType == OutlineInputBorder ? errorBorder : ulErrorBorder,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 12,
          ),
          // isDense: true,
          suffixIcon:
              suffixIcon == null
                  ? null
                  : IconButton(
                    icon: Icon(suffixIcon, size: 18),
                    onPressed: () => suffixOnTap?.call(),
                  ),
        ),
        controller: controller,
        focusNode: focusNode,
        style: inputTextStyle,
        validator: validationFunction,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        keyboardType: keyBoardType,
        onFieldSubmitted: (_) => onFieldSubmitted?.call(),
        onTap: () => onTap?.call(),
        onChanged: onChanged,
      ),
    );
  }
}
