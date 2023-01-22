import 'dart:convert';

import 'opensource_platform.dart';
import '../parser/issue.dart';
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

  Map<String, dynamic> getBody(Issue issue) {
    Map<String, dynamic> body = {
      "title": issue.title,
      "body": issue.body,
      "labels": issue.labels,
    };
    return body;
  }

  @override
  Future<HttpResponse> createIssue(
      Issue issue, Configuration configuration) async {
    String url = getUrl(configuration);
    Map<String, String> headers = getHeaders(configuration);
    Map<String, dynamic> body = getBody(issue);

    HttpResponse response = await httpClient.post(
      url,
      headers: headers,
      body: body,
    );

    return response;
  }
}
