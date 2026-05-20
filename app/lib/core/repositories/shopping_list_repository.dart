import 'package:api_client/api_client.dart';
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';

import '../../features/shopping_list/models/shopping_list.dart';
import '../api/api_config.dart';
import '../api/api_shape.dart';

class ShoppingListRepository {
  final ShoppingListsApi _api;

  ShoppingListRepository(Dio dio)
    : _api = ApiConfig.createShoppingListsApi(dio);

  Future<List<ShoppingList>> fetchLists() async {
    final response = await _api.shoppingListsControllerFindAll();
    final data = ApiShapeGuard.asList(
      (response as dynamic).data,
      at: 'shopping.list',
    );

    return data
        .map(
          (e) => ShoppingList.fromJson(
            ApiShapeGuard.asMap(e, at: 'shopping.list.item'),
          ),
        )
        .toList(growable: false);
  }

  Future<void> createList({
    required String title,
    required List<String> recipeIds,
    required List<int> servings,
  }) async {
    final pairs = <RecipeServingPair>[];
    for (var i = 0; i < recipeIds.length; i++) {
      pairs.add(
        RecipeServingPair(
          (b) => b
            ..recipeId = recipeIds[i]
            ..servings = servings[i],
        ),
      );
    }

    final dto = CreateShoppingListDto(
      (b) => b
        ..title = title
        ..recipes = ListBuilder(pairs),
    );

    await _api.shoppingListsControllerCreate(createShoppingListDto: dto);
  }

  Future<void> toggleItem({required String listId, required String itemId}) {
    return _api.shoppingListsControllerToggleItem(id: listId, itemId: itemId);
  }

  Future<String> exportCsv(String id) async {
    final response = await _api.shoppingListsControllerExportCsv(id: id);
    final data = (response as dynamic).data;
    return data?.toString() ?? '';
  }

  Future<void> deleteList(String id) =>
      _api.shoppingListsControllerRemove(id: id);
}
