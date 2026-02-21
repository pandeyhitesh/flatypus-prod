import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingControllerNotifier extends StateNotifier<bool> {
  LoadingControllerNotifier() : super(false);

  void startLoading() => state = true;
  void stopLoading() => state = false;
  void toggleLoading() => state = !state;
  bool get isLoading => state;
}

final loadingControllerProvider =
    StateNotifierProvider<LoadingControllerNotifier, bool>(
      (ref) => LoadingControllerNotifier(),
    );
