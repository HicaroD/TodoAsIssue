import '../core/errors/lexer_exceptions.dart';
import 'position.dart';

import 'tokens.dart';

class Lexer {
  String fileContent;
  Cursor cursor = Cursor();
  bool isEndOfFile = false;
  late String currentCharacter;

  Lexer(this.fileContent);

  List<Token> tokenize() {
    fileContent = fileContent.trim();

    List<Token> tokens = [];
    advanceCursor();

    while (!isEndOfFile) {
      skipWhitespaces();

      switch (currentCharacter) {
        case "[":
          {
            tokens.add(
                consumeToken(TokenKind.openingSquareBracket, currentCharacter));
            break;
          }
        case "]":
          {
            tokens.add(
                consumeToken(TokenKind.closingSquareBracket, currentCharacter));
            break;
          }

        case ":":
          {
            tokens.add(consumeToken(TokenKind.colon, currentCharacter));
            break;
          }

        case "\"":
          {
            String issueName = "";
            advanceCursor();
            while (currentCharacter != "\"" && !isEndOfFile) {
              issueName += currentCharacter;
              advanceCursor();
            }
            advanceCursor();
            tokens.add(Token(TokenKind.issueText, issueName));
            break;
          }

        case "~":
          {
            tokens.add(consumeToken(TokenKind.tilde, currentCharacter));
            break;
          }

        case ";":
          {
            tokens.add(consumeToken(TokenKind.semicolon, currentCharacter));
            break;
          }

        case ",":
          {
            tokens.add(consumeToken(TokenKind.comma, currentCharacter));
            break;
          }

        case "{":
          {
            tokens.add(
                consumeToken(TokenKind.openingCurlyBrace, currentCharacter));
            break;
          }

        case "}":
          {
            tokens.add(
                consumeToken(TokenKind.closingCurlyBrace, currentCharacter));
            break;
          }

        default:
          throw UnknownToken(currentCharacter);
      }
    }
    return tokens;
  }

  Token consumeToken(TokenKind kind, String lexeme) {
    Token token = Token(kind, lexeme);
    advanceCursor();
    return token;
  }

  bool isDigit(String currentChar) {
    return double.tryParse(currentChar) != null;
  }

  void skipWhitespaces() {
    while (currentCharacter.trim().isEmpty) {
      advanceCursor();
    }
  }

  void advanceCursor() {
    if (cursor.position < fileContent.length) {
      currentCharacter = fileContent[cursor.position];
    } else {
      isEndOfFile = true;
    }

    if (currentCharacter == '\n') {
      cursor.line++;
    }
    cursor.position++;
  }
}
