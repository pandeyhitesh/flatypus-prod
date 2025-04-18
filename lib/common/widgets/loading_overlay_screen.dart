import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../methods.dart';

Widget showLoadingOverlay() => Container(
      height: kScreenHeight,
      width: kScreenWidth,
      color: Colors.white10,
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.yellowAccent,
          strokeWidth: 2,
          strokeCap: StrokeCap.round,
        ),
      ),
    );
