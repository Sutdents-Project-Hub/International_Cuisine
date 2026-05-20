import 'package:flutter_test/flutter_test.dart';
import 'package:international_cuisine/features/recipe/models/recipe.dart';
import 'package:international_cuisine/features/recipe/utils/search_query_parser.dart';
import 'package:international_cuisine/features/recipe/utils/serving_scaler.dart';
import 'package:international_cuisine/features/recipe/utils/substitution_engine.dart';

void main() {
  group('SearchQueryParser', () {
    test('parses chinese natural language query to filter', () {
      final filter = SearchQueryParser.parse('30 分鐘內、素食、台灣菜');

      expect(filter.maxTime, 30);
      expect(filter.diet, 'vegetarian');
      expect(filter.country, 'Taiwan');
    });
  });

  group('ServingScaler', () {
    test('supports min unit rounding strategy', () {
      final scaled = ServingScaler.scale(
        baseQtyPerServing: 0.3,
        targetServings: 1,
        strategy: 'MIN_UNIT',
      );

      expect(scaled, 0.25);
    });
  });

  group('SubstitutionEngine', () {
    test('suggests substitutions for vegetarian preference', () {
      final ingredients = [
        const RecipeIngredient(
          name: 'Chicken Breast',
          qtyPerServing: 200,
          unit: 'g',
          optional: false,
        ),
      ];

      final suggestions = SubstitutionEngine.suggest(
        ingredients: ingredients,
        preferences: const ['vegetarian'],
      );

      expect(suggestions, isNotEmpty);
      expect(suggestions.first.replacement, 'Firm tofu');
    });
  });
}
