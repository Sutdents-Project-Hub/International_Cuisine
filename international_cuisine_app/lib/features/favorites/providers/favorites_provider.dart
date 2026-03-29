import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/repositories/favorites_repository.dart';
import '../../../core/utils/error_utils.dart';
import '../../auth/providers/auth_provider.dart';
import '../../recipe/models/recipe.dart';

class FavoritesProvider extends ChangeNotifier {
  final AuthProvider _authProvider;
  final Dio _dio;
  late FavoritesRepository _repository;

  List<Recipe> _favorites = [];
  List<String> _categories = [];
  String? _selectedCategory;
  bool _isLoading = false;
  String? _error;

  String? _lastToken;

  FavoritesProvider(this._authProvider, this._dio) {
    _lastToken = _authProvider.token;
    _repository = FavoritesRepository(_dio);
  }

  void update(AuthProvider auth) {
    if (auth.token != _lastToken) {
      _lastToken = auth.token;
      if (auth.token == null) {
        _favorites = [];
        _categories = [];
        notifyListeners();
      } else {
        fetchCategories();
        fetchFavorites();
      }
    }
  }

  List<Recipe> get favorites => _favorites;
  List<String> get categories => _categories;
  String? get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void selectCategory(String? category) {
    _selectedCategory = category;
    fetchFavorites();
  }

  Future<void> fetchCategories() async {
    if (_authProvider.token == null) return;
    try {
      _categories = await _repository.fetchCategories();
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching favorite categories: $e');
    }
  }

  Future<void> fetchFavorites() async {
    if (_authProvider.token == null) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _favorites = await _repository.fetchFavorites(
        category: _selectedCategory,
      );
    } catch (e) {
      _error = parseApiError(e);
      debugPrint('Error fetching favorites: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addFavorite(String recipeId, {String? categoryName}) async {
    if (_authProvider.token == null) return;
    try {
      await _repository.addFavorite(recipeId, categoryName: categoryName);
      await fetchFavorites();
      await fetchCategories();
    } catch (e) {
      _error = parseApiError(e);
      notifyListeners();
      rethrow;
    }
  }

  Future<void> removeFavorite(String recipeId) async {
    if (_authProvider.token == null) return;
    try {
      await _repository.removeFavorite(recipeId);
      _favorites.removeWhere((r) => r.id == recipeId);
      notifyListeners();
    } catch (e) {
      _error = parseApiError(e);
      notifyListeners();
      rethrow;
    }
  }

  bool isFavorite(String recipeId) {
    return _favorites.any((r) => r.id == recipeId);
  }

  Future<void> toggleFavorite(String recipeId, {String? categoryName}) async {
    if (isFavorite(recipeId)) {
      await removeFavorite(recipeId);
    } else {
      await addFavorite(recipeId, categoryName: categoryName);
    }
  }
}
