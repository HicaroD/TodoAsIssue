enum TokenKind {
  openingSquareBracket,
  closingSquareBracket,
  colon,
  quote,
  issueName,
  tilde,
  number,
  semicolon,
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
