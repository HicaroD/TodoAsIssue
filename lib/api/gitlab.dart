import 'package:todo_as_issue/api/opensource_platform.dart';
import 'package:todo_as_issue/core/http_client/http_client_interface.dart';
import 'package:todo_as_issue/parser/todo.dart';
import 'package:todo_as_issue/utils/configuration.dart';

class GitLab extends OpenSourcePlatform {
  GitLab._internal();
  static final GitLab _singleton = GitLab._internal();

  factory GitLab() {
    return _singleton;
  }

  @override
  Future<HttpResponse> createIssue(
      Todo todo, Configuration configuration) async {
    throw Exception();
  }
}
