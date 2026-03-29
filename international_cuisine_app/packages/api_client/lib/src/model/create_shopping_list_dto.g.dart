// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_shopping_list_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateShoppingListDto extends CreateShoppingListDto {
  @override
  final String? title;
  @override
  final BuiltList<RecipeServingPair> recipes;

  factory _$CreateShoppingListDto(
          [void Function(CreateShoppingListDtoBuilder)? updates]) =>
      (CreateShoppingListDtoBuilder()..update(updates))._build();

  _$CreateShoppingListDto._({this.title, required this.recipes}) : super._();
  @override
  CreateShoppingListDto rebuild(
          void Function(CreateShoppingListDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateShoppingListDtoBuilder toBuilder() =>
      CreateShoppingListDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateShoppingListDto &&
        title == other.title &&
        recipes == other.recipes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, recipes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateShoppingListDto')
          ..add('title', title)
          ..add('recipes', recipes))
        .toString();
  }
}

class CreateShoppingListDtoBuilder
    implements Builder<CreateShoppingListDto, CreateShoppingListDtoBuilder> {
  _$CreateShoppingListDto? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  ListBuilder<RecipeServingPair>? _recipes;
  ListBuilder<RecipeServingPair> get recipes =>
      _$this._recipes ??= ListBuilder<RecipeServingPair>();
  set recipes(ListBuilder<RecipeServingPair>? recipes) =>
      _$this._recipes = recipes;

  CreateShoppingListDtoBuilder() {
    CreateShoppingListDto._defaults(this);
  }

  CreateShoppingListDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _recipes = $v.recipes.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateShoppingListDto other) {
    _$v = other as _$CreateShoppingListDto;
  }

  @override
  void update(void Function(CreateShoppingListDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateShoppingListDto build() => _build();

  _$CreateShoppingListDto _build() {
    _$CreateShoppingListDto _$result;
    try {
      _$result = _$v ??
          _$CreateShoppingListDto._(
            title: title,
            recipes: recipes.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'recipes';
        recipes.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'CreateShoppingListDto', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
