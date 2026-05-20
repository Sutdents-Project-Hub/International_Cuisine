import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/repositories/analytics_repository.dart';

class AnalyticsProvider extends ChangeNotifier {
  late final AnalyticsRepository _repository;

  AnalyticsProvider(Dio dio) {
    _repository = AnalyticsRepository(dio);
  }

  Map<String, dynamic>? _stats;
  Map<String, dynamic>? get stats => _stats;

  Future<void> fetchStats() async {
    try {
      _stats = await _repository.stats();
      notifyListeners();
    } catch (_) {
      // keep silent, analytics should never block UX
    }
  }

  Future<void> trackView(String recipeId) {
    return _repository.track(
      type: CreateEventDtoEventTypeEnum.VIEW,
      recipeId: recipeId,
    );
  }

  Future<void> trackStart(String recipeId) {
    return _repository.track(
      type: CreateEventDtoEventTypeEnum.START,
      recipeId: recipeId,
    );
  }

  Future<void> trackComplete(String recipeId) {
    return _repository.track(
      type: CreateEventDtoEventTypeEnum.COMPLETE,
      recipeId: recipeId,
    );
  }

  Future<void> trackFavorite(String recipeId) {
    return _repository.track(
      type: CreateEventDtoEventTypeEnum.FAVORITE,
      recipeId: recipeId,
    );
  }
}
