import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider((ref) {
  return GoRouter(
    routes: [
      GoRoute(path: '/', builder: (_, __) => SizedBox()),
      GoRoute(
        path: '',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return SizedBox();
        },
      ),
    ],
  );
});
