import 'package:dio/dio.dart';
import 'package:mobile_assistant_ia/services/api/api_client.dart';
import 'package:mobile_assistant_ia/services/api/api_endpoints.dart';
import '../models/event_model.dart';

class AgendaRepository {
  final ApiClient _apiClient;

  AgendaRepository(this._apiClient);

  Future<List<EventModel>> getEvents({String? date, String? range}) async {
    try {
      final response = await _apiClient.dio.get(
        ApiEndpoints.agenda,
        queryParameters: {
          if (date != null) 'date': date,
          if (range != null) 'range': range,
        },
      );

      return (response.data as List)
          .map((json) => EventModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw Exception('Erreur lors du chargement de l\'agenda');
    }
  }

  Future<EventModel> createEvent(EventModel event) async {
    try {
      final response = await _apiClient.dio.post(
        ApiEndpoints.agenda,
        data: {
          "title": event.title,
          "date": event.date,
          "time": event.time,
          "participants": event.participants ?? "",
          "notes": event.notes ?? "",
        },
      );
      return EventModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Erreur lors de la création');
    }
  }

  Future<EventModel> updateEvent(String eventId, EventModel event) async {
    try {
      final response = await _apiClient.dio.patch(
        '${ApiEndpoints.agenda}/$eventId',
        data: {
          "title": event.title,
          "date": event.date,
          "time": event.time,
          "participants": event.participants,
          "notes": event.notes,
        },
      );
      return EventModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Erreur lors de la modification');
    }
  }

  Future<void> deleteEvent(String eventId) async {
    try {
      await _apiClient.dio.delete('${ApiEndpoints.agenda}/$eventId');
    } on DioException catch (e) {
      throw Exception('Erreur lors de la suppression');
    }
  }
}