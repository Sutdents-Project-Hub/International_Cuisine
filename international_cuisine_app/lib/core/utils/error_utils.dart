import 'package:dio/dio.dart';

/// Extracts a user-friendly error message from any exception.
///
/// For [DioException]s, attempts to parse the backend's JSON response
/// (looking for `message` or `error` keys) before falling back to
/// a generic network error string.
String parseApiError(dynamic e) {
  if (e is DioException) {
    final data = e.response?.data;
    if (data != null) {
      if (data is Map<String, dynamic>) {
        if (data.containsKey('message')) {
          final msg = data['message'];
          if (msg is List) return msg.join('\n');
          return msg.toString();
        }
        if (data.containsKey('error')) return data['error'].toString();
      }
      return data.toString();
    }

    // No response body — classify by status or connection type
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timed out. Please try again.';
      case DioExceptionType.connectionError:
        return 'Could not connect to the server.';
      default:
        return 'Network error. Please try again.';
    }
  }
  return e.toString();
}
