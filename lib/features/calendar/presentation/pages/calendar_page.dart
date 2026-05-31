import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:table_calendar/table_calendar.dart';

import '../../../schedule/presentation/providers/course_provider.dart';

class CalendarPage
    extends ConsumerStatefulWidget {

  const CalendarPage({
    super.key,
  });

  @override
  ConsumerState<CalendarPage>
  createState() =>
      _CalendarPageState();
}

class _CalendarPageState
    extends ConsumerState<CalendarPage> {

  DateTime today =
  DateTime.now();

  @override
  Widget build(BuildContext context) {

    final coursesAsync =
    ref.watch(
      courseProvider,
    );

    final courses =
        coursesAsync.value ?? [];

    final selectedCourses =
    courses.where((course) {

      try {

        final courseDate =
        DateTime.parse(
          course.date,
        );

        return isSameDay(
          courseDate,
          today,
        );

      } catch (e) {

        return false;
      }

    }).toList();

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          'Calendrier',
        ),
      ),

      body: Column(

        children: [

          // =========================
          // CALENDRIER
          // =========================

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
                (
                selectedDay,
                focusedDay,
                ) {

              setState(() {

                today =
                    selectedDay;
              });
            },
          ),

          const SizedBox(
            height: 20,
          ),

          // =========================
          // LISTE DES COURS
          // =========================

          Expanded(

            child: Padding(

              padding:
              const EdgeInsets.all(
                16,
              ),

              child:
              selectedCourses
                  .isEmpty

                  ? Container(

                width:
                double.infinity,

                padding:
                const EdgeInsets.all(
                  24,
                ),

                decoration:
                BoxDecoration(

                  color: Colors.blue
                      .withOpacity(
                    0.1,
                  ),

                  borderRadius:
                  BorderRadius.circular(
                    20,
                  ),
                ),

                child: Column(

                  mainAxisSize:
                  MainAxisSize.min,

                  children: [

                    const Icon(

                      Icons
                          .calendar_month,

                      size: 60,

                      color:
                      Colors.blue,
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    Text(

                      '${today.day}/${today.month}/${today.year}',

                      style:
                      const TextStyle(

                        fontSize:
                        20,

                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    const Text(

                      'Aucun cours programmé',

                      style:
                      TextStyle(

                        fontSize:
                        16,
                      ),
                    ),
                  ],
                ),
              )

                  : ListView.builder(

                itemCount:
                selectedCourses
                    .length,

                itemBuilder:
                    (
                    context,
                    index,
                    ) {

                  final course =
                  selectedCourses[
                  index];

                  return Container(

                    margin:
                    const EdgeInsets.only(
                      bottom:
                      16,
                    ),

                    decoration:
                    BoxDecoration(

                      color:
                      Colors.white,

                      borderRadius:
                      BorderRadius.circular(
                        20,
                      ),

                      boxShadow: [

                        BoxShadow(

                          color: Colors
                              .black
                              .withOpacity(
                            0.05,
                          ),

                          blurRadius:
                          10,

                          offset:
                          const Offset(
                            0,
                            4,
                          ),
                        ),
                      ],
                    ),

                    child:
                    ListTile(

                      contentPadding:
                      const EdgeInsets.all(
                        16,
                      ),

                      leading:
                      Container(

                        padding:
                        const EdgeInsets.all(
                          12,
                        ),

                        decoration:
                        BoxDecoration(

                          color: Colors
                              .blue
                              .withOpacity(
                            0.1,
                          ),

                          borderRadius:
                          BorderRadius.circular(
                            12,
                          ),
                        ),

                        child:
                        const Icon(

                          Icons.school,

                          color:
                          Colors.blue,
                        ),
                      ),

                      title: Text(

                        course.titre,

                        style:
                        const TextStyle(

                          fontWeight:
                          FontWeight.bold,

                          fontSize:
                          16,
                        ),
                      ),

                      subtitle:
                      Padding(

                        padding:
                        const EdgeInsets.only(
                          top: 8,
                        ),

                        child:
                        Column(

                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                          children: [

                            Text(
                              course
                                  .enseignant,
                            ),

                            Text(
                              course
                                  .salle,
                            ),
                          ],
                        ),
                      ),

                      trailing:
                      Text(

                        '${course.heureDebut}\n'
                            '${course.heureFin}',

                        textAlign:
                        TextAlign
                            .center,

                        style:
                        const TextStyle(

                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}