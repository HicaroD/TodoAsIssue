import 'dart:convert';
import 'package:http/http.dart' as http;
import 'http_client_interface.dart';

class HttpClient implements IHttpClient {
  final http.Client client = http.Client();
  final String baseUrl;

  HttpClient({required this.baseUrl});

  @override
  Future<HttpResponse> get(String url,
      {required Map<String, dynamic> headers}) async {
    http.Response response = await http.get(Uri.https(baseUrl, url),
        headers: headers as Map<String, String>);
    return HttpResponse(
        body: json.decode(response.body), statusCode: response.statusCode);
  }

  @override
  Future<HttpResponse> post(String url,
      {required Map<String, dynamic> headers,
      required Map<String, dynamic> body}) async {
    http.Response response = await http.post(Uri.https(baseUrl, url),
        body: jsonEncode(body), headers: headers as Map<String, String>);
    return HttpResponse(
        body: json.decode(response.body), statusCode: response.statusCode);
  }

  @override
  Future<HttpResponse> put(String url,
      {required Map<String, dynamic> headers,
      required Map<String, dynamic> body}) async {
    http.Response response = await http.put(Uri.http(baseUrl, url),
        headers: headers as Map<String, String>, body: body);
    return HttpResponse(
        body: json.decode(response.body), statusCode: response.statusCode);
  }
}
