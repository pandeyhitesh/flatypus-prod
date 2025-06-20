import 'package:flatypus/common/methods.dart';
import 'package:flatypus/common/snackbar.dart';
import 'package:flatypus/common/widgets/component_header.dart';
import 'package:flatypus/common/widgets/custom_solid_button.dart';
import 'package:flatypus/common/widgets/text_input_field_custom.dart';
import 'package:flatypus/state/controllers/loading_controller.dart';
import 'package:flatypus/state/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdatePhoneNumber extends StatefulWidget {
  const UpdatePhoneNumber({super.key, this.phoneNumber, this.userId});
  final String? phoneNumber;
  final String? userId;

  @override
  State<UpdatePhoneNumber> createState() => _UpdatePhoneNumberState();
}

class _UpdatePhoneNumberState extends State<UpdatePhoneNumber> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _phoneNumberController.text = widget.phoneNumber ?? '';
  }

  String? _phoneNumberValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter valid Phone Number';
    }
    final phoneNumber = value.replaceAll(' ', '');
    if (phoneNumber.length != 10) {
      return 'Enter valid Phone Number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        componentHeader('Phone Number'),
        const SizedBox(height: 28),
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: CustomTextInputField(
              hintText: 'XXX XXX XXXX',
              controller: _phoneNumberController,
              validationFunction: _phoneNumberValidation,
              // maxLength: 10,
              keyBoardType: TextInputType.number,
              inputFormatters: [
                PhoneInputFormatter(
                  defaultCountryCode: 'IN',
                  allowEndlessPhone: false,
                  shouldCorrectNumber: false,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: kScreenWidth,
          child: Consumer(
            builder:
                (context, ref, _) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: CustomSolidButton(
                    label: 'Save',
                    onTap: () async {
                      try {
                        ref
                            .read(loadingControllerProvider.notifier)
                            .startLoading();
                        if (!(_formKey.currentState?.validate() ?? false))
                          return;
                        final result = await ref
                            .read(usersProvider.notifier)
                            .updatePhoneNumber(
                              userId: widget.userId,
                              phoneNumber: _phoneNumberController.text,
                            );
                        if (result) {
                          showSuccessSnackbar(
                            label: 'Phone number updated successfully!',
                          );
                        }
                        pop();
                      } catch (e) {
                        showErrorSnackbar(label: e.toString());
                      } finally {
                        ref
                            .read(loadingControllerProvider.notifier)
                            .stopLoading();
                      }
                    },
                    vPadding: 8,
                  ),
                ),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
