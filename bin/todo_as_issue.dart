import 'dart:io';
import 'package:todo_as_issue/api/api.dart';
import 'package:todo_as_issue/api/github.dart';
import 'package:todo_as_issue/api/gitlab.dart';
import 'package:todo_as_issue/api/opensource_platform.dart';
import 'package:todo_as_issue/lexer/lexer.dart';
import 'package:todo_as_issue/lexer/tokens.dart';
import 'package:todo_as_issue/parser/parser.dart';
import 'package:todo_as_issue/parser/todo.dart';
import 'package:todo_as_issue/utils/configuration.dart';
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
    lexer = Lexer(todoFile);
    List<Token> tokens = lexer.tokenize();
    parser = Parser(tokens);
    List<Todo> todos = parser.parse();

    API api = API(openSourcePlatform);

    api.createIssues(todos, configuration);
  }
}

IOpenSourcePlatform getOpenSourcePlatform(Configuration configuration) {
  IOpenSourcePlatform openSourcePlatform = GitHub();
  if (configuration.platform == "gitlab") {
    openSourcePlatform = GitLab();
  } else if (configuration.platform != "github") {
    print("Unsupported platform '${configuration.platform}'");
    exit(1);
  }
  return openSourcePlatform;
}

void main(List<String> args) async {
  String todoFile = await Reader.getTodoFile("todo.txt");
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
