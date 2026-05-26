import 'dart:async';

import 'package:flutter/material.dart';

import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../auth/presentation/pages/login_page.dart';

import '../../../home/presentation/pages/home_page.dart';

class SplashPage extends StatefulWidget {

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() =>
      _SplashPageState();
}

class _SplashPageState
    extends State<SplashPage> {

  @override
  void initState() {

    super.initState();

    startApp();
  }

  void startApp() {

    Timer(

      const Duration(seconds: 4),

          () {

        final user =
            FirebaseAuth.instance.currentUser;

        if (user != null) {

          Navigator.pushReplacement(

            context,

            MaterialPageRoute(

              builder: (_) =>
              const HomePage(),
            ),
          );
        }

        else {

          Navigator.pushReplacement(

            context,

            MaterialPageRoute(

              builder: (_) =>
              const LoginPage(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.blue,

      body: Center(

        child: Column(

          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            Container(

              padding:
              const EdgeInsets.all(24),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                BorderRadius.circular(30),
              ),

              child: const Icon(

                Icons.school,

                size: 80,

                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 40),

            AnimatedTextKit(

              animatedTexts: [

                TyperAnimatedText(

                  'CampusPulse',

                  textStyle:
                  const TextStyle(

                    fontSize: 36,

                    fontWeight:
                    FontWeight.bold,

                    color: Colors.white,
                  ),

                  speed: const Duration(
                    milliseconds: 150,
                  ),
                ),
              ],

              totalRepeatCount: 1,
            ),

            const SizedBox(height: 20),

            const CircularProgressIndicator(

              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}