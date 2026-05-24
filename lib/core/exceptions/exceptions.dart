import 'package:dio/dio.dart';

class OBSException implements Exception {
  OBSException(this.message);
  final String message;

  @override
  String toString() =>
      '''
  \n----------------
  \nClass : [$this]
  \nMessage : $message
  \n----------------\n
  ''';
}

class CacheException extends OBSException {
  CacheException(super.message);
}

class OBSServerException extends OBSException {
  OBSServerException(super.message);
}

class OBSSoundException extends OBSException {
  OBSSoundException(super.message);
}

class OBSScenesException extends OBSException {
  OBSScenesException(super.message);
}

class OBSSourcesException extends OBSException {
  OBSSourcesException(super.message);
}

class OBSStatusException extends OBSException {
  OBSStatusException(super.message);
}

/// Robust Exception model representing standard server error payloads
class ExceptionModel implements Exception {
  const ExceptionModel({
    required this.message,
    required this.exception,
    required this.statusCode,
  });

  factory ExceptionModel.fromDioException(Object? dioException) {
    String msg = 'An unexpected network error occurred';
    String exc = 'DioException';
    int status = 500;

    try {
      if (dioException is DioException) {
        final response = dioException.response;
        if (response != null) {
          status = response.statusCode ?? 500;
          final responseData = response.data;
          if (responseData is Map<String, dynamic>) {
            msg = (responseData['message'] ?? responseData['error'] ?? msg).toString();
            exc = (responseData['exception'] ?? exc).toString();
          } else {
            msg = response.statusMessage ?? msg;
          }
        } else {
          msg = dioException.message ?? msg;
          exc = dioException.type.toString();
        }
      }
    } catch (_) {
      // In case type casting fails or fields are missing, gracefully fallback
      if (dioException != null) {
        msg = dioException.toString();
      }
    }

    return ExceptionModel(
      message: msg,
      exception: exc,
      statusCode: status,
    );
  }

  final String message;
  final String exception;
  final int statusCode;

  Map<String, dynamic> toJson() => {
    'message': message,
    'exception': exception,
    'statusCode': statusCode,
  };

  @override
  String toString() => 'ExceptionModel(message: $message, exception: $exception, statusCode: $statusCode)';
}
