class ApiException implements Exception {
  final String message;
  final int? code;

  ApiException(this.message, [this.code]);

  @override
  String toString() => 'ApiException: $message (Code: $code)';
}

class NetworkException extends ApiException {
  NetworkException(String message) : super(message);
}

class ServerException extends ApiException {
  ServerException(String message, [int? code]) : super(message, code);
}

class ClientException extends ApiException {
  ClientException(String message, [int? code]) : super(message, code);
}

class AuthenticationException extends ApiException {
  AuthenticationException(String message, [int? code]) : super(message, code);
}

class ValidationException extends ApiException {
  final Map<String, dynamic>? validationErrors;

  ValidationException(String message, [this.validationErrors, int? code]) : super(message, code);

  @override
  String toString() {
    if (validationErrors != null && validationErrors!.isNotEmpty) {
      return 'ValidationException: $message (Code: $code), Errors: $validationErrors';
    }
    return super.toString();
  }
}

class ApiExceptionHelper {
  static String getFriendlyMessage(ApiException exception) {
    if (exception is NetworkException) {
      return 'No internet connection. Please check your network settings.';
    } else if (exception is ServerException) {
      return 'Server error occurred. Please try again later.';
    } else if (exception is ClientException) {
      return 'An error occurred while processing your request. Please try again.';
    } else if (exception is AuthenticationException) {
      return 'Authentication failed. Please log in again.';
    } else if (exception is ValidationException) {
      return 'Validation error: ${exception.validationErrors?.values.join(", ") ?? exception.message}';
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }
}
