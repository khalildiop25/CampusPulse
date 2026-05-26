import 'package:flutter/material.dart';

import '../../domain/entities/course_entity.dart';

class CourseDetailsPage extends StatelessWidget {

  final CourseEntity course;

  const CourseDetailsPage({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Détails du cours',
        ),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            Center(

              child: Container(

                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(

                  color:
                  Colors.blue.withOpacity(0.1),

                  shape: BoxShape.circle,
                ),

                child: const Icon(

                  Icons.school,

                  size: 50,

                  color: Colors.blue,
                ),
              ),
            ),

            const SizedBox(height: 30),

            Text(

              course.titre,

              style: const TextStyle(

                fontSize: 28,

                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            buildInfoTile(
              Icons.location_on,
              'Salle',
              course.salle,
            ),

            buildInfoTile(
              Icons.person,
              'Enseignant',
              course.enseignant,
            ),

            buildInfoTile(
              Icons.access_time,
              'Horaire',
              '${course.heureDebut} - ${course.heureFin}',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoTile(
      IconData icon,
      String title,
      String value,
      ) {

    return Container(

      margin: const EdgeInsets.only(
        bottom: 16,
      ),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(16),

        boxShadow: [

          BoxShadow(

            color:
            Colors.black.withOpacity(0.05),

            blurRadius: 10,

            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(

        children: [

          Icon(
            icon,
            color: Colors.blue,
          ),

          const SizedBox(width: 16),

          Expanded(

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(

                  title,

                  style: const TextStyle(

                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(value),
              ],
            ),
          ),
        ],
      ),
    );
  }
}