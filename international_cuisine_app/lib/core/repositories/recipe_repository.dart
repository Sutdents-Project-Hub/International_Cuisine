import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';

import '../../features/recipe/models/recipe.dart';
import '../../features/recipe/models/recipe_filter.dart';
import '../api/api_config.dart';
import '../api/api_shape.dart';

class RecipeRepository {
  final RecipesApi _api;

  RecipeRepository(Dio dio) : _api = ApiConfig.createRecipesApi(dio);

  Future<ApiEnvelope<List<Recipe>>> fetchRecipes({
    required RecipeFilter filter,
    int page = 1,
    int limit = 20,
  }) async {
    final response = await _api.recipesControllerFindAll(
      search: filter.search,
      country: filter.country,
      continent: filter.continent,
      diet: filter.diet,
      difficulty: filter.difficulty,
      maxTime: filter.maxTime,
      maxIngredients: filter.maxIngredients,
      maxCalories: filter.maxCalories,
      cookingMethod: filter.cookingMethod,
      showHidden: filter.showHidden,
      page: page,
      limit: limit,
    );

    final envelope = ApiShapeGuard.extractListEnvelope(
      (response as dynamic).data,
    );
    return ApiEnvelope(
      data: envelope.data.map(Recipe.fromJson).toList(growable: false),
      meta: envelope.meta,
    );
  }

  Future<Map<String, List<String>>> fetchCountriesByContinent() async {
    final response = await _api.recipesControllerGetCountries();
    final map = ApiShapeGuard.asMap(
      (response as dynamic).data,
      at: 'recipes.countries',
    );

    final result = <String, List<String>>{};
    map.forEach((key, value) {
      if (value is List) {
        result[key] = value.map((e) => e.toString()).toList(growable: false);
      }
    });
    return result;
  }

  Future<Recipe?> fetchRecipeDetail(String id) async {
    final response = await _api.recipesControllerFindOne(id: id);
    final data = (response as dynamic).data;
    if (data == null) return null;
    return Recipe.fromJson(ApiShapeGuard.asMap(data, at: 'recipes.detail'));
  }

  Future<Recipe?> fetchScaledRecipe(String id, int servings) async {
    final response = await _api.recipesControllerGetScaled(
      id: id,
      servings: servings,
    );
    final data = (response as dynamic).data;
    if (data == null) return null;
    return Recipe.fromJson(ApiShapeGuard.asMap(data, at: 'recipes.scale'));
  }

  Future<void> completeRecipe(String id) =>
      _api.recipesControllerComplete(id: id);

  Future<void> unlockRecipe(String id) => _api.recipesControllerUnlock(id: id);

  Future<Recipe?> createRecipe(CreateRecipeDto dto) async {
    final response = await _api.recipesControllerCreate(createRecipeDto: dto);
    final data = (response as dynamic).data;
    if (data == null) return null;
    // Assuming the API returns the created recipe
    // If it returns void, we can just return null or void
    // The API definition says Future<Response<void>> for create
    // But usually it returns the object. Let's check the generated code return type.
    // generated code: Future<Response<void>> recipesControllerCreate
    // So distinct from FindOne.
    // If it returns void, we can't return Recipe?.
    // I'll return void for now.
    return null;
  }
}
