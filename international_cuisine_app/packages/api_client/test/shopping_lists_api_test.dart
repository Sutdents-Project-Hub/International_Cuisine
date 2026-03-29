import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for ShoppingListsApi
void main() {
  final instance = ApiClient().getShoppingListsApi();

  group(ShoppingListsApi, () {
    // Create shopping list from recipe IDs with servings (auto-merges ingredients)
    //
    //Future shoppingListsControllerCreate(CreateShoppingListDto createShoppingListDto) async
    test('test shoppingListsControllerCreate', () async {
      // TODO
    });

    // Export shopping list as CSV
    //
    //Future shoppingListsControllerExportCsv(String id) async
    test('test shoppingListsControllerExportCsv', () async {
      // TODO
    });

    // List all shopping lists
    //
    //Future shoppingListsControllerFindAll() async
    test('test shoppingListsControllerFindAll', () async {
      // TODO
    });

    // Get shopping list detail
    //
    //Future shoppingListsControllerFindOne(String id) async
    test('test shoppingListsControllerFindOne', () async {
      // TODO
    });

    // Delete a shopping list
    //
    //Future shoppingListsControllerRemove(String id) async
    test('test shoppingListsControllerRemove', () async {
      // TODO
    });

    // Toggle item checked status
    //
    //Future shoppingListsControllerToggleItem(String id, String itemId) async
    test('test shoppingListsControllerToggleItem', () async {
      // TODO
    });

  });
}
