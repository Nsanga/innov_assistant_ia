import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String email;
  final String role;
  final String nom;
  final String prenom;
  final String? adresse;
  final String? status;
  final String? department;
  final String? phone;
  final String? avatarUrl;
  final DateTime? createdAt;
  final String? token;

  const UserModel({
    required this.id,
    required this.email,
    required this.role,
    required this.nom,
    required this.prenom,
    this.adresse,
    this.status,
    this.department,
    this.phone,
    this.avatarUrl,
    this.createdAt,
    this.token,
  });

  String get fullName => "$prenom $nom".trim();

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: _parseInt(json['id']),
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      nom: json['nom'] ?? _extractNom(json['full_name'] ?? ''),
      prenom: json['prenom'] ?? _extractPrenom(json['full_name'] ?? ''),
      adresse: json['adresse'],
      status: json['status'],
      department: json['department'],
      phone: json['phone'],
      avatarUrl: json['avatar_url'],
      createdAt: json['created_at'] != null 
          ? DateTime.tryParse(json['created_at'])
          : null,
      token: json['token'] ?? json['access_token'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'role': role,
        'nom': nom,
        'prenom': prenom,
        'full_name': fullName,
        'adresse': adresse,
        'status': status,
        'department': department,
        'phone': phone,
        'avatar_url': avatarUrl,
        'created_at': createdAt?.toIso8601String(),
        'token': token,
      };

  UserModel copyWith({
    int? id,
    String? email,
    String? role,
    String? nom,
    String? prenom,
    String? adresse,
    String? status,
    String? department,
    String? phone,
    String? avatarUrl,
    DateTime? createdAt,
    String? token,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      role: role ?? this.role,
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      adresse: adresse ?? this.adresse,
      status: status ?? this.status,
      department: department ?? this.department,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      createdAt: createdAt ?? this.createdAt,
      token: token ?? this.token,
    );
  }

  /// Parse un id qui peut être int, String ou null
  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is double) return value.toInt();
    return 0;
  }

  /// Extrait le prénom depuis le full_name
  static String _extractPrenom(String fullName) {
    final parts = fullName.trim().split(' ');
    return parts.isNotEmpty ? parts.first : '';
  }

  /// Extrait le nom depuis le full_name
  static String _extractNom(String fullName) {
    final parts = fullName.trim().split(' ');
    return parts.length > 1 ? parts.sublist(1).join(' ') : '';
  }

  /// Initiales de l'utilisateur
  String get initials {
    if (prenom.isNotEmpty && nom.isNotEmpty) {
      return '${prenom[0]}${nom[0]}'.toUpperCase();
    }
    return fullName.isNotEmpty ? fullName[0].toUpperCase() : 'U';
  }

  @override
  List<Object?> get props => [
        id,
        email,
        role,
        nom,
        prenom,
        adresse,
        status,
        department,
        phone,
        avatarUrl,
        createdAt,
        token,
      ];

  @override
  String toString() => 'UserModel(id: $id, email: $email, fullName: $fullName, role: $role)';
}