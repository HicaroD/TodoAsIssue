import 'package:todo_as_issue/api/opensource_platform.dart';
import 'package:todo_as_issue/parser/todo.dart';

class GitLab extends OpenSourcePlatform {
  GitLab._internal();
  static final GitLab _singleton = GitLab._internal();
  static get inst => _singleton;

  @override
  void createIssue(Todo todo, Map<String, dynamic> configuration) {
    // TODO: implement createIssue
  }
}
