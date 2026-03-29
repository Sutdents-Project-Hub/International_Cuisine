// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unlock_condition_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UnlockConditionDto extends UnlockConditionDto {
  @override
  final String conditionType;
  @override
  final JsonObject conditionData;
  @override
  final String description;

  factory _$UnlockConditionDto(
          [void Function(UnlockConditionDtoBuilder)? updates]) =>
      (UnlockConditionDtoBuilder()..update(updates))._build();

  _$UnlockConditionDto._(
      {required this.conditionType,
      required this.conditionData,
      required this.description})
      : super._();
  @override
  UnlockConditionDto rebuild(
          void Function(UnlockConditionDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UnlockConditionDtoBuilder toBuilder() =>
      UnlockConditionDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UnlockConditionDto &&
        conditionType == other.conditionType &&
        conditionData == other.conditionData &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, conditionType.hashCode);
    _$hash = $jc(_$hash, conditionData.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UnlockConditionDto')
          ..add('conditionType', conditionType)
          ..add('conditionData', conditionData)
          ..add('description', description))
        .toString();
  }
}

class UnlockConditionDtoBuilder
    implements Builder<UnlockConditionDto, UnlockConditionDtoBuilder> {
  _$UnlockConditionDto? _$v;

  String? _conditionType;
  String? get conditionType => _$this._conditionType;
  set conditionType(String? conditionType) =>
      _$this._conditionType = conditionType;

  JsonObject? _conditionData;
  JsonObject? get conditionData => _$this._conditionData;
  set conditionData(JsonObject? conditionData) =>
      _$this._conditionData = conditionData;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  UnlockConditionDtoBuilder() {
    UnlockConditionDto._defaults(this);
  }

  UnlockConditionDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _conditionType = $v.conditionType;
      _conditionData = $v.conditionData;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UnlockConditionDto other) {
    _$v = other as _$UnlockConditionDto;
  }

  @override
  void update(void Function(UnlockConditionDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UnlockConditionDto build() => _build();

  _$UnlockConditionDto _build() {
    final _$result = _$v ??
        _$UnlockConditionDto._(
          conditionType: BuiltValueNullFieldError.checkNotNull(
              conditionType, r'UnlockConditionDto', 'conditionType'),
          conditionData: BuiltValueNullFieldError.checkNotNull(
              conditionData, r'UnlockConditionDto', 'conditionData'),
          description: BuiltValueNullFieldError.checkNotNull(
              description, r'UnlockConditionDto', 'description'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
