// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_rating_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateRatingDto extends UpdateRatingDto {
  @override
  final num? score;
  @override
  final String? comment;

  factory _$UpdateRatingDto([void Function(UpdateRatingDtoBuilder)? updates]) =>
      (UpdateRatingDtoBuilder()..update(updates))._build();

  _$UpdateRatingDto._({this.score, this.comment}) : super._();
  @override
  UpdateRatingDto rebuild(void Function(UpdateRatingDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateRatingDtoBuilder toBuilder() => UpdateRatingDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateRatingDto &&
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
    return (newBuiltValueToStringHelper(r'UpdateRatingDto')
          ..add('score', score)
          ..add('comment', comment))
        .toString();
  }
}

class UpdateRatingDtoBuilder
    implements Builder<UpdateRatingDto, UpdateRatingDtoBuilder> {
  _$UpdateRatingDto? _$v;

  num? _score;
  num? get score => _$this._score;
  set score(num? score) => _$this._score = score;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  UpdateRatingDtoBuilder() {
    UpdateRatingDto._defaults(this);
  }

  UpdateRatingDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _score = $v.score;
      _comment = $v.comment;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateRatingDto other) {
    _$v = other as _$UpdateRatingDto;
  }

  @override
  void update(void Function(UpdateRatingDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateRatingDto build() => _build();

  _$UpdateRatingDto _build() {
    final _$result = _$v ??
        _$UpdateRatingDto._(
          score: score,
          comment: comment,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
