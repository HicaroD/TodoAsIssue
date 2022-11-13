import 'dart:io';

import 'package:todo_as_issue/api/opensource_platform.dart';
import 'package:todo_as_issue/core/http_client/http_client_interface.dart';

import '../parser/todo.dart';
import '../utils/configuration.dart';

class API {
  OpenSourcePlatform _openSourcePlatform;

  API(this._openSourcePlatform);

  set openSourcePlatform(OpenSourcePlatform openSourcePlatform) {
    _openSourcePlatform = openSourcePlatform;
  }

  void createIssues(List<Todo> todos, Configuration configuration) async {
    for (Todo todo in todos) {
      if (!todo.wasPosted) {
        HttpResponse response =
            await _openSourcePlatform.createIssue(todo, configuration);

        if (response.statusCode != 201) {
          print("Error: Can't create issue");
          print(response.statusCode);
          print(response.body);
          exit(1);
        }
        print("🎉 Issue was created successfully 🎉");
      }
    }
    // This is useful for avoiding problems with GitHub's rate limit policies
    sleep(Duration(seconds: 2));
  }
}
