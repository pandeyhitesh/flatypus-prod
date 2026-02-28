import 'package:flatypus/core/utils/enums.dart';
import 'package:flatypus/features/auth/presentation/providers/auth_providers.dart';
import 'package:flatypus/features/auth/presentation/providers/session_restore_provider.dart';
import 'package:flatypus/features/common/pages/app.dart';
import 'package:flatypus/features/common/widgets/base_layout.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'login_screen.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Wait for session restore to complete before deciding where to route.
    // This ensures tokenProvider is populated before any API call fires.
    final sessionRestore = ref.watch(sessionRestoreProvider);

    return sessionRestore.when(
      // While restoring (fetching backend token for existing Firebase session)
      loading:
          () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
      // Restore done (or no user) — now check Firebase auth status and route
      data: (_) {
        final authStatus = ref
            .watch(authProvider)
            .when(
              data: (data) => data,
              error: (_, __) => AuthStatus.loggedOut,
              loading: () => AuthStatus.loggedOut,
            );
        return BaseLayout(
          body:
              authStatus == AuthStatus.loggedIn
                  ? const App()
                  : const LoginScreen(),
        );
      },
      // Restore failed (e.g. no network) — still proceed, 401 retry will handle it
      error: (_, __) {
        final authStatus = ref
            .watch(authProvider)
            .when(
              data: (data) => data,
              error: (_, __) => AuthStatus.loggedOut,
              loading: () => AuthStatus.loggedOut,
            );
        return BaseLayout(
          body:
              authStatus == AuthStatus.loggedIn
                  ? const App()
                  : const LoginScreen(),
        );
      },
    );

    // final authStatus = ref
    //     .watch(authProvider)
    //     .when(
    //       data: (data) => data,
    //       error: (error, stackTrace) => AuthStatus.loggedOut,
    //       loading: () => AuthStatus.loggedOut,
    //     );
    // return BaseLayout(
    //   body:
    //       authStatus == AuthStatus.loggedIn ? const App() : const LoginScreen(),
    // );
  }
}
