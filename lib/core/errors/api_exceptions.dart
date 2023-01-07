import 'dart:collection';

class InvalidCredentials implements Exception {
  String message;
  InvalidCredentials(this.message);
}

class ServiceUnavaiable implements Exception {
  String message;
  ServiceUnavaiable(this.message);
}

class SpammedCommand implements Exception {
  String message;
  SpammedCommand(this.message);
}

class UnexpectedError implements Exception {
  String message;
  UnexpectedError(this.message);
}
