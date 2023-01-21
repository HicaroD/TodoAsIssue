import 'dart:convert';

import 'opensource_platform.dart';
import '../parser/todo.dart';
import '../utils/configuration.dart';

import '../core/http_client/http_client_interface.dart';

class GitHub extends IOpenSourcePlatform {
  final IHttpClient httpClient;

  GitHub(this.httpClient);

  Map<String, String> getHeaders(Configuration configuration) {
    return {
      "accept": "application/vnd.github+json",
      "Authorization": "Bearer ${configuration.githubToken}",
      "Content-Type": "application/json"
    };
  }

  String getUrl(Configuration configuration) {
    return "/repos/${configuration.owner}/${configuration.repoNameGitHub}/issues";
  }

  Map<String, String> getBody(Todo todo) {
    Map<String, String> body = {
      "title": todo.title,
      "body": todo.body,
    };
    if (todo.labels.isNotEmpty) {
      body.putIfAbsent("labels", () => jsonEncode(todo.labels));
    }
    return body;
  }

  @override
  Future<HttpResponse> createIssue(
      Todo todo, Configuration configuration) async {
    String url = getUrl(configuration);
    Map<String, String> headers = getHeaders(configuration);
    Map<String, String> body = getBody(todo);

    HttpResponse response = await httpClient.post(
      url,
      headers: headers,
      body: body,
    );

    return response;
  }
}
