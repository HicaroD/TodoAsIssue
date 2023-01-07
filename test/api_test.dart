import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_as_issue/api/api.dart';
import 'package:todo_as_issue/api/github.dart';
import 'package:todo_as_issue/api/gitlab.dart';
import 'package:todo_as_issue/api/successful_status.dart';
import 'package:todo_as_issue/core/http_client/http_client.dart';
import 'package:todo_as_issue/core/http_client/http_client_interface.dart';
import 'package:todo_as_issue/utils/configuration.dart';

import 'mocks/configuration_mock.dart';
import 'mocks/todo_mocks.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late HttpClientMock httpClientMock;
  late GitHub github;
  late GitLab gitlab;
  late String url;
  late API githubApi;
  late API gitlabApi;

  setUp(() {
    httpClientMock = HttpClientMock();
    github = GitHub(httpClientMock);
    gitlab = GitLab(httpClientMock);
    url = "/repos/USER/REPOSITORY/issues";
    githubApi = API(github);
    gitlabApi = API(gitlab);
  });

  test("should be a successful message when HTTP status is 201", () async {
    when(() => httpClientMock.post(
          url,
          headers: any(named: "headers"),
          body: any(named: "body"),
        )).thenAnswer((_) async => HttpResponse(body: {}, statusCode: 201));

    final issues =
        await githubApi.createIssues(TODOS_MOCK, GITHUB_CONFIGURATION_MOCK);
    expect(issues, isA<SuccessfulStatus>());

    verify((() => httpClientMock.post(url,
        headers: any(named: "headers"),
        body: any(named: "body")))).called(TODOS_MOCK.length);
  });
}
