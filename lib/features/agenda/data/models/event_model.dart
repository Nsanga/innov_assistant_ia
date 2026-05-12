import 'package:equatable/equatable.dart';

class EventModel extends Equatable {
  final String id;
  final String title;
  final String date;        // YYYY-MM-DD
  final String time;        // ex: "14:00 - 15:30"
  final String? participants;
  final String? notes;
  final String? location;

  const EventModel({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    this.participants,
    this.notes,
    this.location,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      participants: json['participants'],
      notes: json['notes'],
      location: json['location'],
    );
  }

  @override
  List<Object?> get props => [id, title, date, time, participants, notes];
}