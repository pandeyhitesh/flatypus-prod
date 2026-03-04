import 'package:color_log/color_log.dart';
import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/theme/borders.dart';
import 'package:flatypus/core/theme/textstyles.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/core/utils/snackbar.dart';
import 'package:flatypus/features/common/controllers/loading_controller.dart';
import 'package:flatypus/features/common/widgets/alernative_screen_button.dart';
import 'package:flatypus/features/common/widgets/base_layout.dart';
import 'package:flatypus/features/common/widgets/component_header.dart';
import 'package:flatypus/features/house/presentation/controller/house_controller.dart';
import 'package:flatypus/features/house/presentation/methods/house_methods.dart';
import 'package:flatypus/features/house/presentation/pages/add_house_screen.dart';
import 'package:flatypus/features/house/presentation/providers/house_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchHouseScreen extends ConsumerWidget {
  SearchHouseScreen({super.key});
  static const appTitle = 'Add a house';

  final _houseNameController = TextEditingController();

  get _appBar => AppBar(
    backgroundColor: kBackgroundColor,
    title: const Text(appTitle, style: TextStyle(color: AppColors.white)),
    centerTitle: true,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loadingControllerProvider);
    final controller = ref.read(houseControllerProvider);
    clog.info('SearchHouseScreen = $isLoading}');
    return BaseLayout(
      showAppBar: true,
      appBar: _appBar,
      body: Padding(
        padding: kHorizontalScrPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            componentHeader('Enter House Key'),
            const SizedBox(height: 16),
            inputTab(context, ref),
            searchHouseButton(context, ref, controller),
            addHouseOptionButton(context),
            SizedBox(height: kScreenHeight / 5),
          ],
        ),
      ),
    );
  }

  Widget inputTab(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 50,
      width: kScreenWidth,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: houseNameTextInput()),
          const SizedBox(width: 12),
          SizedBox(
            height: 50,
            width: 50,
            child: IconButton(
              tooltip: 'Scan QR code to join the house',
              onPressed: () => HouseMethods.scanQRCodeForHouseKey(context, ref),
              icon: FaIcon(FontAwesomeIcons.qrcode, color: AppColors.white),
              style: IconButton.styleFrom(
                // side: BorderSide(
                //   color: AppColors.white.withAlpha(alphaFromOpacity(.5)),
                //   width: 1.5,
                // ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: AppColors.white.withAlpha(alphaFromOpacity(.5)),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget houseNameTextInput() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'e.g.  xxx-xxx-xxxx',
        hintStyle: hintTextStyle,
        border: border,
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
      ),
      controller: _houseNameController,
      style: inputTextStyle,
    );
  }

  Widget searchHouseButton(
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
        onPressed: () => _searchHouseByHouseKey(context, ref, controller),
        child: const Text(
          'Search & Add House',
          style: TextStyle(
            color: AppColors.backgroundColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget addHouseOptionButton(BuildContext context) => alternativeScreenButton(
    context: context,
    label: 'House not created yet? Create a house',
    onTap: () => replace(context, AddHouseScreen()),
  );

  _searchHouseByHouseKey(
    BuildContext context,
    WidgetRef ref,
    HouseController controller,
  ) {
    // HouseMethods.searchHouseByHouseKey(
    //   context: context,
    //   houseKey: _houseNameController.text,
    //   ref: ref,
    // );
    controller.joinHouse(
      houseKey: _houseNameController.text.trim(),
      onSuccess: () {
        showSuccessSnackbar(label: 'House joined successfully!');
        ref.invalidate(houseProvider);
        pop();
      },
      onError: (error) {
        showErrorSnackbar(label: error);
      },
    );
  }
}
