import 'dart:io';

import 'opensource_platform.dart';
import 'successful_status.dart';
import '../core/errors/api_exceptions.dart';
import '../core/http_client/http_client_interface.dart';

import '../parser/todo.dart';
import '../utils/configuration.dart';

class API {
  IOpenSourcePlatform _openSourcePlatform;

  API(this._openSourcePlatform);

  set openSourcePlatform(IOpenSourcePlatform openSourcePlatform) {
    _openSourcePlatform = openSourcePlatform;
  }

  Future<SuccessfulStatus> createIssues(
      List<Todo> todos, Configuration configuration) async {
    int issueCounter = 0;

    for (Todo todo in todos) {
      if (!todo.wasPosted) {
        HttpResponse response =
            await _openSourcePlatform.createIssue(todo, configuration);

        if (response.statusCode != 201) handleErrorStatusCode(response);

        issueCounter++;
        sleep(Duration(seconds: 2));
      }
    }
    return SuccessfulStatus(issueCounter);
  }

  void handleErrorStatusCode(HttpResponse response) {
    switch (response.statusCode) {
      case 401:
      case 404:
        throw InvalidCredentials(
            "Make sure your credentials from 'todo.json' are correct and valid");
      case 503:
        throw ServiceUnavaiable("Service unavaiable. Please try again later.");
      case 422:
        throw SpammedCommand(
            "This command was probably spammed or you already made this pull request");
      default:
        // TODO(hicaro): improving error reporting for this case
        throw UnexpectedError(response.body.toString());
    }
  }
}
