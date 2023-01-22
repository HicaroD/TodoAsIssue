import '../core/http_client/http_client_interface.dart';
import '../utils/configuration.dart';

import '../parser/issue.dart';

abstract class IOpenSourcePlatform {
  Future<HttpResponse> createIssue(Issue issue, Configuration configuration);
}
