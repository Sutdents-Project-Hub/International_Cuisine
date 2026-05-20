class ApiShapeError implements Exception {
  final String message;

  ApiShapeError(this.message);

  @override
  String toString() => 'ApiShapeError: $message';
}

class ApiEnvelope<T> {
  final T data;
  final Map<String, dynamic>? meta;

  const ApiEnvelope({required this.data, this.meta});
}

class ApiShapeGuard {
  static Map<String, dynamic> asMap(dynamic input, {String? at}) {
    if (input is Map<String, dynamic>) return input;
    if (input is Map) {
      return input.map((key, value) => MapEntry(key.toString(), value));
    }
    throw ApiShapeError(
      'Expected map${at == null ? '' : ' at $at'}, got ${input.runtimeType}',
    );
  }

  static List<dynamic> asList(dynamic input, {String? at}) {
    if (input is List) return input;
    throw ApiShapeError(
      'Expected list${at == null ? '' : ' at $at'}, got ${input.runtimeType}',
    );
  }

  static List<Map<String, dynamic>> asListOfMaps(dynamic input, {String? at}) {
    return asList(
      input,
      at: at,
    ).map((e) => asMap(e, at: at)).toList(growable: false);
  }

  static ApiEnvelope<List<Map<String, dynamic>>> extractListEnvelope(
    dynamic raw,
  ) {
    if (raw is List) {
      return ApiEnvelope(data: asListOfMaps(raw));
    }

    final map = asMap(raw);
    if (map['data'] is List) {
      return ApiEnvelope(
        data: asListOfMaps(map['data'], at: 'data'),
        meta: map['meta'] is Map ? asMap(map['meta'], at: 'meta') : null,
      );
    }

    return ApiEnvelope(
      data: const [],
      meta: map['meta'] is Map ? asMap(map['meta']) : null,
    );
  }

  static String stringOr(dynamic value, String fallback) {
    if (value == null) return fallback;
    return value.toString();
  }

  static int intOr(dynamic value, int fallback) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? fallback;
    return fallback;
  }

  static double doubleOr(dynamic value, double fallback) {
    if (value is double) return value;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? fallback;
    return fallback;
  }

  static bool boolOr(dynamic value, bool fallback) {
    if (value is bool) return value;
    if (value is String) {
      final normalized = value.toLowerCase();
      if (normalized == 'true') return true;
      if (normalized == 'false') return false;
    }
    return fallback;
  }
}
