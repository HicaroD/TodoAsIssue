import 'dart:io';
import 'package:todo_as_issue/lexer/lexer.dart';
import 'package:todo_as_issue/lexer/tokens.dart';
import 'package:todo_as_issue/parser/parser.dart';
import 'package:todo_as_issue/parser/todo.dart';

void main(List<String> args) async {
  File file = File('examples/todo.txt');
  String content = await file.readAsString();

  Lexer lexer = Lexer(content);
  List<Token> tokens = lexer.tokenize();

  Parser parser = Parser(tokens);
  List<Todo> todos = parser.parse();
}
