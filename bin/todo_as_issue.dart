import 'dart:io';
import 'package:todo_as_issue/lexer/lexer.dart';
import 'package:todo_as_issue/lexer/tokens.dart';

void main(List<String> args) async {
  File file = File('examples/todo.txt');
  String content = await file.readAsString();
  Lexer lexer = Lexer(content);
  List<Token> tokens = lexer.tokenize();

  for (Token token in tokens) {
    print(token);
  }
}
