import 'package:dio/dio.dart';
import 'package:mobile_assistant_ia/services/api/api_client.dart';
import 'package:mobile_assistant_ia/services/api/api_endpoints.dart';
import '../models/chat_message.dart';

class ChatRepository {
  final ApiClient _apiClient;
  String? _currentSessionId;

  ChatRepository(this._apiClient);

  Future<ChatMessage> sendMessage(String message) async {
    try {
      final response = await _apiClient.dio.post(
        ApiEndpoints.chat,
        data: {
          "session_id": _currentSessionId,
          "message": message,
        },
      );

      final data = response.data;
      _currentSessionId = data['session_id'];

      return ChatMessage.fromJson(data);
    } on DioException catch (e) {
      throw Exception(e.response?.data?['detail']?.toString() ?? 'Erreur lors de l\'envoi');
    }
  }

  void resetSession() {
    _currentSessionId = null;
  }
}