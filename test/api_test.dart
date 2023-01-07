import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_as_issue/api/api.dart';
import 'package:todo_as_issue/api/github.dart';
import 'package:todo_as_issue/api/gitlab.dart';
import 'package:todo_as_issue/api/successful_status.dart';
import 'package:todo_as_issue/core/errors/api_exceptions.dart';
import 'package:todo_as_issue/core/http_client/http_client.dart';
import 'package:todo_as_issue/core/http_client/http_client_interface.dart';
import 'package:todo_as_issue/utils/configuration.dart';

import 'mocks/configuration_mock.dart';
import 'mocks/todo_mocks.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late HttpClientMock httpClientMock;
  late GitHub openSourcePlatform;
  late String url;
  late API api;

  setUp(() {
    httpClientMock = HttpClientMock();
    openSourcePlatform = GitHub(httpClientMock);
    url = "/repos/USER/REPOSITORY/issues";
    api = API(openSourcePlatform);
  });

  test("should be a successful message when HTTP status is 201", () async {
    when(() => httpClientMock.post(
          url,
          headers: any(named: "headers"),
          body: any(named: "body"),
        )).thenAnswer((_) async => HttpResponse(body: {}, statusCode: 201));

    final issues =
        await api.createIssues(TODOS_MOCK, GITHUB_CONFIGURATION_MOCK);
    expect(issues, isA<SuccessfulStatus>());

    verify((() => httpClientMock.post(url,
        headers: any(named: "headers"),
        body: any(named: "body")))).called(TODOS_MOCK.length);
  });

  test("should throw InvalidCredentials exception when HTTP status is 401",
      () async {
    when(() => httpClientMock.post(
          url,
          headers: any(named: "headers"),
          body: any(named: "body"),
        )).thenAnswer((_) async => HttpResponse(body: {}, statusCode: 401));

    expect(
      () async => api.createIssues(TODOS_MOCK, GITHUB_CONFIGURATION_MOCK),
      throwsA(isA<InvalidCredentials>()),
    );

    verify((() => httpClientMock.post(url,
        headers: any(named: "headers"), body: any(named: "body")))).called(1);
  });

  test("should throw InvalidCredentials exception when HTTP status is 404",
      () async {
    when(() => httpClientMock.post(
          url,
          headers: any(named: "headers"),
          body: any(named: "body"),
        )).thenAnswer((_) async => HttpResponse(body: {}, statusCode: 404));

    expect(
      () async => api.createIssues(TODOS_MOCK, GITHUB_CONFIGURATION_MOCK),
      throwsA(isA<InvalidCredentials>()),
    );

    verify((() => httpClientMock.post(url,
        headers: any(named: "headers"), body: any(named: "body")))).called(1);
  });

  test("should throw ServiceUnavaiable exception when HTTP status is 503",
      () async {
    when(() => httpClientMock.post(
          url,
          headers: any(named: "headers"),
          body: any(named: "body"),
        )).thenAnswer((_) async => HttpResponse(body: {}, statusCode: 503));

    expect(
      () async => api.createIssues(TODOS_MOCK, GITHUB_CONFIGURATION_MOCK),
      throwsA(isA<ServiceUnavaiable>()),
    );

    verify((() => httpClientMock.post(url,
        headers: any(named: "headers"), body: any(named: "body")))).called(1);
  });

  test("should throw SpammedCommand exception when HTTP status is 422",
      () async {
    when(() => httpClientMock.post(
          url,
          headers: any(named: "headers"),
          body: any(named: "body"),
        )).thenAnswer((_) async => HttpResponse(body: {}, statusCode: 422));

    expect(
      () async => api.createIssues(TODOS_MOCK, GITHUB_CONFIGURATION_MOCK),
      throwsA(isA<SpammedCommand>()),
    );

    verify((() => httpClientMock.post(url,
        headers: any(named: "headers"), body: any(named: "body")))).called(1);
  });

  test(
      "should throw UnexpectedError exception when HTTP status is not 401, 404, 503 ou 422.",
      () async {
    when(() => httpClientMock.post(
          url,
          headers: any(named: "headers"),
          body: any(named: "body"),
        )).thenAnswer((_) async => HttpResponse(body: {}, statusCode: 504));

    expect(
      () async => api.createIssues(TODOS_MOCK, GITHUB_CONFIGURATION_MOCK),
      throwsA(isA<UnexpectedError>()),
    );

    verify((() => httpClientMock.post(url,
        headers: any(named: "headers"), body: any(named: "body")))).called(1);
  });
}
