import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for RecipesApi
void main() {
  final instance = ApiClient().getRecipesApi();

  group(RecipesApi, () {
    // Mark recipe as completed (earn XP, check level up and unlocks)
    //
    //Future recipesControllerComplete(String id) async
    test('test recipesControllerComplete', () async {
      // TODO
    });

    // List recipes with search and filters
    //
    //Future recipesControllerFindAll({ String search, String country, String continent, String diet, String difficulty, num maxTime, num maxIngredients, num maxCalories, String cookingMethod, bool showHidden, num page, num limit }) async
    test('test recipesControllerFindAll', () async {
      // TODO
    });

    // Get recipe detail (auto-increments view count)
    //
    //Future recipesControllerFindOne(String id) async
    test('test recipesControllerFindOne', () async {
      // TODO
    });

    // Get available countries grouped by continent
    //
    //Future recipesControllerGetCountries() async
    test('test recipesControllerGetCountries', () async {
      // TODO
    });

    // Get recipe with scaled servings
    //
    //Future recipesControllerGetScaled(String id, num servings) async
    test('test recipesControllerGetScaled', () async {
      // TODO
    });

    // Attempt to unlock a hidden recipe
    //
    //Future recipesControllerUnlock(String id) async
    test('test recipesControllerUnlock', () async {
      // TODO
    });

  });
}
