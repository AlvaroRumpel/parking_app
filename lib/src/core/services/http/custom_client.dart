import 'package:http/http.dart' as http;

import 'interceptor.dart';

class CustomClient extends http.BaseClient {
  final http.Client _inner;
  final List<Interceptor> _interceptors;

  CustomClient(this._inner, this._interceptors);

  http.Client get inner => _inner;

  void addInterceptor(Interceptor interceptor) =>
      _interceptors.add(interceptor);

  void removeInterceptor(Interceptor interceptor) =>
      _interceptors.remove(interceptor);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    for (var interceptor in _interceptors) {
      await interceptor.onRequest(request);
    }

    final response = await _inner.send(request);

    for (var interceptor in _interceptors) {
      await interceptor.onResponse(response);
    }

    return response;
  }
}
