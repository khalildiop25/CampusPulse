import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../data/auth_service.dart';

import '../../../home/presentation/pages/home_page.dart';

class RegisterPage extends StatefulWidget {

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() =>
      _RegisterPageState();
}

class _RegisterPageState
    extends State<RegisterPage> {

  final emailController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  final authService = AuthService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Créer un compte',
        ),
      ),

      body: Padding(

        padding: const EdgeInsets.all(24),

        child: Column(

          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            const Icon(

              Icons.person_add,

              size: 90,

              color: Colors.blue,
            ),

            const SizedBox(height: 30),

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

                    await authService.register(

                      email:
                      emailController.text
                          .trim(),

                      password:
                      passwordController.text
                          .trim(),
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

                    String message = 'Erreur';

                    if (e.code ==
                        'email-already-in-use') {

                      message =
                      'Email déjà utilisé';
                    }

                    else if (e.code ==
                        'weak-password') {

                      message =
                      'Mot de passe trop faible';
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
                  'Créer un compte',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}