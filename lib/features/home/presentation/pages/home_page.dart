import 'package:flutter/material.dart';

import '../../../schedule/presentation/pages/schedule_page.dart';
import '../../../calendar/presentation/pages/calendar_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;

  final pages = [

    const SchedulePage(),

    const CalendarPage(),

    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: pages[currentIndex],

      bottomNavigationBar:
      BottomNavigationBar(

        currentIndex: currentIndex,

        onTap: (index) {

          setState(() {

            currentIndex = index;
          });
        },

        items: const [

          BottomNavigationBarItem(

            icon: Icon(Icons.home),

            label: 'Accueil',
          ),

          BottomNavigationBarItem(

            icon: Icon(Icons.calendar_month),

            label: 'Calendrier',
          ),

          BottomNavigationBarItem(

            icon: Icon(Icons.person),

            label: 'Profil',
          ),
        ],
      ),
    );
  }
}