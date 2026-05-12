import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  final String accessToken;
  final String tokenType;
  final String email;

  const LoginResponse({
    required this.accessToken,
    required this.tokenType,
    required this.email,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access_token'] ?? '',
      tokenType: json['token_type'] ?? 'bearer',
      email: json['email'] ?? '',
    );
  }

  @override
  List<Object?> get props => [accessToken, tokenType, email];
}