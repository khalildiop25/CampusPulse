import 'package:flutter/material.dart';
import '../../data/auth_service.dart';

import '../../../home/presentation/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() =>
      _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authService = AuthService();

  final emailController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Padding(

        padding: const EdgeInsets.all(24),

        child: Column(

          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            const Icon(

              Icons.school,

              size: 100,

              color: Colors.blue,
            ),

            const SizedBox(height: 30),

            const Text(

              'CampusPulse',

              style: TextStyle(

                fontSize: 32,

                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            TextField(

              controller: emailController,

              decoration: InputDecoration(

                labelText: 'Email',

                border:
                OutlineInputBorder(

                  borderRadius:
                  BorderRadius.circular(16),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(

              controller:
              passwordController,

              obscureText: true,

              decoration: InputDecoration(

                labelText:
                'Mot de passe',

                border:
                OutlineInputBorder(

                  borderRadius:
                  BorderRadius.circular(16),
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(

              width: double.infinity,

              height: 55,

              child: ElevatedButton(

                onPressed: () async {

                  try {

                    await authService.login(

                      email:
                      emailController.text.trim(),

                      password:
                      passwordController.text.trim(),
                    );

                    if (!context.mounted) return;

                    Navigator.pushReplacement(

                      context,

                      MaterialPageRoute(

                        builder: (_) =>
                        const HomePage(),
                      ),
                    );

                  } on FirebaseAuthException catch (e) {
                    print(e.code);

                    String message = 'Erreur';

                    if (e.code == 'user-not-found') {

                      message =
                      'Utilisateur introuvable';
                    }

                    else if (e.code == 'wrong-password') {

                      message =
                      'Mot de passe incorrect';
                    }

                    else if (e.code == 'invalid-email') {

                      message =
                      'Email invalide';
                    }

                    ScaffoldMessenger.of(context)
                        .showSnackBar(

                      SnackBar(
                        content: Text(message),
                      ),
                    );
                  }
                },

                child: const Text(
                  'Connexion',
                ),
              ),
            ),
            const SizedBox(height: 20),

            TextButton(

              onPressed: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_) =>
                    const RegisterPage(),
                  ),
                );
              },

              child: const Text(
                'Créer un compte',
              ),
            ),
          ],
        ),
      ),
    );
  }
}