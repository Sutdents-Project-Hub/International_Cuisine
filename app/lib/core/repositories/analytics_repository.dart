import 'package:api_client/api_client.dart';
import 'package:built_value/json_object.dart';
import 'package:dio/dio.dart';

import '../api/api_config.dart';
import '../api/api_shape.dart';

class AnalyticsRepository {
  final AnalyticsApi _api;

  AnalyticsRepository(Dio dio) : _api = ApiConfig.createAnalyticsApi(dio);

  Future<Map<String, dynamic>> stats() async {
    final response = await _api.analyticsControllerGetStats();
    return ApiShapeGuard.asMap(
      (response as dynamic).data,
      at: 'analytics.stats',
    );
  }

  Future<void> track({
    required CreateEventDtoEventTypeEnum type,
    String? recipeId,
    Map<String, dynamic>? meta,
  }) {
    final dto = CreateEventDto(
      (b) => b
        ..eventType = type
        ..recipeId = recipeId
        ..meta = meta == null ? null : JsonObject(meta),
    );

    return _api.analyticsControllerTrackEvent(createEventDto: dto);
  }
}
