import '../../../core/api/api_shape.dart';

class RecipeIngredient {
  final String name;
  final double qtyPerServing;
  final String unit;
  final bool optional;
  final String? notes;
  final double? gramEquivalent;
  final String? category;
  final String? scaleStrategy;
  final double? kcalPer100g;

  const RecipeIngredient({
    required this.name,
    required this.qtyPerServing,
    required this.unit,
    required this.optional,
    this.notes,
    this.gramEquivalent,
    this.category,
    this.scaleStrategy,
    this.kcalPer100g,
  });

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) {
    return RecipeIngredient(
      name: ApiShapeGuard.stringOr(json['name'], 'Unknown'),
      qtyPerServing: ApiShapeGuard.doubleOr(
        json['qtyPerServing'] ?? json['qty'] ?? json['totalQty'],
        0,
      ),
      unit: ApiShapeGuard.stringOr(json['unit'], ''),
      optional: ApiShapeGuard.boolOr(json['optional'], false),
      notes: json['notes']?.toString(),
      gramEquivalent: json['gramEquivalent'] == null
          ? null
          : ApiShapeGuard.doubleOr(json['gramEquivalent'], 0),
      category: json['category']?.toString(),
      scaleStrategy: json['scaleStrategy']?.toString(),
      kcalPer100g: json['kcalPer100g'] == null
          ? null
          : ApiShapeGuard.doubleOr(json['kcalPer100g'], 0),
    );
  }

  double get kcalPerGram => (kcalPer100g ?? 0) / 100;
}

class RecipeStep {
  final int order;
  final String description;
  final int? defaultTimerSeconds;
  final String? mediaUrl;

  const RecipeStep({
    required this.order,
    required this.description,
    this.defaultTimerSeconds,
    this.mediaUrl,
  });

  factory RecipeStep.fromJson(Map<String, dynamic> json) {
    return RecipeStep(
      order: ApiShapeGuard.intOr(json['order'], 0),
      description: ApiShapeGuard.stringOr(json['description'], ''),
      defaultTimerSeconds: json['defaultTimerSeconds'] == null
          ? null
          : ApiShapeGuard.intOr(json['defaultTimerSeconds'], 0),
      mediaUrl: json['mediaUrl']?.toString(),
    );
  }
}

class Recipe {
  final String id;
  final String title;
  final List<String> altTitles;
  final String country;
  final String? region;
  final String? city;
  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final int totalTimeMinutes;
  final String difficulty;
  final int servingsBase;
  final int caloriesPerServing;
  final String? imageUrl;
  final int viewCount;
  final int likeCount;
  final int completedCount;
  final double ratingAvg;
  final List<String> cuisineTags;
  final bool isHidden;
  final bool isUnlocked;
  final String? culturalNote;
  final List<RecipeIngredient> ingredients;
  final List<RecipeStep> steps;
  final List<dynamic> unlockConditions;

  const Recipe({
    required this.id,
    required this.title,
    required this.altTitles,
    required this.country,
    this.region,
    this.city,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.totalTimeMinutes,
    required this.difficulty,
    required this.servingsBase,
    required this.caloriesPerServing,
    this.imageUrl,
    required this.viewCount,
    required this.likeCount,
    required this.completedCount,
    required this.ratingAvg,
    required this.cuisineTags,
    required this.isHidden,
    required this.isUnlocked,
    this.culturalNote,
    required this.ingredients,
    required this.steps,
    required this.unlockConditions,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    final ingredientsRaw = (json['ingredients'] as List?) ?? const [];
    final stepsRaw = (json['steps'] as List?) ?? const [];

    return Recipe(
      id: ApiShapeGuard.stringOr(json['id'], ''),
      title: ApiShapeGuard.stringOr(json['title'], 'Untitled'),
      altTitles: ((json['altTitles'] as List?) ?? const [])
          .map((e) => e.toString())
          .toList(growable: false),
      country: ApiShapeGuard.stringOr(json['country'], 'Unknown'),
      region: json['region']?.toString(),
      city: json['city']?.toString(),
      prepTimeMinutes: ApiShapeGuard.intOr(json['prepTimeMinutes'], 0),
      cookTimeMinutes: ApiShapeGuard.intOr(json['cookTimeMinutes'], 0),
      totalTimeMinutes: ApiShapeGuard.intOr(json['totalTimeMinutes'], 0),
      difficulty: ApiShapeGuard.stringOr(json['difficulty'], 'BEGINNER'),
      servingsBase: ApiShapeGuard.intOr(json['servingsBase'], 1),
      caloriesPerServing: ApiShapeGuard.intOr(json['caloriesPerServing'], 0),
      imageUrl: json['imageUrl']?.toString(),
      viewCount: ApiShapeGuard.intOr(json['viewCount'], 0),
      likeCount: ApiShapeGuard.intOr(json['likeCount'], 0),
      completedCount: ApiShapeGuard.intOr(json['completedCount'], 0),
      ratingAvg: ApiShapeGuard.doubleOr(json['ratingAvg'], 0),
      cuisineTags: ((json['cuisineTags'] as List?) ?? const [])
          .map((e) => e.toString())
          .toList(growable: false),
      isHidden: ApiShapeGuard.boolOr(json['isHidden'], false),
      isUnlocked: ApiShapeGuard.boolOr(json['isUnlocked'], true),
      culturalNote: json['culturalNote']?.toString(),
      ingredients: ingredientsRaw
          .map((e) => RecipeIngredient.fromJson(ApiShapeGuard.asMap(e)))
          .toList(growable: false),
      steps: stepsRaw
          .map((e) => RecipeStep.fromJson(ApiShapeGuard.asMap(e)))
          .toList(growable: false),
      unlockConditions: (json['unlockConditions'] as List?) ?? const [],
    );
  }

  Recipe copyWith({
    int? servingsBase,
    List<RecipeIngredient>? ingredients,
    int? caloriesPerServing,
  }) {
    return Recipe(
      id: id,
      title: title,
      altTitles: altTitles,
      country: country,
      region: region,
      city: city,
      prepTimeMinutes: prepTimeMinutes,
      cookTimeMinutes: cookTimeMinutes,
      totalTimeMinutes: totalTimeMinutes,
      difficulty: difficulty,
      servingsBase: servingsBase ?? this.servingsBase,
      caloriesPerServing: caloriesPerServing ?? this.caloriesPerServing,
      imageUrl: imageUrl,
      viewCount: viewCount,
      likeCount: likeCount,
      completedCount: completedCount,
      ratingAvg: ratingAvg,
      cuisineTags: cuisineTags,
      isHidden: isHidden,
      isUnlocked: isUnlocked,
      culturalNote: culturalNote,
      ingredients: ingredients ?? this.ingredients,
      steps: steps,
      unlockConditions: unlockConditions,
    );
  }

  int estimateCaloriesForServings(int servings) {
    if (ingredients.isEmpty) return caloriesPerServing * servings;

    var total = 0.0;
    for (final ingredient in ingredients) {
      if (ingredient.kcalPer100g == null || ingredient.gramEquivalent == null) {
        continue;
      }
      final grams = ingredient.gramEquivalent! * servings;
      total += grams * ingredient.kcalPerGram;
    }
    return total == 0 ? caloriesPerServing * servings : total.round();
  }
}
