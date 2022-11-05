import 'dart:io';
import 'package:todo_as_issue/lexer/lexer.dart';

void main(List<String> args) async {
  File file = File('examples/todo.txt');
  String content = await file.readAsString();
  Lexer lexer = Lexer(content);
}
