import 'dart:convert';
import 'package:http/http.dart' as http;
import 'http_client_interface.dart';

class HttpClient implements IHttpClient {
  final http.Client client = http.Client();
  final String baseUrl;

  HttpClient({required this.baseUrl});

  @override
  Future<HttpResponse> get(
    String url, {
    required Map<String, dynamic> headers,
    Map<String, String>? queryParameters,
  }) async {
    Uri uri = Uri(
      scheme: "https",
      host: baseUrl,
      path: url,
      queryParameters: queryParameters ?? {},
    );
    http.Response response =
        await http.get(uri, headers: headers as Map<String, String>);
    return HttpResponse(
        body: json.decode(response.body), statusCode: response.statusCode);
  }

  @override
  Future<HttpResponse> post(String url,
      {required Map<String, dynamic> headers,
      required Map<String, dynamic> body,
      Map<String, String>? queryParameters}) async {
    Uri uri = Uri(
      scheme: "https",
      host: baseUrl,
      path: url,
      queryParameters: queryParameters ?? {},
    );
    http.Response response = await http.post(uri,
        body: jsonEncode(body), headers: headers as Map<String, String>);
    return HttpResponse(
        body: json.decode(response.body), statusCode: response.statusCode);
  }

  @override
  Future<HttpResponse> put(
    String url, {
    required Map<String, dynamic> headers,
    required Map<String, dynamic> body,
    Map<String, String>? queryParameters,
  }) async {
    Uri uri = Uri(
      scheme: "https",
      host: baseUrl,
      path: url,
      queryParameters: queryParameters ?? {},
    );
    http.Response response = await http.put(uri,
        headers: headers as Map<String, String>, body: body);
    return HttpResponse(
        body: json.decode(response.body), statusCode: response.statusCode);
  }
}
