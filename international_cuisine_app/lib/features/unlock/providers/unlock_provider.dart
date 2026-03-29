import 'package:flutter/material.dart';

import '../../recipe/models/recipe.dart';

class UnlockProvider extends ChangeNotifier {
  List<Recipe> _lockedRecipes = [];
  int _unlockedCount = 0;

  List<Recipe> get lockedRecipes => _lockedRecipes;
  int get unlockedCount => _unlockedCount;

  void sync({
    required List<Recipe> recipes,
    required List<dynamic> unlockedRecipes,
  }) {
    final unlockedSet = unlockedRecipes.map((e) => e.toString()).toSet();
    final nextLocked = recipes
        .where(
          (r) => r.isHidden && !r.isUnlocked && !unlockedSet.contains(r.id),
        )
        .toList(growable: false);
    final nextUnlockedCount = recipes
        .where(
          (r) => r.isHidden && (r.isUnlocked || unlockedSet.contains(r.id)),
        )
        .length;

    final changed =
        _unlockedCount != nextUnlockedCount ||
        _lockedRecipes.length != nextLocked.length ||
        !_sameIds(_lockedRecipes, nextLocked);
    if (!changed) return;

    _lockedRecipes = nextLocked;
    _unlockedCount = nextUnlockedCount;
    notifyListeners();
  }

  double progress() {
    final totalHidden = _lockedRecipes.length + _unlockedCount;
    if (totalHidden == 0) return 0;
    return _unlockedCount / totalHidden;
  }

  bool _sameIds(List<Recipe> a, List<Recipe> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i].id != b[i].id) return false;
    }
    return true;
  }
}
