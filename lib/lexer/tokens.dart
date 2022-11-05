enum TokenKind {
  openingSquareBracket,
  closingSquareBracket,
}

class Token {
  final TokenKind kind;
  final String lexeme;

  Token(this.kind, this.lexeme);
}
