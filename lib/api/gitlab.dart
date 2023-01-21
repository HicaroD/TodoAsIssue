import 'opensource_platform.dart';
import '../core/http_client/http_client_interface.dart';
import '../parser/todo.dart';
import '../utils/configuration.dart';

class GitLab extends IOpenSourcePlatform {
  final IHttpClient httpClient;

  GitLab(this.httpClient);

  Map<String, String> getHeaders(Configuration configuration) {
    return {
      "PRIVATE-TOKEN": configuration.gitlabToken,
      "Content-Type": "application/json",
    };
  }

  String getUrl(Configuration configuration) {
    return "api/v4/projects/${configuration.repoIdGitlab}/issues";
  }

  @override
  Future<HttpResponse> createIssue(
      Todo todo, Configuration configuration) async {
    String url = getUrl(configuration);
    Map<String, String> headers = getHeaders(configuration);
    Map<String, String> queryParameters = {
      "title": todo.title,
      "description": todo.body,
      "labels": todo.labels.join(","),
    };
    HttpResponse response = await httpClient.post(
      url,
      headers: headers,
      body: {},
      queryParameters: queryParameters,
    );
    return response;
  }
}
