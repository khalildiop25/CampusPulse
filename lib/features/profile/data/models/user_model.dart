import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {

  UserModel({

    required super.uid,

    required super.nom,

    required super.prenom,

    required super.email,

    required super.filiere,

    required super.niveau,

    required super.photoUrl,
  });

  factory UserModel.fromMap(
      Map<String, dynamic> map,
      ) {

    return UserModel(

      uid: map['uid'] ?? '',

      nom: map['nom'] ?? '',

      prenom:
      map['prenom'] ?? '',

      email:
      map['email'] ?? '',

      filiere:
      map['filiere'] ?? '',

      niveau:
      map['niveau'] ?? '',

      photoUrl:
      map['photoUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {

    return {

      'uid': uid,

      'nom': nom,

      'prenom': prenom,

      'email': email,

      'filiere': filiere,

      'niveau': niveau,

      'photoUrl': photoUrl,
    };
  }
}