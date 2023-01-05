import 'dart:io';

import 'package:todo_as_issue/api/opensource_platform.dart';
import 'package:todo_as_issue/core/http_client/http_client_interface.dart';

import '../parser/todo.dart';
import '../utils/configuration.dart';

class API {
  IOpenSourcePlatform _openSourcePlatform;

  API(this._openSourcePlatform);

  set openSourcePlatform(IOpenSourcePlatform openSourcePlatform) {
    _openSourcePlatform = openSourcePlatform;
  }

  void createIssues(List<Todo> todos, Configuration configuration) async {
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
    showSuccessfulMessage(issueCounter);
  }

  void handleErrorStatusCode(HttpResponse response) {
    // TODO: refactor
    switch (response.statusCode) {
      case 401:
      case 404:
        {
          print(
              "Error: Check if your token and other credentials from 'todo.json' are correct and valid");
        }
        break;

      case 503:
        {
          print("Error: Service unavaiable. Try again later.");
        }
        break;

      case 422:
        {
          print("Error: this command has been spammed. Try again later.");
        }
        break;
    }
    exit(1);
  }

  void showSuccessfulMessage(int issueCounter) {
    if (issueCounter == 1) {
      print("🎉 A issue was created successfully 🎉");
    } else {
      print("🎉 $issueCounter issues were created successfully 🎉");
    }
  }
}
