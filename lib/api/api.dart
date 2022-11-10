import 'package:todo_as_issue/api/opensource_platform.dart';

import '../parser/todo.dart';

class API {
  OpenSourcePlatform _openSourcePlatform;

  API(this._openSourcePlatform);

  set openSourcePlatform(OpenSourcePlatform openSourcePlatform) {
    _openSourcePlatform = openSourcePlatform;
  }

  void createIssues(
      List<Todo> todos, Map<String, dynamic> configuration) async {
    for (Todo todo in todos) {
      _openSourcePlatform.createIssue(todo, configuration);
    }
  }
}
