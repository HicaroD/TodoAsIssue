import 'package:todo_as_issue/lexer/tokens.dart';
import 'package:todo_as_issue/parser/todo.dart';

class Parser {
  final List<Token> tokens;

  Parser(this.tokens);

  List<Todo> parse() {
    List<Todo> todos = [];
    return todos;
  }
}
