// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StepDto extends StepDto {
  @override
  final num order;
  @override
  final String description;
  @override
  final num? defaultTimerSeconds;
  @override
  final String? mediaUrl;

  factory _$StepDto([void Function(StepDtoBuilder)? updates]) =>
      (StepDtoBuilder()..update(updates))._build();

  _$StepDto._(
      {required this.order,
      required this.description,
      this.defaultTimerSeconds,
      this.mediaUrl})
      : super._();
  @override
  StepDto rebuild(void Function(StepDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StepDtoBuilder toBuilder() => StepDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StepDto &&
        order == other.order &&
        description == other.description &&
        defaultTimerSeconds == other.defaultTimerSeconds &&
        mediaUrl == other.mediaUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, order.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, defaultTimerSeconds.hashCode);
    _$hash = $jc(_$hash, mediaUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StepDto')
          ..add('order', order)
          ..add('description', description)
          ..add('defaultTimerSeconds', defaultTimerSeconds)
          ..add('mediaUrl', mediaUrl))
        .toString();
  }
}

class StepDtoBuilder implements Builder<StepDto, StepDtoBuilder> {
  _$StepDto? _$v;

  num? _order;
  num? get order => _$this._order;
  set order(num? order) => _$this._order = order;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  num? _defaultTimerSeconds;
  num? get defaultTimerSeconds => _$this._defaultTimerSeconds;
  set defaultTimerSeconds(num? defaultTimerSeconds) =>
      _$this._defaultTimerSeconds = defaultTimerSeconds;

  String? _mediaUrl;
  String? get mediaUrl => _$this._mediaUrl;
  set mediaUrl(String? mediaUrl) => _$this._mediaUrl = mediaUrl;

  StepDtoBuilder() {
    StepDto._defaults(this);
  }

  StepDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _order = $v.order;
      _description = $v.description;
      _defaultTimerSeconds = $v.defaultTimerSeconds;
      _mediaUrl = $v.mediaUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StepDto other) {
    _$v = other as _$StepDto;
  }

  @override
  void update(void Function(StepDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StepDto build() => _build();

  _$StepDto _build() {
    final _$result = _$v ??
        _$StepDto._(
          order:
              BuiltValueNullFieldError.checkNotNull(order, r'StepDto', 'order'),
          description: BuiltValueNullFieldError.checkNotNull(
              description, r'StepDto', 'description'),
          defaultTimerSeconds: defaultTimerSeconds,
          mediaUrl: mediaUrl,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
