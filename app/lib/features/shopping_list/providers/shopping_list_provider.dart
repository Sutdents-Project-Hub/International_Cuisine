import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/repositories/shopping_list_repository.dart';
import '../../../core/utils/error_utils.dart';
import '../models/shopping_list.dart';

class ShoppingListProvider extends ChangeNotifier {
  late final ShoppingListRepository _repository;

  List<ShoppingList> _lists = [];
  bool _isLoading = false;
  String? _error;

  ShoppingListProvider(Dio dio) {
    _repository = ShoppingListRepository(dio);
  }

  List<ShoppingList> get lists => _lists;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchLists() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _lists = await _repository.fetchLists();
    } catch (e) {
      _error = parseApiError(e);
      debugPrint('Error fetching shopping lists: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createList(
    String title,
    List<String> recipeIds,
    List<int> servings,
  ) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.createList(
        title: title,
        recipeIds: recipeIds,
        servings: servings,
      );
      await fetchLists();
    } catch (e) {
      _error = parseApiError(e);
      debugPrint('Error creating list: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteList(String listId) async {
    try {
      await _repository.deleteList(listId);
      _lists.removeWhere((l) => l.id == listId);
      notifyListeners();
    } catch (e) {
      _error = parseApiError(e);
      notifyListeners();
    }
  }

  Future<String> exportCsv(String listId) {
    return _repository.exportCsv(listId);
  }

  Future<void> toggleItem(String listId, String itemId) async {
    final listIndex = _lists.indexWhere((l) => l.id == listId);
    if (listIndex == -1) return;

    final list = _lists[listIndex];
    final itemIndex = list.items.indexWhere((i) => i.id == itemId);
    if (itemIndex == -1) return;

    final item = list.items[itemIndex];
    final newItem = ShoppingListItem(
      id: item.id,
      ingredientName: item.ingredientName,
      quantity: item.quantity,
      unit: item.unit,
      checked: !item.checked,
      category: item.category,
    );

    final newItems = List<ShoppingListItem>.from(list.items);
    newItems[itemIndex] = newItem;

    final newList = ShoppingList(
      id: list.id,
      title: list.title,
      items: newItems,
      createdAt: list.createdAt,
    );

    _lists[listIndex] = newList;
    notifyListeners();

    try {
      await _repository.toggleItem(listId: listId, itemId: itemId);
    } catch (e) {
      _lists[listIndex] = list;
      notifyListeners();
      debugPrint('Failed to toggle item: $e');
    }
  }
}
