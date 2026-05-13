part of 'agenda_bloc.dart';

abstract class AgendaEvent extends Equatable {
  const AgendaEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvents extends AgendaEvent {
  const LoadEvents();
}

class CreateEvent extends AgendaEvent {
  final EventModel event;
  const CreateEvent(this.event);

  @override
  List<Object?> get props => [event];
}

class UpdateEvent extends AgendaEvent {
  final String eventId;
  final EventModel event;
  const UpdateEvent(this.eventId, this.event);

  @override
  List<Object?> get props => [eventId, event];
}

class DeleteEvent extends AgendaEvent {
  final String eventId;
  const DeleteEvent(this.eventId);

  @override
  List<Object?> get props => [eventId];
}