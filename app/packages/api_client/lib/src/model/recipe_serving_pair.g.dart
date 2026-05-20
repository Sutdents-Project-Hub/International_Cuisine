// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_serving_pair.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RecipeServingPair extends RecipeServingPair {
  @override
  final String recipeId;
  @override
  final num servings;

  factory _$RecipeServingPair(
          [void Function(RecipeServingPairBuilder)? updates]) =>
      (RecipeServingPairBuilder()..update(updates))._build();

  _$RecipeServingPair._({required this.recipeId, required this.servings})
      : super._();
  @override
  RecipeServingPair rebuild(void Function(RecipeServingPairBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RecipeServingPairBuilder toBuilder() =>
      RecipeServingPairBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RecipeServingPair &&
        recipeId == other.recipeId &&
        servings == other.servings;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, recipeId.hashCode);
    _$hash = $jc(_$hash, servings.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RecipeServingPair')
          ..add('recipeId', recipeId)
          ..add('servings', servings))
        .toString();
  }
}

class RecipeServingPairBuilder
    implements Builder<RecipeServingPair, RecipeServingPairBuilder> {
  _$RecipeServingPair? _$v;

  String? _recipeId;
  String? get recipeId => _$this._recipeId;
  set recipeId(String? recipeId) => _$this._recipeId = recipeId;

  num? _servings;
  num? get servings => _$this._servings;
  set servings(num? servings) => _$this._servings = servings;

  RecipeServingPairBuilder() {
    RecipeServingPair._defaults(this);
  }

  RecipeServingPairBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _recipeId = $v.recipeId;
      _servings = $v.servings;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RecipeServingPair other) {
    _$v = other as _$RecipeServingPair;
  }

  @override
  void update(void Function(RecipeServingPairBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RecipeServingPair build() => _build();

  _$RecipeServingPair _build() {
    final _$result = _$v ??
        _$RecipeServingPair._(
          recipeId: BuiltValueNullFieldError.checkNotNull(
              recipeId, r'RecipeServingPair', 'recipeId'),
          servings: BuiltValueNullFieldError.checkNotNull(
              servings, r'RecipeServingPair', 'servings'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
