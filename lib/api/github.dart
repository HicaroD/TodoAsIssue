import 'package:todo_as_issue/api/opensource_platform.dart';
import 'package:todo_as_issue/core/http_client/http_client.dart';
import 'package:todo_as_issue/parser/todo.dart';
import 'package:todo_as_issue/utils/configuration.dart';
import 'package:todo_as_issue/utils/endpoints.dart';

import '../core/http_client/http_client_interface.dart';

class GitHub extends IOpenSourcePlatform {
  GitHub._internal();
  static final GitHub _singleton = GitHub._internal();

  factory GitHub() {
    return _singleton;
  }

  final HttpClient _httpClient = HttpClient(baseUrl: GITHUB_BASE_URL);

  Map<String, String> getHeaders(Configuration configuration) {
    return {
      "accept": "application/vnd.github+json",
      "Authorization": "Bearer ${configuration.githubToken}"
    };
  }

  @override
  Future<HttpResponse> createIssue(
      Todo todo, Configuration configuration) async {
    String url =
        "/repos/${configuration.owner}/${configuration.repoNameGitHub}/issues";

    Map<String, String> headers = getHeaders(configuration);

    Map<String, String> body = {
      "title": todo.title,
    };

    HttpResponse response = await _httpClient.post(
      url,
      headers: headers,
      body: body,
    );

    return response;
  }
}
