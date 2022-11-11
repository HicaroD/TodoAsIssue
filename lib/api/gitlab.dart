import 'package:todo_as_issue/api/opensource_platform.dart';
import 'package:todo_as_issue/parser/todo.dart';
import 'package:todo_as_issue/utils/configuration.dart';

class GitLab extends OpenSourcePlatform {
  GitLab._internal();
  static final GitLab _singleton = GitLab._internal();
  static get instance => _singleton;

  @override
  void createIssue(Todo todo, Configuration configuration) {
    // TODO: implement createIssue
  }
}
