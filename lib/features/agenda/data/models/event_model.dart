import 'package:equatable/equatable.dart';

class EventModel extends Equatable {
  final String id;
  final String title;
  final DateTime date;
  final String time;
  final String? location;
  final String? participants;
  final String? description;
  final String? notes;

  /// Couleur de la bordure gauche de la card : 'blue' | 'violet' | 'green'
  final String colorTag;

  /// Nombre de participants (pour l'icône people)
  final int? participantCount;

  /// Lien de la réunion (Visio Teams, Meet, etc.)
  final String? joinUrl;

  const EventModel({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    this.location,
    this.participants,
    this.description,
    this.notes,
    this.colorTag = 'blue',
    this.participantCount,
    this.joinUrl,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') != null
          ? DateTime.parse(json['date']).toLocal() // Normaliser la date
          : DateTime.now(),
      time: json['time'] ?? '',
      location: json['location'],
      participants: json['participants'],
      description: json['description'],
      notes: json['notes'],
      colorTag: json['colorTag'] ?? 'blue',
      participantCount: json['participantCount'] != null
          ? int.tryParse(json['participantCount'].toString())
          : null,
      joinUrl: json['joinUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'date': date.toIso8601String().split('T').first,
        'time': time,
        'location': location,
        'participants': participants,
        'description': description,
        'notes': notes,
        'colorTag': colorTag,
        'participantCount': participantCount,
        'joinUrl': joinUrl,
      };

  EventModel copyWith({
    String? id,
    String? title,
    DateTime? date,
    String? time,
    String? location,
    String? participants,
    String? description,
    String? notes,
    String? colorTag,
    int? participantCount,
    String? joinUrl,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      time: time ?? this.time,
      location: location ?? this.location,
      participants: participants ?? this.participants,
      description: description ?? this.description,
      notes: notes ?? this.notes,
      colorTag: colorTag ?? this.colorTag,
      participantCount: participantCount ?? this.participantCount,
      joinUrl: joinUrl ?? this.joinUrl,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        date,
        time,
        location,
        participants,
        description,
        notes,
        colorTag,
        participantCount,
        joinUrl,
      ];
}