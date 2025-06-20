import 'package:color_log/color_log.dart';
import 'package:flatypus/state/controllers/loading_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Loader {
  const Loader._();
  static void startLoading(BuildContext context, WidgetRef ref) => {
    if (context.mounted)
      ref.read(loadingControllerProvider.notifier).startLoading(),
  };

  static void stopLoading(BuildContext context, WidgetRef ref) => {
    clog.info('Loader.stopLoading: called'),
    if (context.mounted)
      {ref.read(loadingControllerProvider.notifier).stopLoading()}else{
      clog.info('Loader.stopLoading: context not mounted'),
    },
  };
}
