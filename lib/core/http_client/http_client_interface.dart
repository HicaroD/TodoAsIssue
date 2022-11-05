abstract class IHttpClient {
  Future<HttpResponse> get(String url, {required Map<String, dynamic> headers});
  Future<HttpResponse> post(String url,
      {required Map<String, dynamic> headers,
      required Map<String, dynamic> body});
  Future<HttpResponse> put(String url,
      {required Map<String, dynamic> body,
      required Map<String, dynamic> headers});
}

class HttpResponse {
  Map<String, dynamic> body;
  int statusCode;

  HttpResponse({
    required this.body,
    required this.statusCode,
  });
}
