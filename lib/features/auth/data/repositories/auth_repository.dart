import 'package:dio/dio.dart';
import 'package:mobile_assistant_ia/core/di/injection.dart';
import 'package:mobile_assistant_ia/services/api/api_client.dart';
import 'package:mobile_assistant_ia/services/api/api_endpoints.dart';
import 'package:mobile_assistant_ia/services/storage/secure_storage.dart';
import '../models/login_response.dart';
import '../models/user_model.dart';

class AuthRepository {
  final ApiClient _apiClient;
  final SecureStorage _storage;

  AuthRepository(this._apiClient) : _storage = getIt<SecureStorage>();

  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _apiClient.dio.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );

      final loginResponse = LoginResponse.fromJson(response.data);

      // Sauvegarder le token
      await _storage.write('access_token', loginResponse.accessToken);

      // Créer l'utilisateur à partir de la réponse de login
      // car elle contient déjà les infos utilisateur
      final user = UserModel.fromJson({
        ...loginResponse.user,
        'token': loginResponse.accessToken,
      });

      return user;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?['detail']?.toString() ?? 
        e.response?.data?['message']?.toString() ?? 
        'Erreur de connexion'
      );
    }
  }

  Future<UserModel> getCurrentUser() async {
    try {
      final response = await _apiClient.dio.get(ApiEndpoints.me);
      
      // Récupérer le token stocké
      final token = await _storage.read('access_token');
      
      return UserModel.fromJson({
        ...response.data,
        'token': token,
      });
    } on DioException catch (e) {
      throw Exception('Impossible de récupérer les informations utilisateur');
    }
  }

  Future<void> logout() async {
    await _storage.delete('access_token');
  }
}