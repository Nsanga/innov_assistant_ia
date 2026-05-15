import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final Map<String, dynamic> user;

  const LoginResponse({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access_token'] ?? '',
      tokenType: json['token_type'] ?? 'bearer',
      expiresIn: json['expires_in'] as int? ?? 86400,
      user: json['user'] as Map<String, dynamic>? ?? {},
    );
  }

  @override
  List<Object?> get props => [accessToken, tokenType, expiresIn, user];
}