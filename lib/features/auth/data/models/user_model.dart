import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String role;
  final String nom;
  final String prenom;
  final String? adresse;
  final DateTime? createdAt;

  const UserModel({
    required this.id,
    required this.email,
    required this.role,
    required this.nom,
    required this.prenom,
    this.adresse,
    this.createdAt,
  });

  String get fullName => "$prenom $nom".trim();

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      nom: json['nom'] ?? '',
      prenom: json['prenom'] ?? '',
      adresse: json['adresse'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }

  @override
  List<Object?> get props => [id, email, role, nom, prenom, adresse, createdAt];
}