import 'dart:convert';

class AuthDto {
  final String accessToken;
  final String refreshToken;

  AuthDto({
    required this.accessToken,
    required this.refreshToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }

  factory AuthDto.fromMap(Map<String, dynamic> map) {
    return AuthDto(
      accessToken: map['access_token'] ?? '',
      refreshToken: map['refresh_token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthDto.fromJson(String source) =>
      AuthDto.fromMap(json.decode(source));
}
