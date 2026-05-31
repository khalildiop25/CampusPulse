import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/services/notification_service.dart';

import 'features/schedule/presentation/pages/schedule_page.dart';
import 'core/constants/app_colors.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/auth/presentation/pages/login_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'features/splash/presentation/pages/splash_page.dart';

import 'core/providers/theme_provider.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  await NotificationService().init();


  runApp(

    const ProviderScope(

      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {

  const MyApp({super.key});

  @override
  Widget build(

      BuildContext context,
      WidgetRef ref,

      ) {
    final isDark =
    ref.watch(themeProvider);

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'CampusPulse',

      theme: ThemeData(

        brightness: Brightness.light,

        primaryColor: Colors.blue,

        appBarTheme: const AppBarTheme(

          backgroundColor: Colors.blue,

          foregroundColor: Colors.white,

          centerTitle: true,
        ),

        bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(

          selectedItemColor:
          Colors.blue,
        ),
      ),

      darkTheme: ThemeData(

        brightness: Brightness.dark,

        appBarTheme: const AppBarTheme(

          backgroundColor:
          Colors.black,

          foregroundColor:
          Colors.white,

          centerTitle: true,
        ),

        bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(

          selectedItemColor:
          Colors.blue,
        ),
      ),

      themeMode:
      isDark
          ? ThemeMode.dark
          : ThemeMode.light,

      home: const SplashPage(),
    );
  }
}