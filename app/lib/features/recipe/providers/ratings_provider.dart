import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/repositories/ratings_repository.dart';
import '../../../core/utils/error_utils.dart';
import '../../auth/providers/auth_provider.dart';
import '../models/rating.dart';

class RatingsProvider extends ChangeNotifier {
  final AuthProvider _authProvider;
  late final RatingsRepository _repository;

  RatingsProvider(this._authProvider, Dio dio) {
    _repository = RatingsRepository(dio);
  }

  final Map<String, List<RecipeRating>> _ratingsByRecipe = {};
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  List<RecipeRating> ratingsFor(String recipeId) =>
      _ratingsByRecipe[recipeId] ?? const [];

  Future<void> fetchRatings(String recipeId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _ratingsByRecipe[recipeId] = await _repository.fetchByRecipe(recipeId);
    } catch (e) {
      _error = parseApiError(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addRating({
    required String recipeId,
    required int score,
    String? comment,
  }) async {
    if (_authProvider.token == null) return;

    await _repository.create(
      recipeId: recipeId,
      score: score,
      comment: comment,
    );
    await fetchRatings(recipeId);
  }

  Future<void> updateRating({
    required String recipeId,
    required String ratingId,
    int? score,
    String? comment,
  }) async {
    if (_authProvider.token == null) return;

    await _repository.update(
      recipeId: recipeId,
      ratingId: ratingId,
      score: score,
      comment: comment,
    );
    await fetchRatings(recipeId);
  }

  Future<void> deleteRating({
    required String recipeId,
    required String ratingId,
  }) async {
    if (_authProvider.token == null) return;

    await _repository.delete(recipeId: recipeId, ratingId: ratingId);
    await fetchRatings(recipeId);
  }
}
