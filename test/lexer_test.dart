import 'package:test/test.dart';
import 'package:todo_as_issue/lexer/lexer.dart';
import 'package:todo_as_issue/lexer/tokens.dart';

void main() {
  test("test single valid incompleted todo", () {
    final input = '[]: "This is my first TODO";';
    final lexer = Lexer(input);
    final result = lexer.tokenize();
    final expected = [
      TokenKind.openingSquareBracket,
      TokenKind.closingSquareBracket,
      TokenKind.colon,
      TokenKind.issueText,
      TokenKind.semicolon,
    ];

    assertTokens(result, expected);
  });

  test("test single valid incompleted todo with body text", () {
    final input = '[]: "This is my first TODO" "Some body text";';
    final lexer = Lexer(input);
    final result = lexer.tokenize();
    final expected = [
      TokenKind.openingSquareBracket,
      TokenKind.closingSquareBracket,
      TokenKind.colon,
      TokenKind.issueText,
      TokenKind.issueText,
      TokenKind.semicolon,
    ];

    assertTokens(result, expected);
  });

  test("test single valid completed todo", () {
    final input = '[~]: "This is my first TODO";';
    final lexer = Lexer(input);
    final result = lexer.tokenize();
    final expected = [
      TokenKind.openingSquareBracket,
      TokenKind.tilde,
      TokenKind.closingSquareBracket,
      TokenKind.colon,
      TokenKind.issueText,
      TokenKind.semicolon,
    ];

    assertTokens(result, expected);
  });

  test("test single valid completed todo with body text", () {
    final input = '[~]: "This is my first TODO" "Some body text";';
    final lexer = Lexer(input);
    final result = lexer.tokenize();
    final expected = [
      TokenKind.openingSquareBracket,
      TokenKind.tilde,
      TokenKind.closingSquareBracket,
      TokenKind.colon,
      TokenKind.issueText,
      TokenKind.issueText,
      TokenKind.semicolon,
    ];

    assertTokens(result, expected);
  });

  test(
      "test single valid completed todo with body text separated by new lines and whitespaces",
      () {
    final input = '[~]: "This is my first TODO"\t\n\n\t"Some body text";';
    final lexer = Lexer(input);
    final result = lexer.tokenize();
    final expected = [
      TokenKind.openingSquareBracket,
      TokenKind.tilde,
      TokenKind.closingSquareBracket,
      TokenKind.colon,
      TokenKind.issueText,
      TokenKind.issueText,
      TokenKind.semicolon,
    ];

    assertTokens(result, expected);
  });

  test("test multiple todos with new lines and spaces", () {
    final input =
        '\t[]:\t"This is my first TODO";\n[~]: "This is my second TODO";\t[~]:\t"This is my last TODO";\n';
    final lexer = Lexer(input);
    final result = lexer.tokenize();
    final expected = [
      TokenKind.openingSquareBracket,
      TokenKind.closingSquareBracket,
      TokenKind.colon,
      TokenKind.issueText,
      TokenKind.semicolon,
      TokenKind.openingSquareBracket,
      TokenKind.tilde,
      TokenKind.closingSquareBracket,
      TokenKind.colon,
      TokenKind.issueText,
      TokenKind.semicolon,
      TokenKind.openingSquareBracket,
      TokenKind.tilde,
      TokenKind.closingSquareBracket,
      TokenKind.colon,
      TokenKind.issueText,
      TokenKind.semicolon,
    ];
    assertTokens(result, expected);
  });

  test("test multiple todos with body text with new lines and whitespaces", () {
    final input = r'''[]: "This is my first TODO" "my first body text";
                      [~]: "This is my second TODO" 
                                            "my second body text"; 
                      [~]: "This is my last TODO"
                      "My last body text";
                      ''';
    final lexer = Lexer(input);
    final result = lexer.tokenize();
    final expected = [
      TokenKind.openingSquareBracket,
      TokenKind.closingSquareBracket,
      TokenKind.colon,
      TokenKind.issueText,
      TokenKind.issueText,
      TokenKind.semicolon,
      TokenKind.openingSquareBracket,
      TokenKind.tilde,
      TokenKind.closingSquareBracket,
      TokenKind.colon,
      TokenKind.issueText,
      TokenKind.issueText,
      TokenKind.semicolon,
      TokenKind.openingSquareBracket,
      TokenKind.tilde,
      TokenKind.closingSquareBracket,
      TokenKind.colon,
      TokenKind.issueText,
      TokenKind.issueText,
      TokenKind.semicolon,
    ];
    assertTokens(result, expected);
  });
}

void assertTokens(List<Token> result, List<TokenKind> expected) {
  assert(result.length == expected.length);
  for (int i = 0; i < result.length; i++) {
    expect(result[i].kind, expected[i]);
  }
}
