import 'dart:io';

import 'tokens.dart';

class Lexer {
  final String fileContent;
  int cursor = 0;
  bool isEndOfFile = false;
  late String currentCharacter;

  Lexer(this.fileContent);

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

  List<Token> tokenize() {
    List<Token> tokens = [];
    advanceCursor();

    while (!isEndOfFile) {
      skipWhitespaces();
      print(currentCharacter);

      switch (currentCharacter) {
        case "[":
          {
            tokens.add(Token(TokenKind.openingSquareBracket, currentCharacter));
            advanceCursor();
            break;
          }
        case "]":
          {
            tokens.add(Token(TokenKind.openingSquareBracket, currentCharacter));
            advanceCursor();
            break;
          }

        case "#":
          {
            tokens.add(Token(TokenKind.hashSymbol, currentCharacter));
            advanceCursor();
            break;
          }

        case "(":
          {
            tokens.add(Token(TokenKind.openingParenthesis, currentCharacter));
            advanceCursor();
            break;
          }

        case ")":
          {
            tokens.add(Token(TokenKind.closingParenthesis, currentCharacter));
            advanceCursor();
            break;
          }

        case ":":
          {
            tokens.add(Token(TokenKind.colon, currentCharacter));
            advanceCursor();
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
            tokens.add(Token(TokenKind.tilde, currentCharacter));
            advanceCursor();
            break;
          }

        case ";":
          {
            tokens.add(Token(TokenKind.semicolon, currentCharacter));
            advanceCursor();
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
              tokens.add(Token(TokenKind.Number, number));
            } else {
              print("ERROR: Unknown token: $currentCharacter");
              exit(1);
            }
          }
      }
    }
    return tokens;
  }

  bool isDigit(String currentChar) {
    return double.tryParse(currentChar) != null;
  }
}
