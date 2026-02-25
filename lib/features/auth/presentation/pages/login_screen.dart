
import 'package:flatypus/features/auth/presentation/providers/auth_providers.dart';
import 'package:flatypus/features/home/presentation/pages/home_screen.dart';
import 'package:flatypus/features/house/presentation/pages/add_house_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});
  void _onPressedMethod(BuildContext context, WidgetRef ref) async {
    try {
      final userCredential = await ref.read(signInWithGoogleProvider.future);
      print("userCred = $userCredential");
      if (userCredential != null && context.mounted) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> HomeScreen()));
      }
    } catch (e) {
      if (context.mounted) {
        print("Error = $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign in failed: $e')),
          
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: Center(
                child: Stack(
                  children: [
                    SizedBox(
                      height: 200,
                      width: 250,
                      child: Image.asset('assets/images/house-logo.png'),
                    ),
                    const Positioned(
                      bottom: 0,
                      child: SizedBox(
                        width: 250,
                        child: Center(
                          child: Text(
                            'Flatipus',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                              letterSpacing: .5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellowAccent.withOpacity(.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () => _onPressedMethod(context, ref),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.asset(
                                'assets/images/google-logo.png',
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Text(
                              'Sign in with Google',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                letterSpacing: .5,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(width: 40),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
