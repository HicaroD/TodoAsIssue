enum TokenKind {
  openingSquareBracket,
  closingSquareBracket,
  colon,
  quote,
  issueText,
  tilde,
  number,
  semicolon,
  openingCurlyBrace,
  closingCurlyBrace,
  comma,
}

class Token {
  final TokenKind kind;
  final String lexeme;

  Token(this.kind, this.lexeme);

  @override
  String toString() {
    return "$kind('$lexeme')";
  }
}
