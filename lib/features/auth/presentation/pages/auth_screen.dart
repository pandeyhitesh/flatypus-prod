import 'package:flatypus/core/utils/enums.dart';
import 'package:flatypus/features/auth/presentation/providers/auth_providers.dart';
import 'package:flatypus/features/common/pages/app.dart';
import 'package:flatypus/features/common/widgets/base_layout.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'login_screen.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStatus = ref
        .watch(authProvider)
        .when(
          data: (data) => data,
          error: (error, stackTrace) => AuthStatus.loggedOut,
          loading: () => AuthStatus.loggedOut,
        );
    return BaseLayout(
      body:
          authStatus == AuthStatus.loggedIn ? const App() : const LoginScreen(),
    );
  }
}
