import 'package:todo_as_issue/core/http_client/http_client_interface.dart';
import 'package:todo_as_issue/utils/configuration.dart';

import '../parser/todo.dart';

abstract class IOpenSourcePlatform {
  Future<HttpResponse> createIssue(Todo todo, Configuration configuration);
}
