import 'package:todo_as_issue/api/opensource_platform.dart';
import 'package:todo_as_issue/parser/todo.dart';

class GitHub extends OpenSourcePlatform {
  GitHub._internal();
  static final GitHub _singleton = GitHub._internal();
  static get inst => _singleton;

  @override
  void createIssue(Todo todo) {
    // TODO: implement createIssue
  }
}
