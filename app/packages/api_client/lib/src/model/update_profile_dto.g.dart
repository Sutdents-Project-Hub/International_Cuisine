// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateProfileDto extends UpdateProfileDto {
  @override
  final String? username;
  @override
  final String? avatarUrl;
  @override
  final String? location;
  @override
  final BuiltList<String>? dietaryPreferences;

  factory _$UpdateProfileDto(
          [void Function(UpdateProfileDtoBuilder)? updates]) =>
      (UpdateProfileDtoBuilder()..update(updates))._build();

  _$UpdateProfileDto._(
      {this.username, this.avatarUrl, this.location, this.dietaryPreferences})
      : super._();
  @override
  UpdateProfileDto rebuild(void Function(UpdateProfileDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateProfileDtoBuilder toBuilder() =>
      UpdateProfileDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateProfileDto &&
        username == other.username &&
        avatarUrl == other.avatarUrl &&
        location == other.location &&
        dietaryPreferences == other.dietaryPreferences;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, avatarUrl.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, dietaryPreferences.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateProfileDto')
          ..add('username', username)
          ..add('avatarUrl', avatarUrl)
          ..add('location', location)
          ..add('dietaryPreferences', dietaryPreferences))
        .toString();
  }
}

class UpdateProfileDtoBuilder
    implements Builder<UpdateProfileDto, UpdateProfileDtoBuilder> {
  _$UpdateProfileDto? _$v;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _avatarUrl;
  String? get avatarUrl => _$this._avatarUrl;
  set avatarUrl(String? avatarUrl) => _$this._avatarUrl = avatarUrl;

  String? _location;
  String? get location => _$this._location;
  set location(String? location) => _$this._location = location;

  ListBuilder<String>? _dietaryPreferences;
  ListBuilder<String> get dietaryPreferences =>
      _$this._dietaryPreferences ??= ListBuilder<String>();
  set dietaryPreferences(ListBuilder<String>? dietaryPreferences) =>
      _$this._dietaryPreferences = dietaryPreferences;

  UpdateProfileDtoBuilder() {
    UpdateProfileDto._defaults(this);
  }

  UpdateProfileDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _username = $v.username;
      _avatarUrl = $v.avatarUrl;
      _location = $v.location;
      _dietaryPreferences = $v.dietaryPreferences?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateProfileDto other) {
    _$v = other as _$UpdateProfileDto;
  }

  @override
  void update(void Function(UpdateProfileDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateProfileDto build() => _build();

  _$UpdateProfileDto _build() {
    _$UpdateProfileDto _$result;
    try {
      _$result = _$v ??
          _$UpdateProfileDto._(
            username: username,
            avatarUrl: avatarUrl,
            location: location,
            dietaryPreferences: _dietaryPreferences?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'dietaryPreferences';
        _dietaryPreferences?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'UpdateProfileDto', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
