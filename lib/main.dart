import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flatypus/common/methods.dart';
import 'package:flatypus/screens/authentication/auth_screen.dart';
import 'package:flatypus/services/auth_service.dart';
import 'package:flatypus/services/cloud_messaging/push_notification_service.dart';
import 'package:flatypus/services/global_context.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   NotificationService().
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  Future<void> _initializeNotifications() async {
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      if (message.notification != null) {
        NotificationService().showLocalNotification(message);
      }
    });
    await _notificationService.initialize(context, ref);
  }

  late NotificationService _notificationService;

  @override
  void initState() {
    super.initState();
    _notificationService = NotificationService();
    _initializeNotifications();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: GlobalContext.navigationKey,
      title: 'Flutter Demo',
      color: AppColors.yellowAccent,
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          surfaceTint: kTransparent,
          surface: AppColors.secondaryColor,
          primary: AppColors.primaryColor,
          secondary: AppColors.secondaryColor,
          tertiary: AppColors.yellowAccent,
          inversePrimary: Colors.green,
          onPrimary: AppColors.white,
          onPrimaryContainer: Colors.purple,
        ),
        primaryTextTheme: TextTheme(
          bodySmall: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w400,
            fontSize: 12,
            fontFamily: 'Mukta',
          ),
          bodyMedium: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            fontFamily: 'Mukta',
          ),
          bodyLarge: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w400,
            fontSize: 16,
            fontFamily: 'Mukta',
          ),

          titleMedium: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            fontFamily: 'Mukta',
          ),

          labelSmall: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            fontFamily: 'Mukta',
          ),
          labelMedium: TextStyle(
            color: AppColors.white.withAlpha(alphaFromOpacity(.3)),
            fontWeight: FontWeight.w400,
            fontSize: 16,
            fontFamily: 'Mukta',
          ),
          headlineSmall: TextStyle(
            color: AppColors.white.withAlpha(alphaFromOpacity(.9)),
            fontWeight: FontWeight.w600,
            fontSize: 16,
            fontFamily: 'Mukta',
          ),
          headlineMedium: TextStyle(
            color: AppColors.white.withAlpha(alphaFromOpacity(.9)),
            fontWeight: FontWeight.w600,
            fontSize: 20,
            fontFamily: 'Mukta',
          ),
          headlineLarge: TextStyle(
            color: AppColors.white.withAlpha(alphaFromOpacity(.9)),
            fontWeight: FontWeight.w600,
            fontSize: 24,
            fontFamily: 'Mukta',
          ),



        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.secondaryColor.withAlpha(200),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedIconTheme: const IconThemeData(
            color: AppColors.selectedIconColor,
            size: 22,
          ),
          unselectedIconTheme: IconThemeData(
            color: AppColors.unselectedIconColor,
            size: 20,
          ),
          selectedLabelStyle: const TextStyle(
            color: AppColors.selectedIconColor,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: .5,
          ),
          unselectedLabelStyle: const TextStyle(
            color: AppColors.selectedIconColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: .5,
          ),
          selectedItemColor: AppColors.selectedIconColor,
          unselectedItemColor: AppColors.unselectedIconColor,
        ),
      ),
      themeMode: ThemeMode.dark,
      home: const AuthScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
