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
      TokenKind.issueName,
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
      TokenKind.issueName,
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
      TokenKind.issueName,
      TokenKind.semicolon,
      TokenKind.openingSquareBracket,
      TokenKind.tilde,
      TokenKind.closingSquareBracket,
      TokenKind.colon,
      TokenKind.issueName,
      TokenKind.semicolon,
      TokenKind.openingSquareBracket,
      TokenKind.tilde,
      TokenKind.closingSquareBracket,
      TokenKind.colon,
      TokenKind.issueName,
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
