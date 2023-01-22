import '../core/errors/parser_exceptions.dart';
import '../lexer/tokens.dart';
import 'issue.dart';

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

  List<Issue> parse() {
    List<Issue> issues = [];
    TokenIterator iterator = TokenIterator(tokens);

    while (iterator.hasNext()) {
      try {
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

        List<String> labels = [];
        if (match(iterator, TokenKind.openingCurlyBrace)) {
          labels = parseLabels(iterator);
        }

        throwErrorIfDoesntMatch(iterator, TokenKind.semicolon);

        if (iterator.hasNext()) iterator.moveNext();

        final issue = Issue(
          wasPosted: wasPosted,
          title: issueTitle,
          body: issueBodyText,
          labels: labels,
        );
        issues.add(issue);
      } catch (error) {
        rethrow;
      }
    }
    return issues;
  }

  List<String> parseLabels(TokenIterator iterator) {
    final labels = <String>[];
    iterator.moveNext();

    while (iterator.hasNext()) {
      if (match(iterator, TokenKind.closingCurlyBrace)) {
        iterator.moveNext();
        break;
      }

      throwErrorIfDoesntMatch(iterator, TokenKind.issueText);
      labels.add(iterator.current.lexeme);
      iterator.moveNext();

      if (match(iterator, TokenKind.comma)) {
        iterator.moveNext();
      }
    }
    return labels;
  }

  void throwErrorIfDoesntMatch(TokenIterator iterator, TokenKind expected) {
    if (iterator.current.kind != expected) {
      throw UnexpectedToken(iterator.current.lexeme);
    }
  }

  bool match(TokenIterator iterator, TokenKind expected) {
    return iterator.current.kind == expected;
  }
}
