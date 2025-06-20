import 'package:flatypus/state/controllers/loading_controller.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BaseLayout extends ConsumerWidget {
  const BaseLayout({
    super.key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.showAppBar = false,
    this.showBottomNavigationBar = false,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
  });
  final AppBar? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final bool showAppBar;
  final bool showBottomNavigationBar;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loadingControllerProvider);
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: backgroundColor ?? AppColors.backgroundColor,
      appBar: showAppBar ? appBar : null,
      body: SafeArea(
        child: Stack(
          children: [
            body,
            if (isLoading)
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: AppColors.primaryColor.withAlpha(150),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.secondaryColor,
                    strokeWidth: 5,
                    strokeCap: StrokeCap.round,
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: showBottomNavigationBar ? bottomNavigationBar : null,
    );
  }
}
