import '../parser/todo.dart';

abstract class OpenSourcePlatform {
  void createIssue(Todo todo, Map<String, dynamic> configuration);
}
