import 'dart:io';

import 'tokens.dart';

class Lexer {
  final String fileContent;
  int cursor = 0;
  bool isEndOfFile = false;
  late String currentCharacter;

  Lexer(this.fileContent);

  List<Token> tokenize() {
    List<Token> tokens = [];
    advanceCursor();

    while (!isEndOfFile) {
      skipWhitespaces();

      switch (currentCharacter) {
        case "[":
          {
	    tokens.add(consumeToken(TokenKind.openingSquareBracket, currentCharacter));
            break;
          }
        case "]":
          {
	    tokens.add(consumeToken(TokenKind.closingSquareBracket, currentCharacter));
            break;
          }

        case "#":
          {
	    tokens.add(consumeToken(TokenKind.hashSymbol, currentCharacter));
            break;
          }

        case "(":
          {
	    tokens.add(consumeToken(TokenKind.openingParenthesis, currentCharacter));
            break;
          }

        case ")":
          {
	    tokens.add(consumeToken(TokenKind.closingParenthesis, currentCharacter));
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
            tokens.add(Token(TokenKind.issueName, issueName));
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

        default:
          {
            if (isDigit(currentCharacter)) {
              String number = "";
              while (isDigit(currentCharacter)) {
                number += currentCharacter;
                advanceCursor();
              }
              tokens.add(Token(TokenKind.number, number));
            } else {
              print("ERROR: Unknown token: $currentCharacter");
              exit(1);
            }
          }
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
    if (currentCharacter.trim().isEmpty) advanceCursor();
  }

  void advanceCursor() {
    if (cursor < fileContent.length - 1) {
      currentCharacter = fileContent[cursor];
      cursor++;
    } else {
      isEndOfFile = true;
    }
  }
}
