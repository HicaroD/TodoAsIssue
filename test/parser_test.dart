import 'package:test/test.dart';
import 'package:todo_as_issue/lexer/tokens.dart';
import 'package:todo_as_issue/parser/parser.dart';
import 'package:todo_as_issue/parser/todo.dart';

void main() {
  test("test single incompleted todo", () {
    final input = [
      Token(TokenKind.openingSquareBracket, '['),
      Token(TokenKind.closingSquareBracket, ']'),
      Token(TokenKind.colon, ":"),
      Token(TokenKind.issueName, "Issue name"),
      Token(TokenKind.semicolon, ";"),
    ];

    final parser = Parser(input);
    final todos = parser.parse();
    final expected = Todo(wasPosted: false, title: "Issue name");
    assert(todos.length == 1);
    assert_todo(todos[0], expected);
  });

  test("test single completed todo", () {
    final input = [
      Token(TokenKind.openingSquareBracket, '['),
      Token(TokenKind.tilde, '~'),
      Token(TokenKind.closingSquareBracket, ']'),
      Token(TokenKind.colon, ":"),
      Token(TokenKind.issueName, "Issue name"),
      Token(TokenKind.semicolon, ";"),
    ];

    final parser = Parser(input);
    final todos = parser.parse();
    final expected = Todo(wasPosted: true, title: "Issue name");
    assert(todos.length == 1);
    assert_todo(todos[0], expected);
  });

  test("test multiple todos", () {
    final input = [
      Token(TokenKind.openingSquareBracket, '['),
      Token(TokenKind.tilde, '~'),
      Token(TokenKind.closingSquareBracket, ']'),
      Token(TokenKind.colon, ":"),
      Token(TokenKind.issueName, "My first completed TODO"),
      Token(TokenKind.semicolon, ";"),
      Token(TokenKind.openingSquareBracket, '['),
      Token(TokenKind.closingSquareBracket, ']'),
      Token(TokenKind.colon, ":"),
      Token(TokenKind.issueName, "My second TODO"),
      Token(TokenKind.semicolon, ";"),
      Token(TokenKind.openingSquareBracket, '['),
      Token(TokenKind.closingSquareBracket, ']'),
      Token(TokenKind.colon, ":"),
      Token(TokenKind.issueName, "My last TODO"),
      Token(TokenKind.semicolon, ";"),
    ];

    final parser = Parser(input);
    final todos = parser.parse();
    final expected = [
      Todo(wasPosted: true, title: "My first completed TODO"),
      Todo(wasPosted: false, title: "My second TODO"),
      Todo(wasPosted: false, title: "My last TODO"),
    ];
    assert(todos.length == expected.length);

    for (int i = 0; i < todos.length; i++) {
      assert_todo(todos[i], expected[i]);
    }
  });
}

void assert_todo(Todo result, Todo expected) {
  assert(result.title == expected.title);
  assert(result.wasPosted == expected.wasPosted);
}
