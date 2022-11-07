import 'package:todo_as_issue/lexer/tokens.dart';
import 'package:todo_as_issue/parser/todo.dart';

class TokenIterator implements Iterator {
  final List<Token> tokens;
  int currentPosition = 0;

  TokenIterator(this.tokens);

  @override
  get current => tokens[currentPosition];

  @override
  bool moveNext() {
    if (hasNext()) {
      currentPosition++;
      return true;
    } else {
      return false;
    }
  }

  bool hasNext() {
    return currentPosition < tokens.length;
  }
}

class Parser {
  final List<Token> tokens;

  Parser(this.tokens);

  List<Todo> parse() {
    List<Todo> todos = [];
    TokenIterator tokenIterator = TokenIterator(tokens);

    while (tokenIterator.hasNext()) {
      Token currentToken = tokenIterator.current;
      print(currentToken);
      tokenIterator.moveNext();
    }
    return todos;
  }
}
