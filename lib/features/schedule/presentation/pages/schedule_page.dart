import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/course_provider.dart';
import 'course_details_page.dart';

class SchedulePage extends ConsumerWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final courses = ref.watch(courseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Emploi du temps'),
      ),

      body: courses.when(

        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            padding: const EdgeInsets.all(16),

            itemBuilder: (context, index) {

              final course = data[index];

              return Container(

                margin: const EdgeInsets.only(
                  bottom: 16,
                ),

                decoration: BoxDecoration(

                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(16),

                  boxShadow: [

                    BoxShadow(

                      color: Colors.black.withOpacity(0.05),

                      blurRadius: 10,

                      offset: const Offset(0, 4),
                    ),
                  ],
                ),

                child: ListTile(
                  onTap: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (_) =>
                            CourseDetailsPage(
                              course: course,
                            ),
                      ),
                    );
                  },

                  contentPadding:
                  const EdgeInsets.all(16),

                  leading: Container(

                    padding: const EdgeInsets.all(12),

                    decoration: BoxDecoration(

                      color: Colors.blue.withOpacity(0.1),

                      borderRadius:
                      BorderRadius.circular(12),
                    ),

                    child: const Icon(
                      Icons.school,
                      color: Colors.blue,
                    ),
                  ),

                  title: Text(

                    course.titre,

                    style: const TextStyle(

                      fontWeight: FontWeight.bold,

                      fontSize: 16,
                    ),
                  ),

                  subtitle: Padding(

                    padding: const EdgeInsets.only(
                      top: 8,
                    ),

                    child: Text(
                      '${course.salle} • ${course.enseignant}',
                    ),
                  ),

                  trailing: Text(

                    '${course.heureDebut}\n${course.heureFin}',

                    textAlign: TextAlign.center,

                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          );
        },

        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },

        error: (error, stack) {
          return Center(
            child: Text(error.toString()),
          );
        },
      ),
    );
  }
}