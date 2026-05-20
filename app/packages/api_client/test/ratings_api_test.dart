import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for RatingsApi
void main() {
  final instance = ApiClient().getRatingsApi();

  group(RatingsApi, () {
    // Rate and comment on a recipe (1-5 stars)
    //
    //Future ratingsControllerCreate(String recipeId, CreateRatingDto createRatingDto) async
    test('test ratingsControllerCreate', () async {
      // TODO
    });

    // Get ratings for a recipe
    //
    //Future ratingsControllerFindByRecipe(String recipeId) async
    test('test ratingsControllerFindByRecipe', () async {
      // TODO
    });

    // Delete own rating
    //
    //Future ratingsControllerRemove(String recipeId, String id) async
    test('test ratingsControllerRemove', () async {
      // TODO
    });

    // Update own rating
    //
    //Future ratingsControllerUpdate(String recipeId, String id, UpdateRatingDto updateRatingDto) async
    test('test ratingsControllerUpdate', () async {
      // TODO
    });

  });
}
