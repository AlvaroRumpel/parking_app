import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../exceptions/exception.dart';
import 'custom_client.dart';
import 'interceptor.dart';

class AuthInterceptor extends Interceptor {
  final CustomClient client;

  AuthInterceptor(this.client);

  @override
  Future<void> onRequest(http.BaseRequest request) async {
    final sp = await SharedPreferences.getInstance();
    final accessToken = sp.getString('accessToken');
    request.headers['Authorization'] = 'Bearer $accessToken';
  }

  @override
  Future<void> onResponse(http.StreamedResponse response) async {
    if (response.statusCode == 401 || response.statusCode == 403) {
     response = await _handle40x(response.request!);
    }
  }

  Future<http.StreamedResponse> _handle40x(http.BaseRequest request) async {
    final sp = await SharedPreferences.getInstance();
    final refreshToken = sp.getString('refreshToken');
    if (refreshToken == null) {
      throw UnauthorizedException();
    }

    final accessToken = sp.getString('accessToken');

    final refreshResponse = await client.inner.put(
      Uri.parse('${request.url.origin}/auth/refresh'),
      headers: {'authorization': 'Bearer $accessToken'},
      body: jsonEncode({'refresh_token': refreshToken}),
    );

    if (refreshResponse.statusCode == 200) {
      final newAccessToken = jsonDecode(refreshResponse.body)['access_token'];
      final newRefreshToken = jsonDecode(refreshResponse.body)['refresh_token'];

      sp.setString('accessToken', newAccessToken);
      sp.setString('refreshToken', newRefreshToken);

      request.headers['Authorization'] = 'Bearer $newAccessToken';
      final newResponse = await client.send(request);
      return newResponse;
    }

    throw UnauthorizedException();
  }
}
