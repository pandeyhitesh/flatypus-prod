import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

Widget displayHouseNameText({
  required String? label,
  String nullText = 'House Name N/A',
  double? fontSize,
  FontWeight fontWeight = FontWeight.w500,
  Color color = AppColors.backgroundColor,
  int maxLines = 1,
}) =>
    customDisplayText(
      label: label,
      nullText: nullText,
      fontSize: fontSize ?? 22,
      fontWeight: fontWeight,
      color: color,
      maxLines: maxLines,
    );

Widget displayAddressText({
  required String? label,
  String nullText = 'Address not available',
  double? fontSize,
  FontWeight fontWeight = FontWeight.w500,
  Color color = AppColors.backgroundColor,
  int maxLines = 1,
}) =>
    customDisplayText(
      label: label,
      fontSize: fontSize ?? 14,
      fontWeight: fontWeight,
      maxLines: maxLines,
      color: color,
      nullText: nullText,
    );

Widget customDisplayText({
  required String? label,
  String nullText = 'N/A',
  required double fontSize,
  required FontWeight fontWeight,
  Color color = AppColors.backgroundColor,
  int maxLines = 1,
}) =>
    Text(
      label ?? nullText,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: .5,
      ),
      maxLines: maxLines,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
    );

// Widget _manageIconButton({String? houseKey}) => Flexible(
//   flex: 1,
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     crossAxisAlignment: CrossAxisAlignment.end,
//     children: [
//       Padding(
//         padding: const EdgeInsets.only(top: 8.0, left: 16),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.key,
//               color: AppColors.primaryColor.withOpacity(.5),
//               size: 18,
//             ),
//             const SizedBox(
//               width: 8,
//             ),
//             Text(
//               house.houseKey ?? 'House Id',
//               style: TextStyle(
//                 color: AppColors.primaryColor.withOpacity(.9),
//               ),
//             )
//           ],
//         ),
//       ),
//       // IconButton(
//       //   onPressed: () => UserServices().createNewUser(),
//       //   icon: const Icon(
//       //     Icons.settings,
//       //     color: AppColors.primaryColor,
//       //     size: 18,
//       //   ),
//       //   visualDensity: VisualDensity.compact,
//       // ),
//     ],
//   ),
// );
