class AppException implements Exception {

  AppException([this._message, this._prefix]);
  final String? _message;
  final String? _prefix;

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, '');
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, 'Invalid Request:');
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String? message]) : super(message, 'Unauthorized:');
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message])
      : super(message, 'Invalid Input\n\n');
}

class NotFoundException extends AppException {
  NotFoundException([String? message]) : super(message, 'Not Found:');
}

class InternalServerException extends AppException {
  InternalServerException([String? message])
      : super(message, 'Internal Server Error:');
}
