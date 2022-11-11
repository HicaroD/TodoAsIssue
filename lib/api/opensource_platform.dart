import 'package:todo_as_issue/utils/configuration.dart';

import '../parser/todo.dart';

abstract class OpenSourcePlatform {
  void createIssue(Todo todo, Configuration configuration);
}
