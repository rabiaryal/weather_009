
class AppExpection implements Exception {
  final _message;
  final _prefix;
  AppExpection([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix $_message';
  }
}

class FetchException extends AppExpection {
  FetchException([String? message])
      : super(message, 'Error During Communication');
}

class BadRequestException extends AppExpection {
  BadRequestException([String? message]) : super(message, 'Invalid Requuest');
}


class UnAuthorizedException extends AppExpection {
  UnAuthorizedException([String? message]) : super(message, 'Unauthorizeed request');
}

class InvalidInputException extends AppExpection {
  InvalidInputException([String? message]) : super(message, 'Invalid Excepption');
}
