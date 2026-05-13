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

  Future<LoginResponse> login(String email, String password) async {
    try {
      final response = await _apiClient.dio.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );

      final loginResponse = LoginResponse.fromJson(response.data);

      await _storage.write('access_token', loginResponse.accessToken);

      return loginResponse;
    } on DioException catch (e) {
      throw Exception(e.response?.data?['detail']?.toString() ?? 'Erreur de connexion');
    }
  }

  Future<UserModel> getCurrentUser() async {
    try {
      final response = await _apiClient.dio.get(ApiEndpoints.me);
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Impossible de récupérer les informations utilisateur');
    }
  }

  Future<void> logout() async {
    await _storage.delete('access_token');
  }
}