import '../models/recipe.dart';

class IngredientSubstitution {
  final String source;
  final String replacement;
  final String reason;

  const IngredientSubstitution({
    required this.source,
    required this.replacement,
    required this.reason,
  });
}

class SubstitutionEngine {
  static List<IngredientSubstitution> suggest({
    required List<RecipeIngredient> ingredients,
    required List<String> preferences,
  }) {
    final prefSet = preferences.map((e) => e.toLowerCase()).toSet();
    final suggestions = <IngredientSubstitution>[];

    for (final ingredient in ingredients) {
      final name = ingredient.name.toLowerCase();

      if (prefSet.contains('vegetarian') || prefSet.contains('vegan')) {
        if (name.contains('chicken')) {
          suggestions.add(
            const IngredientSubstitution(
              source: 'Chicken',
              replacement: 'Firm tofu',
              reason: 'Vegetarian protein alternative',
            ),
          );
        }
        if (name.contains('beef')) {
          suggestions.add(
            const IngredientSubstitution(
              source: 'Beef',
              replacement: 'King oyster mushroom',
              reason: 'Meaty texture with vegetarian profile',
            ),
          );
        }
      }

      if (name.contains('soy sauce') && prefSet.contains('gluten-free')) {
        suggestions.add(
          const IngredientSubstitution(
            source: 'Soy sauce',
            replacement: 'Tamari',
            reason: 'Gluten-free alternative',
          ),
        );
      }
    }

    return suggestions;
  }
}
