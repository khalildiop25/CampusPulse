import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/course_provider.dart';

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

            itemBuilder: (context, index) {

              final course = data[index];

              return Card(
                margin: const EdgeInsets.all(10),

                child: ListTile(
                  title: Text(course.titre),

                  subtitle: Text(
                    '${course.salle} • ${course.enseignant}',
                  ),

                  trailing: Text(
                    '${course.heureDebut} - ${course.heureFin}',
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