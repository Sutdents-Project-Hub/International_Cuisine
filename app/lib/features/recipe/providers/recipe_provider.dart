import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/repositories/recipe_repository.dart';
import '../../../core/utils/error_utils.dart';
import '../models/recipe.dart';
import '../models/recipe_filter.dart';
import '../utils/search_query_parser.dart';

class RecipeProvider extends ChangeNotifier {
  final Dio _dio;
  late final RecipeRepository _repository;

  List<Recipe> _recipes = [];
  List<Recipe> _lockedRecipes = const [];
  List<Recipe> _unlockedRecipes = const [];
  Map<String, List<String>> _countriesByContinent = {};
  List<String> _countries = const [];
  bool _isLoading = false;
  String? _error;
  Map<String, dynamic>? _meta;

  RecipeProvider(this._dio) {
    _repository = RecipeRepository(_dio);
    _loadRecentSearches();
  }

  List<Recipe> get recipes => _recipes;
  List<Recipe> get lockedRecipes => _lockedRecipes;
  List<Recipe> get unlockedRecipes => _unlockedRecipes;
  Map<String, List<String>> get countriesByContinent => _countriesByContinent;
  List<String> get countries => _countries;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Map<String, dynamic>? get meta => _meta;

  final List<String> _recentSearches = [];
  List<String> get recentSearches => List.unmodifiable(_recentSearches);

  Future<void> _loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    _recentSearches
      ..clear()
      ..addAll(prefs.getStringList('recent_searches') ?? const []);
    notifyListeners();
  }

  Future<void> _saveRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('recent_searches', _recentSearches);
  }

  Future<void> addRecentSearch(String query) async {
    final normalized = query.trim();
    if (normalized.isEmpty) return;

    _recentSearches.remove(normalized);
    _recentSearches.insert(0, normalized);
    if (_recentSearches.length > 10) {
      _recentSearches.removeRange(10, _recentSearches.length);
    }
    await _saveRecentSearches();
    notifyListeners();
  }

  RecipeFilter _filter = RecipeFilter();
  RecipeFilter get filter => _filter;

  void updateFilter(RecipeFilter newFilter) {
    _filter = newFilter;
    fetchRecipes(page: 1);
  }

  void applyNaturalLanguageFilter(String query) {
    _filter = SearchQueryParser.parse(query, base: _filter);
    addRecentSearch(query);
    fetchRecipes(page: 1);
  }

  void clearFilter() {
    _filter.clear();
    fetchRecipes(page: 1);
  }

  Future<void> fetchCountries() async {
    try {
      _countriesByContinent = await _repository.fetchCountriesByContinent();
      _rebuildCountriesCache();
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching countries: $e');
    }
  }

  Future<void> fetchRecipes({int page = 1, int limit = 20}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final envelope = await _repository.fetchRecipes(
        filter: _filter,
        page: page,
        limit: limit,
      );

      _recipes = envelope.data;
      _meta = envelope.meta;
      _rebuildRecipeCaches();
    } catch (e) {
      _error = parseApiError(e);
      debugPrint('Error fetching recipes: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _rebuildCountriesCache() {
    _countries = List.unmodifiable(
      _countriesByContinent.values.expand((e) => e),
    );
  }

  void _rebuildRecipeCaches() {
    final locked = <Recipe>[];
    final unlocked = <Recipe>[];
    for (final r in _recipes) {
      if (r.isHidden && !r.isUnlocked) {
        locked.add(r);
      } else {
        unlocked.add(r);
      }
    }
    _lockedRecipes = List.unmodifiable(locked);
    _unlockedRecipes = List.unmodifiable(unlocked);
  }


  Future<bool> unlockRecipe(String id) async {
    try {
      await _repository.unlockRecipe(id);
      await fetchRecipes(page: 1);
      return true;
    } catch (e) {
      debugPrint('Error unlocking recipe: $e');
      return false;
    }
  }

  Future<bool> completeRecipe(String id) async {
    try {
      await _repository.completeRecipe(id);
      return true;
    } catch (e) {
      debugPrint('Error completing recipe: $e');
      return false;
    }
  }

  Future<Recipe?> getScaledRecipe(String id, int servings) {
    return _repository.fetchScaledRecipe(id, servings);
  }

  Future<Recipe?> getRecipe(String id) {
    return _repository.fetchRecipeDetail(id);
  }

  Future<bool> createRecipe(CreateRecipeDto dto) async {
    try {
      await _repository.createRecipe(dto);
      // Refresh list to show new recipe
      await fetchRecipes(page: 1);
      return true;
    } catch (e) {
      _error = parseApiError(e);
      debugPrint('Error creating recipe: $e');
      notifyListeners();
      return false;
    }
  }
}
