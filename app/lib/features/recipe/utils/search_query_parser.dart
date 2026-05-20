import '../models/recipe_filter.dart';

class SearchQueryParser {
  static RecipeFilter parse(String query, {RecipeFilter? base}) {
    final q = query.trim().toLowerCase();
    final filter = (base ?? RecipeFilter()).copyWith(search: query.trim());

    final minuteRegex = RegExp(r'(\d+)\s*(分鐘|分|min|minutes?)');
    final minuteMatch = minuteRegex.firstMatch(q);
    if (minuteMatch != null) {
      filter.maxTime = int.tryParse(minuteMatch.group(1)!);
    }

    if (q.contains('素') || q.contains('vegetarian')) {
      filter.diet = 'vegetarian';
    } else if (q.contains('vegan') || q.contains('純素')) {
      filter.diet = 'vegan';
    }

    if (q.contains('台灣') || q.contains('taiwan')) {
      filter.country = 'Taiwan';
    } else if (q.contains('日本') || q.contains('japan')) {
      filter.country = 'Japan';
    } else if (q.contains('韓國') || q.contains('korea')) {
      filter.country = 'Korea';
    }

    if (q.contains('煎') || q.contains('fry')) {
      filter.cookingMethod = 'fry';
    } else if (q.contains('烤') || q.contains('bake')) {
      filter.cookingMethod = 'bake';
    } else if (q.contains('蒸') || q.contains('steam')) {
      filter.cookingMethod = 'steam';
    }

    return filter;
  }
}
