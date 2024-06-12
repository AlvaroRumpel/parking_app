import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../exceptions/exception.dart';
import './http_service.dart';
import 'auth_interceptor.dart';
import 'custom_client.dart';

class HttpServiceImpl implements HttpService {
  final CustomClient _client;
  late final String _baseUrl;
  final _defaultTimeout = const Duration(seconds: 10);
  late final AuthInterceptor _authInterceptor;

  static final HttpServiceImpl _instance = HttpServiceImpl._();

  HttpServiceImpl._() : _client = CustomClient(http.Client(), []) {
    _baseUrl = const String.fromEnvironment('BASE_URL');
    _authInterceptor = AuthInterceptor(_client);
  }
  static HttpServiceImpl get i => _instance;

  @override
  HttpServiceImpl auth() {
    _client.addInterceptor(_authInterceptor);
    return this;
  }

  @override
  HttpServiceImpl unauth() {
    _client.removeInterceptor(_authInterceptor);
    return this;
  }

  @override
  Future<List<Map<String, dynamic>>> get(
    String url, {
    Duration? timeout,
  }) async {
    return _performRequest(() async {
      return await _client
          .get(Uri.parse('$_baseUrl/$url'))
          .timeout(timeout ?? _defaultTimeout);
    });
  }

  @override
  Future<List<Map<String, dynamic>>> delete(String url, int id) async {
    return _performRequest(() async {
      return await _client
          .delete(Uri.parse('$_baseUrl/$url/$id'))
          .timeout(_defaultTimeout);
    });
  }

  @override
  Future<List<Map<String, dynamic>>> post(
    String url,
    Map<String, dynamic> body,
  ) async {
    return _performRequest(() async {
      return await _client
          .post(Uri.parse('$_baseUrl/$url'), body: jsonEncode(body))
          .timeout(_defaultTimeout);
    });
  }

  @override
  Future<List<Map<String, dynamic>>> put(
    String url,
    int id,
    Map<String, dynamic> body,
  ) async {
    return _performRequest(() async {
      return await _client
          .put(Uri.parse('$_baseUrl/$url/$id'), body: jsonEncode(body))
          .timeout(_defaultTimeout);
    });
  }

  Future<List<Map<String, dynamic>>> _performRequest(
    Future<http.Response> Function() request,
  ) async {
    try {
      final response = await request();
      _handleResponse(response);

      final data = jsonDecode(response.body);

      if (data is List) {
        return data.map((e) => e as Map<String, dynamic>).toList();
      }

      if (data is Map<String, dynamic>) {
        return [data];
      }

      return jsonDecode(response.body);
    } catch (e) {
      if (e is TimeoutException) {
        log('Request timed out: $e');
        throw NetworkException('Request timed out: $e');
      }

      log('Request failed: $e');
      throw NetworkException('Request failed: $e');
    }
  }

  void _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        break;
      case 400:
        throw InvalidInputException(response.body);
      case 401:
        throw UnauthorizedException(response.body);
      case 404:
        throw RegisterNotFoundException(response.body);
      case 500:
      default:
        throw CustomException('${response.statusCode}', 'Server error: ');
    }
  }
}
