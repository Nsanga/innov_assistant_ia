import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  static String get baseUrl {
    final url = dotenv.env['API_BASE_URL'];
    if (url == null || url.isEmpty) {
      return 'https://api-assistant-ia.horus-lab.com'; // fallback
    }
    return url;
  }

  static const String login = '/auth/login';
  static const String me = '/users/me';
  static const String chat = '/agent/chat';
  static const String agenda = '/agenda';

  // Méthode helper pour construire les URLs complètes
  static String getFullUrl(String endpoint) {
    return baseUrl + endpoint;
  }
}