class RecipeFilter {
  String? search;
  String? country;
  String? continent;
  String? difficulty;
  String? diet;
  int? maxTime;
  int? maxIngredients;
  int? maxCalories;
  String? cookingMethod;
  bool showHidden;

  RecipeFilter({
    this.search,
    this.country,
    this.continent,
    this.difficulty,
    this.diet,
    this.maxTime,
    this.maxIngredients,
    this.maxCalories,
    this.cookingMethod,
    this.showHidden = true,
  });

  RecipeFilter copyWith({
    String? search,
    String? country,
    String? continent,
    String? difficulty,
    String? diet,
    int? maxTime,
    int? maxIngredients,
    int? maxCalories,
    String? cookingMethod,
    bool? showHidden,
  }) {
    return RecipeFilter(
      search: search ?? this.search,
      country: country ?? this.country,
      continent: continent ?? this.continent,
      difficulty: difficulty ?? this.difficulty,
      diet: diet ?? this.diet,
      maxTime: maxTime ?? this.maxTime,
      maxIngredients: maxIngredients ?? this.maxIngredients,
      maxCalories: maxCalories ?? this.maxCalories,
      cookingMethod: cookingMethod ?? this.cookingMethod,
      showHidden: showHidden ?? this.showHidden,
    );
  }

  void clear() {
    search = null;
    country = null;
    continent = null;
    difficulty = null;
    diet = null;
    maxTime = null;
    maxIngredients = null;
    maxCalories = null;
    cookingMethod = null;
    showHidden = true;
  }
}
