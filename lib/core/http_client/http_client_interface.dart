abstract class IHttpClient {
  Future<HttpResponse> get(
    String url, {
    required Map<String, dynamic> headers,
    Map<String, String>? queryParameters,
  });
  Future<HttpResponse> post(
    String url, {
    required Map<String, dynamic> headers,
    required Map<String, dynamic> body,
    Map<String, String>? queryParameters,
  });
  Future<HttpResponse> put(
    String url, {
    required Map<String, dynamic> body,
    required Map<String, dynamic> headers,
    Map<String, String>? queryParameters,
  });
}

class HttpResponse {
  Map<String, dynamic> body;
  int statusCode;

  HttpResponse({
    required this.body,
    required this.statusCode,
  });
}
