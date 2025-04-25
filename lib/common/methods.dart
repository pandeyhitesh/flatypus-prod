import 'package:flatypus/models/space_model.dart';
import 'package:flatypus/services/global_context.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const Color kBackgroundColor = AppColors.backgroundColor;
Color kTransparent = Colors.transparent;
BorderRadius kBorderRadius = BorderRadius.circular(15);
Radius kRadius = Radius.circular(15);

BuildContext get kGlobalContext => GlobalContext.navigationKey.currentContext!;
double get kScreenHeight =>
    MediaQuery.of(GlobalContext.navigationKey.currentContext!).size.height;
double get kScreenWidth =>
    MediaQuery.of(GlobalContext.navigationKey.currentContext!).size.width;

const double kScreenPadding = 26;
EdgeInsets get kHorizontalScrPadding =>
    const EdgeInsets.symmetric(horizontal: kScreenPadding);

// page routing

void push(BuildContext context, Widget targetScreen) => Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => targetScreen),
);

void replace(BuildContext context, Widget targetScreen) =>
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => targetScreen),
    );

void pop({dynamic parameter}) {
  final context = GlobalContext.navigationKey.currentContext;
  (context != null && context.mounted)
      ? Navigator.of(context).pop(parameter)
      : null;
}

void pushAndRemoveAll(Widget targetScreen) =>
    Navigator.of(kGlobalContext).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => targetScreen),
      (route) => false,
    );

// Datetime
DateTime get today => getDate(DateTime.now());

DateTime get lastAllowedFutureDate => today.add(const Duration(days: 60));

DateTime getDate(DateTime date) =>
    DateTime(date.year, date.month, date.day, 0, 0, 0);

DateFormat fullDateFormat = DateFormat('dd-MMM-yyyy');
DateFormat messageDateFormat = DateFormat('dd MMMM yyyy');
DateFormat taskCardDateFormat = DateFormat('EEE, dd MMM');
DateFormat monthFormat = DateFormat('MMMM yyyy');
DateFormat chatTimeStampFormat = DateFormat('hh:mm a');
DateFormat dobMonthDateFormat = DateFormat('MMMM dd');

extension StringExtension on String {
  String capitalize() => '${this[0].toUpperCase()}${substring(1)}';
  String capitalizeAll() {
    final split = this.split(' ');
    final capitalized = split.map((word) => word.capitalize()).toList();
    return capitalized.join(' ');
  }
}

String taskSpace(List<SpaceModel> spaces, String? spaceId) {
  if (spaces.isNotEmpty && spaceId != null) {
    return spaces.firstWhere((sp) => sp.id == spaceId).name;
  }
  return 'N/A';
}

int alphaFromOpacity(double opacity) => (255 * opacity).floor();
