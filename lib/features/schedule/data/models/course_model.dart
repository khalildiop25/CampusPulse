import '../../domain/entities/course_entity.dart';

class CourseModel extends CourseEntity {

  CourseModel({
    required super.titre,
    required super.salle,
    required super.enseignant,
    required super.heureDebut,
    required super.heureFin,
  });

  factory CourseModel.fromFirestore(
      Map<String, dynamic> json,
      ) {

    return CourseModel(
      titre: json['titre'] ?? '',
      salle: json['salle'] ?? '',
      enseignant: json['enseignant'] ?? '',
      heureDebut: json['heureDebut'] ?? '',
      heureFin: json['heureFin'] ?? '',
    );
  }
}