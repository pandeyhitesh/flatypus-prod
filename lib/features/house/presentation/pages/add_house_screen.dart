import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/theme/borders.dart';
import 'package:flatypus/core/theme/textstyles.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/core/utils/methods/loading_methods.dart';
import 'package:flatypus/core/utils/snackbar.dart';
import 'package:flatypus/features/common/widgets/alernative_screen_button.dart';
import 'package:flatypus/features/common/widgets/base_layout.dart';
import 'package:flatypus/features/common/widgets/input_field_header.dart';
import 'package:flatypus/features/house/domain/entities/house.dart';
import 'package:flatypus/features/house/presentation/controller/house_controller.dart';
import 'package:flatypus/features/house/presentation/pages/search_house.dart';
import 'package:flatypus/features/house/presentation/providers/house_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddHouseScreen extends ConsumerStatefulWidget {
  const AddHouseScreen({super.key, this.house});
  final House? house;
  static const screenTitle = 'Add a house';
  static const updateScreenTitle = 'Update house';

  @override
  ConsumerState<AddHouseScreen> createState() => _AddHouseScreenState();
}

class _AddHouseScreenState extends ConsumerState<AddHouseScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _addressController = TextEditingController();

  bool _isUpdate = false;

  @override
  void initState() {
    if (widget.house != null) {
      _isUpdate = true;
      _nameController.text = widget.house?.displayName ?? '';
      _addressController.text = widget.house?.address ?? '';
    }
    super.initState();
  }

  get _appBar => AppBar(
    backgroundColor: kBackgroundColor,
    title: Text(
      _isUpdate
          ? AddHouseScreen.updateScreenTitle
          : AddHouseScreen.screenTitle,
      style: const TextStyle(color: AppColors.white),
    ),
    centerTitle: true,
  );

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(houseProvider).isLoading;
    final controller = ref.read(houseControllerProvider);
    return BaseLayout(
      backgroundColor: kBackgroundColor,
      resizeToAvoidBottomInset: false,
      showAppBar: true,
      appBar: _appBar,
      body: Padding(
        padding: kHorizontalScrPadding,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              inputFieldHeader('House Name'),
              houseNameInput(),
              const SizedBox(height: 24),
              inputFieldHeader('Address'),

              houseAddressInput(),
              // const SizedBox(
              //   height: 30,
              // ),
              const Expanded(child: SizedBox()),
              addNewHouseButton(context, ref, controller),
              if (!_isUpdate) searchHouseOptionButton(context),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget houseNameInput() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Enter House name',
        hintStyle: hintTextStyle,
        border: border,
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
      ),
      cursorColor: AppColors.yellowAccent2,
      controller: _nameController,
      style: inputTextStyle,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'House name is required';
        }
        return null;
      },
    );
  }

  Widget houseAddressInput() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Enter address of the house',
        hintStyle: hintTextStyle,
        border: border,
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
      ),
      cursorColor: AppColors.yellowAccent2,
      controller: _addressController,
      style: inputTextStyle,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'House address is required';
        }
        return null;
      },
    );
  }

  Widget addNewHouseButton(
    BuildContext context,
    WidgetRef ref,
    HouseController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryColor,
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onPressed:
            _isUpdate
                ? () => _saveUpdatedDetails(ref: ref)
                : () => _onAddNewHouseButtonTap(context, ref, controller),
        child: Text(
          _isUpdate ? 'Save' : 'Add New House',
          style: const TextStyle(
            color: AppColors.backgroundColor,
            fontSize: 16,
            letterSpacing: .5,
          ),
        ),
      ),
    );
  }

  Widget searchHouseOptionButton(BuildContext context) =>
      alternativeScreenButton(
        context: context,
        label: 'Do you have a house key? Search house',
        onTap: () => replace(context, SearchHouseScreen()),
      );

  void _onAddNewHouseButtonTap(
    BuildContext context,
    WidgetRef ref,
    HouseController controller,
  ) {
    final isFormValid = _formKey.currentState?.validate();
    if (isFormValid == null || !isFormValid) return;
    controller.createHouse(
      houseName: _nameController.text,
      address: _addressController.text,
      onSuccess: () {
        showSuccessSnackbar(label: 'House created successfully!');
        ref.invalidate(houseProvider);
        pop();
      },
      onError: (error) {
        showErrorSnackbar(label: error);
      },
    );

    // HouseMethods.addNewHouseToDB(
    //   context: context,
    //   ref: ref,
    //   houseName: _nameController.text,
    //   houseAddress: _addressController.text,
    // );
  }

  void _saveUpdatedDetails({required WidgetRef ref}) async {
    //   Loader.startLoading(context, ref);
    //   final updateResult = await ref
    //       .read(houseProvider.notifier)
    //       .updateDetails(
    //         displayName: _nameController.text,
    //         address: _addressController.text,
    //       );
    //   if (updateResult) {
    //     showSuccessSnackbar(label: 'House details updated successfully!');
    //   } else {
    //     showErrorSnackbar(label: 'Failed to update house details!');
    //   }
    //   Loader.stopLoading(context, ref);
    //   ref.invalidate(houseProvider);
    //   if (kGlobalContext.mounted) pop();
    // }
  }
}
