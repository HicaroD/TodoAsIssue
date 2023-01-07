import 'package:test/test.dart';
import 'package:todo_as_issue/core/errors/parser_exceptions.dart';
import 'package:todo_as_issue/lexer/tokens.dart';
import 'package:todo_as_issue/parser/parser.dart';
import 'package:todo_as_issue/parser/todo.dart';

void main() {
  test("should be a single valid TODO", () {
    final input = [
      Token(TokenKind.openingSquareBracket, '['),
      Token(TokenKind.closingSquareBracket, ']'),
      Token(TokenKind.colon, ":"),
      Token(TokenKind.issueText, "Issue name"),
      Token(TokenKind.semicolon, ";"),
    ];

    final parser = Parser(input);
    final todos = parser.parse();
    final expected = Todo(wasPosted: false, title: "Issue name", body: "");
    assert(todos.length == 1);
    assertTodo(todos[0], expected);
  });

  test("should throw UnexpectedToken exception for this single TODO", () {
    final input = [
      Token(TokenKind.openingSquareBracket, '['),
      Token(TokenKind.colon, ":"),
      Token(TokenKind.issueText, "Issue name"),
      Token(TokenKind.semicolon, ";"),
    ];
    final parser = Parser(input);
    expect(parser.parse, throwsA(isA<UnexpectedToken>()));
  });

  test("should be a valid incompleted TODO with body text", () {
    final input = [
      Token(TokenKind.openingSquareBracket, '['),
      Token(TokenKind.closingSquareBracket, ']'),
      Token(TokenKind.colon, ":"),
      Token(TokenKind.issueText, "Issue name"),
      Token(TokenKind.issueText, "My body text"),
      Token(TokenKind.semicolon, ";"),
    ];

    final parser = Parser(input);
    final todos = parser.parse();
    final expected =
        Todo(wasPosted: false, title: "Issue name", body: "My body text");
    assert(todos.length == 1);
    assertTodo(todos[0], expected);
  });

  test("should throw UnexpectedToken for invalid TODO - expected a colon", () {
    final input = [
      Token(TokenKind.openingSquareBracket, '['),
      Token(TokenKind.closingSquareBracket, ']'),
      Token(TokenKind.issueText, "Issue name"),
      Token(TokenKind.issueText, "My body text"),
      Token(TokenKind.semicolon, ";"),
    ];

    final parser = Parser(input);
    expect(parser.parse, throwsA(isA<UnexpectedToken>()));
  });

  test("should be a valid completed TODO", () {
    final input = [
      Token(TokenKind.openingSquareBracket, '['),
      Token(TokenKind.tilde, '~'),
      Token(TokenKind.closingSquareBracket, ']'),
      Token(TokenKind.colon, ":"),
      Token(TokenKind.issueText, "Issue name"),
      Token(TokenKind.semicolon, ";"),
    ];

    final parser = Parser(input);
    final todos = parser.parse();
    final expected = Todo(wasPosted: true, title: "Issue name", body: "");
    assert(todos.length == 1);
    assertTodo(todos[0], expected);
  });

  test("should throw UnexpectedToken for invalid completed TODO - expected '['",
      () {
    final input = [
      Token(TokenKind.tilde, '~'),
      Token(TokenKind.closingSquareBracket, ']'),
      Token(TokenKind.colon, ":"),
      Token(TokenKind.issueText, "Issue name"),
      Token(TokenKind.semicolon, ";"),
    ];

    final parser = Parser(input);
    expect(parser.parse, throwsA(isA<UnexpectedToken>()));
  });

  test("should a valid completed TODO with body text", () {
    final input = [
      Token(TokenKind.openingSquareBracket, '['),
      Token(TokenKind.tilde, '~'),
      Token(TokenKind.closingSquareBracket, ']'),
      Token(TokenKind.colon, ":"),
      Token(TokenKind.issueText, "Issue name"),
      Token(TokenKind.issueText, "This is the best body text ever"),
      Token(TokenKind.semicolon, ";"),
    ];

    final parser = Parser(input);
    final todos = parser.parse();
    final expected = Todo(
      wasPosted: true,
      title: "Issue name",
      body: "This is the best body text ever",
    );
    assert(todos.length == 1);
    assertTodo(todos[0], expected);
  });

  test("should throw UnexpectedToken for invalid TODO - expected semicolon",
      () {
    final input = [
      Token(TokenKind.openingSquareBracket, '['),
      Token(TokenKind.tilde, '~'),
      Token(TokenKind.closingSquareBracket, ']'),
      Token(TokenKind.colon, ":"),
      Token(TokenKind.issueText, "Issue name"),
      Token(TokenKind.issueText, "This is the best body text ever"),
    ];

    final parser = Parser(input);
    expect(parser.parse, throwsA(isA<UnexpectedToken>()));
  });

  test("should be a valid list of TODOs with empty body text", () {
    final input = [
      Token(TokenKind.openingSquareBracket, '['),
      Token(TokenKind.tilde, '~'),
      Token(TokenKind.closingSquareBracket, ']'),
      Token(TokenKind.colon, ":"),
      Token(TokenKind.issueText, "My first completed TODO"),
      Token(TokenKind.semicolon, ";"),
      Token(TokenKind.openingSquareBracket, '['),
      Token(TokenKind.closingSquareBracket, ']'),
      Token(TokenKind.colon, ":"),
      Token(TokenKind.issueText, "My second TODO"),
      Token(TokenKind.semicolon, ";"),
      Token(TokenKind.openingSquareBracket, '['),
      Token(TokenKind.closingSquareBracket, ']'),
      Token(TokenKind.colon, ":"),
      Token(TokenKind.issueText, "My last TODO"),
      Token(TokenKind.semicolon, ";"),
    ];

    final parser = Parser(input);
    final todos = parser.parse();
    final expected = [
      Todo(wasPosted: true, title: "My first completed TODO", body: ""),
      Todo(wasPosted: false, title: "My second TODO", body: ""),
      Todo(wasPosted: false, title: "My last TODO", body: ""),
    ];
    assert(todos.length == expected.length);

    for (int i = 0; i < todos.length; i++) {
      assertTodo(todos[i], expected[i]);
    }
  });

  test("should be a valid list of TODOs with non-empty body text", () {
    final input = [
      Token(TokenKind.openingSquareBracket, '['),
      Token(TokenKind.tilde, '~'),
      Token(TokenKind.closingSquareBracket, ']'),
      Token(TokenKind.colon, ":"),
      Token(TokenKind.issueText, "My first completed TODO"),
      Token(TokenKind.issueText, "My first body text"),
      Token(TokenKind.semicolon, ";"),
      Token(TokenKind.openingSquareBracket, '['),
      Token(TokenKind.closingSquareBracket, ']'),
      Token(TokenKind.colon, ":"),
      Token(TokenKind.issueText, "My second TODO"),
      Token(TokenKind.issueText, "My second body text"),
      Token(TokenKind.semicolon, ";"),
      Token(TokenKind.openingSquareBracket, '['),
      Token(TokenKind.closingSquareBracket, ']'),
      Token(TokenKind.colon, ":"),
      Token(TokenKind.issueText, "My last TODO"),
      Token(TokenKind.issueText, "My last body text"),
      Token(TokenKind.semicolon, ";"),
    ];

    final parser = Parser(input);
    final todos = parser.parse();
    final expected = [
      Todo(
        wasPosted: true,
        title: "My first completed TODO",
        body: "My first body text",
      ),
      Todo(
        wasPosted: false,
        title: "My second TODO",
        body: "My second body text",
      ),
      Todo(
        wasPosted: false,
        title: "My last TODO",
        body: "My last body text",
      ),
    ];
    assert(todos.length == expected.length);

    for (int i = 0; i < todos.length; i++) {
      assertTodo(todos[i], expected[i]);
    }
  });
}

void assertTodo(Todo result, Todo expected) {
  assert(result.title == expected.title);
  assert(result.wasPosted == expected.wasPosted);
  assert(result.body == expected.body);
}
