import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../auth/presentation/pages/login_page.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/theme_provider.dart';

class ProfilePage extends ConsumerWidget {

  const ProfilePage({super.key});

  @override
  Widget build(

      BuildContext context,
      WidgetRef ref,

      ) {
    final isDark =
    ref.watch(themeProvider);

    final user =
        FirebaseAuth.instance.currentUser;

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Profil',
        ),
      ),

      body: Padding(

        padding: const EdgeInsets.all(24),

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            Center(

              child: Column(

                children: [

                  const CircleAvatar(

                    radius: 50,

                    child: Icon(
                      Icons.person,
                      size: 50,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(

                    user?.email ??
                        'Utilisateur',

                    style: const TextStyle(

                      fontSize: 20,

                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SwitchListTile(

              value: isDark,

              onChanged: (value) {

                ref.read(
                  themeProvider.notifier,
                ).state = value;
              },

              title: const Text(
                'Mode sombre',
              ),

              secondary: const Icon(
                Icons.dark_mode,
              ),
            ),
            const Spacer(),

            SizedBox(

              width: double.infinity,

              height: 55,

              child: ElevatedButton.icon(

                onPressed: () async {

                  await FirebaseAuth
                      .instance
                      .signOut();

                  if (!context.mounted) return;

                  Navigator.pushAndRemoveUntil(

                    context,

                    MaterialPageRoute(

                      builder: (_) =>
                      const LoginPage(),
                    ),

                        (route) => false,
                  );
                },

                icon: const Icon(
                  Icons.logout,
                ),

                label: const Text(
                  'Déconnexion',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}