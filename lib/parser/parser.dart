import 'package:todo_as_issue/core/errors/parser_exceptions.dart';
import 'package:todo_as_issue/lexer/tokens.dart';
import 'package:todo_as_issue/parser/todo.dart';

class TokenIterator implements Iterator {
  final List<Token> tokens;
  int cursor = 0;

  TokenIterator(this.tokens);

  @override
  get current => tokens[cursor];

  @override
  bool moveNext() {
    if (hasNext()) {
      cursor++;
      return true;
    } else {
      return false;
    }
  }

  bool hasNext() {
    return cursor < tokens.length - 1;
  }
}

class Parser {
  final List<Token> tokens;

  Parser(this.tokens);

  List<Todo> parse() {
    List<Todo> todos = [];
    TokenIterator iterator = TokenIterator(tokens);

    while (iterator.hasNext()) {
      throwErrorIfDoesntMatch(iterator, TokenKind.openingSquareBracket);
      iterator.moveNext();

      bool wasPosted = false;
      if (match(iterator, TokenKind.tilde)) {
        wasPosted = true;
        iterator.moveNext();
      }

      throwErrorIfDoesntMatch(iterator, TokenKind.closingSquareBracket);
      iterator.moveNext();

      throwErrorIfDoesntMatch(iterator, TokenKind.colon);
      iterator.moveNext();

      throwErrorIfDoesntMatch(iterator, TokenKind.issueText);
      String issueTitle = iterator.current.lexeme;
      iterator.moveNext();

      String issueBodyText = "";
      if (match(iterator, TokenKind.issueText)) {
        issueBodyText = iterator.current.lexeme;
        iterator.moveNext();
      }
      throwErrorIfDoesntMatch(iterator, TokenKind.semicolon);

      if (iterator.hasNext()) iterator.moveNext();

      final todo =
          Todo(wasPosted: wasPosted, title: issueTitle, body: issueBodyText);
      todos.add(todo);
    }
    return todos;
  }

  void throwErrorIfDoesntMatch(TokenIterator iterator, TokenKind expected) {
    if (iterator.current.kind != expected) {
      throw UnexpectedToken(iterator.current.toString());
    }
  }

  bool match(TokenIterator iterator, TokenKind expected) {
    return iterator.current.kind == expected;
  }
}
