import 'dart:io';

import '../lexer/tokens.dart';

class ErrorReporter {
  void reportError(Token token) {
    print("ERROR: Invalid token '$token'");
    exit(1);
  }
}
