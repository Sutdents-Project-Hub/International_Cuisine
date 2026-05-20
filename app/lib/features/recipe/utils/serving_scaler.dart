class ServingScaler {
  static double scale({
    required double baseQtyPerServing,
    required int targetServings,
    required String strategy,
  }) {
    final raw = baseQtyPerServing * targetServings;
    switch (strategy.toUpperCase()) {
      case 'CLAMPED':
        return raw
            .clamp(0, baseQtyPerServing * targetServings * 1.2)
            .toDouble();
      case 'MIN_UNIT':
        return _roundToPracticalUnit(raw);
      case 'LINEAR':
      default:
        return raw;
    }
  }

  static double _roundToPracticalUnit(double value) {
    if (value < 1) {
      // 0.25 tsp like smallest practical step.
      return (value / 0.25).round() * 0.25;
    }
    return (value * 10).round() / 10;
  }
}
