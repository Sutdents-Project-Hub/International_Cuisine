import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';

import '../../features/recipe/models/recipe.dart';
import '../api/api_config.dart';
import '../api/api_shape.dart';

class FavoritesRepository {
  final FavoritesApi _api;

  FavoritesRepository(Dio dio) : _api = ApiConfig.createFavoritesApi(dio);

  Future<List<Recipe>> fetchFavorites({String? category}) async {
    final response = await _api.favoritesControllerFindAll(category: category);
    final data = (response as dynamic).data;

    final list = ApiShapeGuard.asList(data, at: 'favorites.list');
    return list
        .map((item) {
          final map = ApiShapeGuard.asMap(item, at: 'favorites.item');
          if (map['recipe'] is Map) {
            return Recipe.fromJson(ApiShapeGuard.asMap(map['recipe']));
          }
          return Recipe.fromJson(map);
        })
        .toList(growable: false);
  }

  Future<List<String>> fetchCategories() async {
    final response = await _api.favoritesControllerGetCategories();
    final data = ApiShapeGuard.asList(
      (response as dynamic).data,
      at: 'favorites.categories',
    );
    return data.map((e) => e.toString()).toList(growable: false);
  }

  Future<void> addFavorite(String recipeId, {String? categoryName}) async {
    final dto = CreateFavoriteDto(
      (b) => b
        ..recipeId = recipeId
        ..categoryName = categoryName,
    );

    await _api.favoritesControllerCreate(createFavoriteDto: dto);
  }

  Future<void> removeFavorite(String favoriteIdOrRecipeId) async {
    await _api.favoritesControllerRemove(id: favoriteIdOrRecipeId);
  }
}
