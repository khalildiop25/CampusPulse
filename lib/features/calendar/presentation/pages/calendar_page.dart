import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {

  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() =>
      _CalendarPageState();
}

class _CalendarPageState
    extends State<CalendarPage> {

  DateTime today =
  DateTime.now();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          'Calendrier',
        ),
      ),

      body: Column(

        children: [

          TableCalendar(

            focusedDay: today,

            firstDay:
            DateTime(2024),

            lastDay:
            DateTime(2030),

            calendarFormat:
            CalendarFormat.week,

            selectedDayPredicate:
                (day) {

              return isSameDay(
                today,
                day,
              );
            },

            onDaySelected:
                (selectedDay,
                focusedDay) {

              setState(() {

                today =
                    selectedDay;
              });
            },
          ),

          const SizedBox(height: 20),

          Expanded(

            child: ListView(

              padding:
              const EdgeInsets.all(16),

              children: [

                Container(

                  padding:
                  const EdgeInsets.all(20),

                  decoration: BoxDecoration(

                    color: Colors.blue
                        .withOpacity(0.1),

                    borderRadius:
                    BorderRadius.circular(20),
                  ),

                  child: Column(

                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Text(

                        'Cours du jour',

                        style: Theme.of(context)
                            .textTheme
                            .titleLarge,
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      Text(

                        '${today.day}/${today.month}/${today.year}',

                        style:
                        const TextStyle(

                          fontSize: 18,

                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      const Text(
                        'Aucun cours programmé',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}