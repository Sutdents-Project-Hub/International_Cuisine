import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:international_cuisine/features/recipe/models/recipe.dart';
import 'package:international_cuisine/features/recipe/widgets/recipe_card.dart';

void main() {
  testWidgets('RecipeCard smoke test', (WidgetTester tester) async {
    final recipe = Recipe(
      id: 'r1',
      title: 'Taiwanese Beef Noodle Soup',
      altTitles: const [],
      country: 'Taiwan',
      region: 'Asia',
      city: 'Taipei',
      prepTimeMinutes: 20,
      cookTimeMinutes: 40,
      totalTimeMinutes: 60,
      difficulty: 'BEGINNER',
      servingsBase: 2,
      caloriesPerServing: 480,
      imageUrl: null,
      viewCount: 12,
      likeCount: 3,
      completedCount: 0,
      ratingAvg: 4.5,
      cuisineTags: const ['soup'],
      isHidden: false,
      isUnlocked: true,
      culturalNote: null,
      ingredients: const [],
      steps: const [],
      unlockConditions: const [],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RecipeCard(recipe: recipe, onTap: () {}),
        ),
      ),
    );

    expect(find.text('Taiwanese Beef Noodle Soup'), findsOneWidget);
    expect(find.text('Taiwan'), findsOneWidget);
  });
}
