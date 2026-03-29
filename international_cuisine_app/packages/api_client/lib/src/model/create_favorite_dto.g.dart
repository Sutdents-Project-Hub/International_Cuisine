// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_favorite_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateFavoriteDto extends CreateFavoriteDto {
  @override
  final String recipeId;
  @override
  final String? categoryName;

  factory _$CreateFavoriteDto(
          [void Function(CreateFavoriteDtoBuilder)? updates]) =>
      (CreateFavoriteDtoBuilder()..update(updates))._build();

  _$CreateFavoriteDto._({required this.recipeId, this.categoryName})
      : super._();
  @override
  CreateFavoriteDto rebuild(void Function(CreateFavoriteDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateFavoriteDtoBuilder toBuilder() =>
      CreateFavoriteDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateFavoriteDto &&
        recipeId == other.recipeId &&
        categoryName == other.categoryName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, recipeId.hashCode);
    _$hash = $jc(_$hash, categoryName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateFavoriteDto')
          ..add('recipeId', recipeId)
          ..add('categoryName', categoryName))
        .toString();
  }
}

class CreateFavoriteDtoBuilder
    implements Builder<CreateFavoriteDto, CreateFavoriteDtoBuilder> {
  _$CreateFavoriteDto? _$v;

  String? _recipeId;
  String? get recipeId => _$this._recipeId;
  set recipeId(String? recipeId) => _$this._recipeId = recipeId;

  String? _categoryName;
  String? get categoryName => _$this._categoryName;
  set categoryName(String? categoryName) => _$this._categoryName = categoryName;

  CreateFavoriteDtoBuilder() {
    CreateFavoriteDto._defaults(this);
  }

  CreateFavoriteDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _recipeId = $v.recipeId;
      _categoryName = $v.categoryName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateFavoriteDto other) {
    _$v = other as _$CreateFavoriteDto;
  }

  @override
  void update(void Function(CreateFavoriteDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateFavoriteDto build() => _build();

  _$CreateFavoriteDto _build() {
    final _$result = _$v ??
        _$CreateFavoriteDto._(
          recipeId: BuiltValueNullFieldError.checkNotNull(
              recipeId, r'CreateFavoriteDto', 'recipeId'),
          categoryName: categoryName,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
