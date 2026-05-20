import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';

import '../../features/recipe/models/rating.dart';
import '../api/api_config.dart';
import '../api/api_shape.dart';

class RatingsRepository {
  final RatingsApi _api;

  RatingsRepository(Dio dio) : _api = ApiConfig.createRatingsApi(dio);

  Future<List<RecipeRating>> fetchByRecipe(String recipeId) async {
    final response = await _api.ratingsControllerFindByRecipe(
      recipeId: recipeId,
    );
    final list = ApiShapeGuard.asList(
      (response as dynamic).data,
      at: 'ratings.list',
    );
    return list
        .map(
          (e) =>
              RecipeRating.fromJson(ApiShapeGuard.asMap(e, at: 'ratings.item')),
        )
        .toList(growable: false);
  }

  Future<void> create({
    required String recipeId,
    required int score,
    String? comment,
  }) {
    final dto = CreateRatingDto(
      (b) => b
        ..score = score
        ..comment = comment,
    );
    return _api.ratingsControllerCreate(
      recipeId: recipeId,
      createRatingDto: dto,
    );
  }

  Future<void> update({
    required String recipeId,
    required String ratingId,
    int? score,
    String? comment,
  }) {
    final dto = UpdateRatingDto(
      (b) => b
        ..score = score
        ..comment = comment,
    );
    return _api.ratingsControllerUpdate(
      recipeId: recipeId,
      id: ratingId,
      updateRatingDto: dto,
    );
  }

  Future<void> delete({required String recipeId, required String ratingId}) {
    return _api.ratingsControllerRemove(recipeId: recipeId, id: ratingId);
  }
}
