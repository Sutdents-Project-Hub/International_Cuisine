import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AdminApi
void main() {
  final instance = ApiClient().getAdminApi();

  group(AdminApi, () {
    // [Admin] Create a new recipe with ingredients and steps
    //
    //Future adminControllerCreateRecipe(CreateRecipeDto createRecipeDto) async
    test('test adminControllerCreateRecipe', () async {
      // TODO
    });

    // [Admin] Delete a recipe
    //
    //Future adminControllerDeleteRecipe(String id) async
    test('test adminControllerDeleteRecipe', () async {
      // TODO
    });

    // [Admin] Get analytics dashboard overview
    //
    //Future adminControllerGetAnalyticsOverview() async
    test('test adminControllerGetAnalyticsOverview', () async {
      // TODO
    });

    // [Admin] List all users with stats
    //
    //Future adminControllerListUsers({ num page, num limit }) async
    test('test adminControllerListUsers', () async {
      // TODO
    });

    // [Admin] Set unlock conditions for a hidden recipe
    //
    //Future adminControllerSetUnlockConditions(String id, BuiltList<String> requestBody) async
    test('test adminControllerSetUnlockConditions', () async {
      // TODO
    });

    // [Admin] Update a recipe
    //
    //Future adminControllerUpdateRecipe(String id, UpdateRecipeDto updateRecipeDto) async
    test('test adminControllerUpdateRecipe', () async {
      // TODO
    });

  });
}
