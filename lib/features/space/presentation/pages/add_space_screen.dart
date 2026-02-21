import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/features/common/widgets/component_header.dart';
import 'package:flatypus/features/common/widgets/text_input_field_custom.dart';
import 'package:flatypus/features/space/presentation/methods/space_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddSpaceScreen extends ConsumerWidget {
  AddSpaceScreen({super.key});
  final screenTitle = 'Add new Space';
  final _spaceNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  get _appBar => AppBar(
    title: Text(screenTitle),
    centerTitle: true,
    backgroundColor: kBackgroundColor,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: get houseKey from provider
    // final houseKey = ref.read(houseProvider)?.houseKey;
    String? houseKey;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: _appBar,
      body: SafeArea(
        child: Padding(
          padding: kHorizontalScrPadding,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    // space name input
                    componentHeader('Space Name'),
                    const SizedBox(height: 8),
                    _spaceNameInput(),
                    //home key display
                    const SizedBox(height: 24),
                    ..._displayHouseKey(houseKey),
                  ],
                ),
                _addSpaceButton(ref, houseKey != null),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _spaceNameInput() {
    return CustomTextInputField(
      hintText: 'Enter a name for the Space',
      controller: _spaceNameController,
      borderType: UnderlineInputBorder,
    );
  }

  _displayHouseKey(String? houseKey) {
    return [
      componentHeader('House Key'),
      const SizedBox(height: 8),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.key, color: AppColors.white.withOpacity(.5), size: 18),
            const SizedBox(width: 8),
            Text(
              houseKey ?? 'N/A',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.white.withOpacity(.5),
                letterSpacing: 1,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    ];
  }

  Widget _addSpaceButton(WidgetRef ref, bool isEnabled) {
    return SizedBox(
      width: kScreenWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: ElevatedButton(
          onPressed:
              !isEnabled
                  ? null
                  : () => SpaceMethods.onAddNewSpaceButtonTap(
                    ref: ref,
                    spaceName: _spaceNameController.text,
                  ),
          child: const Text('Add Space'),
        ),
      ),
    );
  }
}
