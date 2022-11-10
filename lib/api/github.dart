import 'dart:io';

import 'package:todo_as_issue/api/opensource_platform.dart';
import 'package:todo_as_issue/core/http_client/http_client.dart';
import 'package:todo_as_issue/parser/todo.dart';
import 'package:todo_as_issue/utils/endpoints.dart';

import '../core/http_client/http_client_interface.dart';

class GitHub extends OpenSourcePlatform {
  GitHub._internal();
  static final GitHub _singleton = GitHub._internal();
  static get instance => _singleton;

  final HttpClient _httpClient = HttpClient(baseUrl: GITHUB_BASE_URL);

  @override
  void createIssue(Todo todo, Map<String, dynamic> configuration) async {
    String url =
        "/repos/${configuration["owner"]}/${configuration["repo_name"]}/issues";
    print(url);

    Map<String, String> headers = {
      "accept": "application/vnd.github+json",
      "Authorization": "Bearer ${configuration["token"]}"
    };

    Map<String, String> body = {
      "title": todo.title,
    };

    HttpResponse response =
        await _httpClient.post(url, headers: headers, body: body);

    if (response.statusCode != 201) {
      print(response.statusCode);
      print(response.body);
      print(
          "ERROR: Can't create an issue. Message from API: ${response.body["message"]}");
      exit(1);
    }
    print("🎉 Issue ${todo.id} was created successfully 🎉");
  }
}
