import '../core/http_client/http_status.dart';

import 'opensource_platform.dart';
import 'successful_status.dart';
import '../core/errors/api_exceptions.dart';
import '../core/http_client/http_client_interface.dart';

import '../parser/issue.dart';
import '../utils/configuration.dart';

class API {
  IOpenSourcePlatform _openSourcePlatform;

  API(this._openSourcePlatform);

  set openSourcePlatform(IOpenSourcePlatform openSourcePlatform) {
    _openSourcePlatform = openSourcePlatform;
  }

  Future<SuccessfulStatus> createIssues(
      List<Issue> issues, Configuration configuration) async {
    return SuccessfulStatus(await _createIssues(issues, configuration));
  }

  Future<int> _createIssues(
      List<Issue> issues, Configuration configuration) async {
    int issueCounter = 0;

    for (Issue issue in issues) {
      if (!isIssueAlreadyPosted(issue)) {
        HttpResponse response =
            await _openSourcePlatform.createIssue(issue, configuration);

        if (!isSuccessfulStatusCode(response.statusCode)) {
          handleErrorStatusCode(response);
        }

        issueCounter++;
        _sleep();
      }
    }
    return issueCounter;
  }

  void handleErrorStatusCode(HttpResponse response) {
    switch (response.statusCode) {
      case HttpStatus.UNAUTHORIZED:
      case HttpStatus.NOT_FOUND:
        throw InvalidCredentials(
          "Make sure your credentials from 'todo.json' are correct and valid.",
        );
      case HttpStatus.SERVICE_UNAVAILABLE:
        throw ServiceUnavaiable(
          "Service unavaiable. Please try again later. \n\nMessage from API: ${response.body['message']}",
        );
      case HttpStatus.UNPROCESSABLE_ENTITY:
        throw SpammedCommand(
          "Validation failed or this command was probably spammed. \n\nMessage from API: ${response.body['message']}",
        );
      default:
        // TODO(hicaro): improving error reporting for this case
        throw UnexpectedError(response.body.toString());
    }
  }

  bool isSuccessfulStatusCode(HttpStatus statusCode) {
    return statusCode == HttpStatus.OK || statusCode == HttpStatus.CREATED;
  }

  bool isIssueAlreadyPosted(Issue issue) {
    return issue.wasPosted;
  }

  Future<void> _sleep() {
    return Future.delayed(Duration(seconds: 1));
  }
}
