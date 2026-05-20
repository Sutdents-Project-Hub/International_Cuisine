import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for FavoritesApi
void main() {
  final instance = ApiClient().getFavoritesApi();

  group(FavoritesApi, () {
    // Add a recipe to favorites
    //
    //Future favoritesControllerCreate(CreateFavoriteDto createFavoriteDto) async
    test('test favoritesControllerCreate', () async {
      // TODO
    });

    // List user favorites, optionally by category
    //
    //Future favoritesControllerFindAll({ String category }) async
    test('test favoritesControllerFindAll', () async {
      // TODO
    });

    // List custom favorite categories
    //
    //Future favoritesControllerGetCategories() async
    test('test favoritesControllerGetCategories', () async {
      // TODO
    });

    // Remove a recipe from favorites
    //
    //Future favoritesControllerRemove(String id) async
    test('test favoritesControllerRemove', () async {
      // TODO
    });

  });
}
