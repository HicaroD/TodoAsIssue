import 'dart:convert';
import 'dart:io';
import 'package:todo_as_issue/lexer/lexer.dart';
import 'package:todo_as_issue/lexer/tokens.dart';
import 'package:todo_as_issue/parser/parser.dart';
import 'package:todo_as_issue/parser/todo.dart';

Future<Map<String, dynamic>> getConfigFile() async {
  String path = 'todo.json';
  File jsonFile = File(path);

  if (!await jsonFile.exists()) {
    print(
        "ERROR: Configuration file 'todo.json' not found on project root folder");
    exit(1);
  }
  Map<String, dynamic> jsonDecoded = jsonDecode(await jsonFile.readAsString());
  return jsonDecoded;
}

Future<String> getTodoFile(String filePath) async {
  File todoFile = File(filePath);
  if (!await todoFile.exists()) {
    print("ERROR: 'todo.txt' not found");
    exit(1);
  }
  String content = await todoFile.readAsString();
  return content;
}

void main(List<String> args) async {
  File file = File('examples/todo.txt');
  String content = await file.readAsString();

  Lexer lexer = Lexer(content);
  List<Token> tokens = lexer.tokenize();

  Parser parser = Parser(tokens);
  List<Todo> todos = parser.parse();
}
