class IngredientUnitNormalizer {
  static ({double value, String unit}) normalize(double qty, String unit) {
    final u = unit.toLowerCase();

    if (u == 'kg') {
      return (value: qty * 1000, unit: 'g');
    }
    if (u == 'l') {
      return (value: qty * 1000, unit: 'ml');
    }
    return (value: qty, unit: unit);
  }
}
