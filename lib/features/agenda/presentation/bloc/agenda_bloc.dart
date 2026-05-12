import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repositories/agenda_repository.dart';
import '../../data/models/event_model.dart';

part 'agenda_event.dart';
part 'agenda_state.dart';

class AgendaBloc extends Bloc<AgendaEvent, AgendaState> {
  final AgendaRepository repository;

  AgendaBloc(this.repository) : super(AgendaInitial()) {
    on<LoadEvents>(_onLoadEvents);
    on<CreateEvent>(_onCreateEvent);
    on<UpdateEvent>(_onUpdateEvent);
    on<DeleteEvent>(_onDeleteEvent);
  }

  Future<void> _onLoadEvents(LoadEvents event, Emitter<AgendaState> emit) async {
    emit(AgendaLoading());
    try {
      final events = await repository.getEvents(range: 'week');
      emit(AgendaLoaded(events));
    } catch (e) {
      emit(AgendaError(e.toString()));
    }
  }

  Future<void> _onCreateEvent(CreateEvent event, Emitter<AgendaState> emit) async {
    try {
      final newEvent = await repository.createEvent(event.event);
      final currentEvents = state is AgendaLoaded ? (state as AgendaLoaded).events : <EventModel>[];
      emit(AgendaLoaded([...currentEvents, newEvent]));
    } catch (e) {
      emit(AgendaError(e.toString()));
    }
  }

  
}