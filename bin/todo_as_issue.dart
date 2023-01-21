import 'dart:io';

import 'package:todo_as_issue/api/api.dart';
import 'package:todo_as_issue/api/github.dart';
import 'package:todo_as_issue/api/gitlab.dart';
import 'package:todo_as_issue/api/opensource_platform.dart';
import 'package:todo_as_issue/core/errors/api_exceptions.dart';
import 'package:todo_as_issue/core/errors/parser_exceptions.dart';
import 'package:todo_as_issue/core/http_client/http_client.dart';
import 'package:todo_as_issue/core/http_client/http_client_interface.dart';
import 'package:todo_as_issue/lexer/lexer.dart';
import 'package:todo_as_issue/lexer/tokens.dart';
import 'package:todo_as_issue/parser/parser.dart';
import 'package:todo_as_issue/parser/todo.dart';
import 'package:todo_as_issue/utils/configuration.dart';
import 'package:todo_as_issue/utils/endpoints.dart';
import 'package:todo_as_issue/utils/reader.dart';

class TodoAsIssue {
  late Lexer lexer;
  late Parser parser;
  late API api;
  final Configuration configuration;
  final String todoFile;
  final IOpenSourcePlatform openSourcePlatform;

  TodoAsIssue({
    required this.todoFile,
    required this.configuration,
    required this.openSourcePlatform,
  });

  void run() async {
    try {
      lexer = Lexer(todoFile);
      List<Token> tokens = lexer.tokenize();
      parser = Parser(tokens);
      List<Todo> todos = parser.parse();

      API api = API(openSourcePlatform);
      final successfulMessage = await api.createIssues(todos, configuration);
      successfulMessage.showSuccessfulMessage();
    } on InvalidCredentials catch (e) {
      print(e.message);
    } on ServiceUnavaiable catch (e) {
      print(e.message);
    } on SpammedCommand catch (e) {
      print(e.message);
    } on UnexpectedError catch (e) {
      print(e.message);
    } on UnexpectedToken catch (e) {
      print("Unexpected token: '${e.token}'");
    }
  }
}

IOpenSourcePlatform getOpenSourcePlatform(Configuration configuration) {
  IHttpClient httpClient = HttpClient(baseUrl: GITHUB_BASE_URL);
  IOpenSourcePlatform openSourcePlatform = GitHub(httpClient);

  if (configuration.platform == "gitlab") {
    httpClient = HttpClient(baseUrl: GITLAB_BASE_URL);
    openSourcePlatform = GitLab(httpClient);
  } else if (configuration.platform != "github") {
    print("Unsupported platform '${configuration.platform}'");
    exit(1);
  }
  return openSourcePlatform;
}

void main(List<String> args) async {
  String todoFile = await Reader.getTodoFile();
  Map<String, dynamic> configAsJson = await Reader.getConfigFile();

  Configuration configuration = Configuration.fromJson(configAsJson);
  IOpenSourcePlatform openSourcePlatform = getOpenSourcePlatform(configuration);

  TodoAsIssue todoAsIssue = TodoAsIssue(
    todoFile: todoFile,
    configuration: configuration,
    openSourcePlatform: openSourcePlatform,
  );

  todoAsIssue.run();
}
