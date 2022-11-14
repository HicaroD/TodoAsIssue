import 'package:todo_as_issue/api/opensource_platform.dart';
import 'package:todo_as_issue/core/http_client/http_client.dart';
import 'package:todo_as_issue/core/http_client/http_client_interface.dart';
import 'package:todo_as_issue/parser/todo.dart';
import 'package:todo_as_issue/utils/configuration.dart';

class GitLab extends IOpenSourcePlatform {
  GitLab._internal();
  static final GitLab _singleton = GitLab._internal();

  factory GitLab() {
    return _singleton;
  }

  final HttpClient _httpClient = HttpClient(baseUrl: "gitlab.com");

  Map<String, String> getHeaders(Configuration configuration) {
    return {
      "PRIVATE-TOKEN": configuration.gitlabToken,
      "Content-Type": "application/json",
    };
  }

  @override
  Future<HttpResponse> createIssue(
      Todo todo, Configuration configuration) async {
    Map<String, String> headers = getHeaders(configuration);
    Map<String, String> queryParameters = {
      "title": todo.title,
    };
    String url = "api/v4/projects/${configuration.repoIdGitlab}/issues";
    HttpResponse response = await _httpClient.post(
      url,
      headers: headers,
      body: {},
      queryParameters: queryParameters,
    );
    return response;
  }
}
