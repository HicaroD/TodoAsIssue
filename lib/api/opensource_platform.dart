import '../core/http_client/http_client_interface.dart';
import '../utils/configuration.dart';

import '../parser/todo.dart';

abstract class IOpenSourcePlatform {
  Future<HttpResponse> createIssue(Todo todo, Configuration configuration);
}
