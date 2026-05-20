// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_rating_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateRatingDto extends CreateRatingDto {
  @override
  final num score;
  @override
  final String? comment;

  factory _$CreateRatingDto([void Function(CreateRatingDtoBuilder)? updates]) =>
      (CreateRatingDtoBuilder()..update(updates))._build();

  _$CreateRatingDto._({required this.score, this.comment}) : super._();
  @override
  CreateRatingDto rebuild(void Function(CreateRatingDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateRatingDtoBuilder toBuilder() => CreateRatingDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateRatingDto &&
        score == other.score &&
        comment == other.comment;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, score.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateRatingDto')
          ..add('score', score)
          ..add('comment', comment))
        .toString();
  }
}

class CreateRatingDtoBuilder
    implements Builder<CreateRatingDto, CreateRatingDtoBuilder> {
  _$CreateRatingDto? _$v;

  num? _score;
  num? get score => _$this._score;
  set score(num? score) => _$this._score = score;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  CreateRatingDtoBuilder() {
    CreateRatingDto._defaults(this);
  }

  CreateRatingDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _score = $v.score;
      _comment = $v.comment;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateRatingDto other) {
    _$v = other as _$CreateRatingDto;
  }

  @override
  void update(void Function(CreateRatingDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateRatingDto build() => _build();

  _$CreateRatingDto _build() {
    final _$result = _$v ??
        _$CreateRatingDto._(
          score: BuiltValueNullFieldError.checkNotNull(
              score, r'CreateRatingDto', 'score'),
          comment: comment,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
