import 'package:test/test.dart';
import 'package:todo_as_issue/lexer/lexer.dart';
import 'package:todo_as_issue/lexer/tokens.dart';

void main() {
  test("should be a valid incompleted TODO without body text", () {
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

  test("should be a valid incompleted TODO with body text", () {
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

  test("should be a valid completed TODO with empty body text", () {
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

  test("should a single valid completed TODO with body text", () {
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

  test("should be two valid TODOs even separated by new lines and whitespaces",
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

  test(
      "should be a valid list of TODOS with empty body text even with new lines and whitespaces",
      () {
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

  test(
      "should be a valid list of TODOs with body text even with a lot of whitespaces and new lines",
      () {
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

  test(
      "should be a valid incompleted TODO without body text and with one label",
      () {
    final input = '[]: "This is my first TODO" {"my-label-name"};';
    final lexer = Lexer(input);
    final result = lexer.tokenize();

    final expected = [
      TokenKind.openingSquareBracket,
      TokenKind.closingSquareBracket,
      TokenKind.colon,
      TokenKind.issueText,
      TokenKind.openingCurlyBrace,
      TokenKind.issueText,
      TokenKind.closingCurlyBrace,
      TokenKind.semicolon,
    ];

    assertTokens(result, expected);
  });

  test(
      "should be a valid incompleted TODO without body text and with two labels",
      () {
    final input =
        '[]: "This is my first TODO" {"my-label-name", "my-other-label-name"};';
    final lexer = Lexer(input);
    final result = lexer.tokenize();

    final expected = [
      TokenKind.openingSquareBracket,
      TokenKind.closingSquareBracket,
      TokenKind.colon,
      TokenKind.issueText,
      TokenKind.openingCurlyBrace,
      TokenKind.issueText,
      TokenKind.comma,
      TokenKind.issueText,
      TokenKind.closingCurlyBrace,
      TokenKind.semicolon,
    ];

    assertTokens(result, expected);
  });

  test(
      "should be a valid incompleted TODO without body text and with empty label list",
      () {
    final input = '[]: "This is my first TODO" {};';
    final lexer = Lexer(input);
    final result = lexer.tokenize();

    final expected = [
      TokenKind.openingSquareBracket,
      TokenKind.closingSquareBracket,
      TokenKind.colon,
      TokenKind.issueText,
      TokenKind.openingCurlyBrace,
      TokenKind.closingCurlyBrace,
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
