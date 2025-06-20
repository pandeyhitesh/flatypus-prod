import 'package:flatypus/common/widgets/base_layout.dart';
import 'package:flatypus/screens/app.dart';
import 'package:flatypus/state/controllers/loading_controller.dart';
import 'package:flatypus/state/notifires/auth_notifier.dart';
import 'package:flatypus/state/providers/auth_provider.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'login_screen.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStatus = ref.watch(authProvider);
    return BaseLayout(
      body:
          authStatus == AuthStatus.loggedIn ? const App() : const LoginScreen(),
    );
  }
}
