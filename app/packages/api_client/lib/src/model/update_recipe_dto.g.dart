// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_recipe_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UpdateRecipeDtoDifficultyEnum _$updateRecipeDtoDifficultyEnum_BEGINNER =
    const UpdateRecipeDtoDifficultyEnum._('BEGINNER');
const UpdateRecipeDtoDifficultyEnum
    _$updateRecipeDtoDifficultyEnum_INTERMEDIATE =
    const UpdateRecipeDtoDifficultyEnum._('INTERMEDIATE');
const UpdateRecipeDtoDifficultyEnum _$updateRecipeDtoDifficultyEnum_ADVANCED =
    const UpdateRecipeDtoDifficultyEnum._('ADVANCED');

UpdateRecipeDtoDifficultyEnum _$updateRecipeDtoDifficultyEnumValueOf(
    String name) {
  switch (name) {
    case 'BEGINNER':
      return _$updateRecipeDtoDifficultyEnum_BEGINNER;
    case 'INTERMEDIATE':
      return _$updateRecipeDtoDifficultyEnum_INTERMEDIATE;
    case 'ADVANCED':
      return _$updateRecipeDtoDifficultyEnum_ADVANCED;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UpdateRecipeDtoDifficultyEnum>
    _$updateRecipeDtoDifficultyEnumValues = BuiltSet<
        UpdateRecipeDtoDifficultyEnum>(const <UpdateRecipeDtoDifficultyEnum>[
  _$updateRecipeDtoDifficultyEnum_BEGINNER,
  _$updateRecipeDtoDifficultyEnum_INTERMEDIATE,
  _$updateRecipeDtoDifficultyEnum_ADVANCED,
]);

Serializer<UpdateRecipeDtoDifficultyEnum>
    _$updateRecipeDtoDifficultyEnumSerializer =
    _$UpdateRecipeDtoDifficultyEnumSerializer();

class _$UpdateRecipeDtoDifficultyEnumSerializer
    implements PrimitiveSerializer<UpdateRecipeDtoDifficultyEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'BEGINNER': 'BEGINNER',
    'INTERMEDIATE': 'INTERMEDIATE',
    'ADVANCED': 'ADVANCED',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'BEGINNER': 'BEGINNER',
    'INTERMEDIATE': 'INTERMEDIATE',
    'ADVANCED': 'ADVANCED',
  };

  @override
  final Iterable<Type> types = const <Type>[UpdateRecipeDtoDifficultyEnum];
  @override
  final String wireName = 'UpdateRecipeDtoDifficultyEnum';

  @override
  Object serialize(
          Serializers serializers, UpdateRecipeDtoDifficultyEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UpdateRecipeDtoDifficultyEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UpdateRecipeDtoDifficultyEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$UpdateRecipeDto extends UpdateRecipeDto {
  @override
  final String? title;
  @override
  final String? country;
  @override
  final String? region;
  @override
  final bool? isHidden;
  @override
  final num? prepTimeMinutes;
  @override
  final num? cookTimeMinutes;
  @override
  final num? totalTimeMinutes;
  @override
  final UpdateRecipeDtoDifficultyEnum? difficulty;
  @override
  final num? caloriesPerServing;
  @override
  final String? culturalNote;

  factory _$UpdateRecipeDto([void Function(UpdateRecipeDtoBuilder)? updates]) =>
      (UpdateRecipeDtoBuilder()..update(updates))._build();

  _$UpdateRecipeDto._(
      {this.title,
      this.country,
      this.region,
      this.isHidden,
      this.prepTimeMinutes,
      this.cookTimeMinutes,
      this.totalTimeMinutes,
      this.difficulty,
      this.caloriesPerServing,
      this.culturalNote})
      : super._();
  @override
  UpdateRecipeDto rebuild(void Function(UpdateRecipeDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateRecipeDtoBuilder toBuilder() => UpdateRecipeDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateRecipeDto &&
        title == other.title &&
        country == other.country &&
        region == other.region &&
        isHidden == other.isHidden &&
        prepTimeMinutes == other.prepTimeMinutes &&
        cookTimeMinutes == other.cookTimeMinutes &&
        totalTimeMinutes == other.totalTimeMinutes &&
        difficulty == other.difficulty &&
        caloriesPerServing == other.caloriesPerServing &&
        culturalNote == other.culturalNote;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, country.hashCode);
    _$hash = $jc(_$hash, region.hashCode);
    _$hash = $jc(_$hash, isHidden.hashCode);
    _$hash = $jc(_$hash, prepTimeMinutes.hashCode);
    _$hash = $jc(_$hash, cookTimeMinutes.hashCode);
    _$hash = $jc(_$hash, totalTimeMinutes.hashCode);
    _$hash = $jc(_$hash, difficulty.hashCode);
    _$hash = $jc(_$hash, caloriesPerServing.hashCode);
    _$hash = $jc(_$hash, culturalNote.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateRecipeDto')
          ..add('title', title)
          ..add('country', country)
          ..add('region', region)
          ..add('isHidden', isHidden)
          ..add('prepTimeMinutes', prepTimeMinutes)
          ..add('cookTimeMinutes', cookTimeMinutes)
          ..add('totalTimeMinutes', totalTimeMinutes)
          ..add('difficulty', difficulty)
          ..add('caloriesPerServing', caloriesPerServing)
          ..add('culturalNote', culturalNote))
        .toString();
  }
}

class UpdateRecipeDtoBuilder
    implements Builder<UpdateRecipeDto, UpdateRecipeDtoBuilder> {
  _$UpdateRecipeDto? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _country;
  String? get country => _$this._country;
  set country(String? country) => _$this._country = country;

  String? _region;
  String? get region => _$this._region;
  set region(String? region) => _$this._region = region;

  bool? _isHidden;
  bool? get isHidden => _$this._isHidden;
  set isHidden(bool? isHidden) => _$this._isHidden = isHidden;

  num? _prepTimeMinutes;
  num? get prepTimeMinutes => _$this._prepTimeMinutes;
  set prepTimeMinutes(num? prepTimeMinutes) =>
      _$this._prepTimeMinutes = prepTimeMinutes;

  num? _cookTimeMinutes;
  num? get cookTimeMinutes => _$this._cookTimeMinutes;
  set cookTimeMinutes(num? cookTimeMinutes) =>
      _$this._cookTimeMinutes = cookTimeMinutes;

  num? _totalTimeMinutes;
  num? get totalTimeMinutes => _$this._totalTimeMinutes;
  set totalTimeMinutes(num? totalTimeMinutes) =>
      _$this._totalTimeMinutes = totalTimeMinutes;

  UpdateRecipeDtoDifficultyEnum? _difficulty;
  UpdateRecipeDtoDifficultyEnum? get difficulty => _$this._difficulty;
  set difficulty(UpdateRecipeDtoDifficultyEnum? difficulty) =>
      _$this._difficulty = difficulty;

  num? _caloriesPerServing;
  num? get caloriesPerServing => _$this._caloriesPerServing;
  set caloriesPerServing(num? caloriesPerServing) =>
      _$this._caloriesPerServing = caloriesPerServing;

  String? _culturalNote;
  String? get culturalNote => _$this._culturalNote;
  set culturalNote(String? culturalNote) => _$this._culturalNote = culturalNote;

  UpdateRecipeDtoBuilder() {
    UpdateRecipeDto._defaults(this);
  }

  UpdateRecipeDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _country = $v.country;
      _region = $v.region;
      _isHidden = $v.isHidden;
      _prepTimeMinutes = $v.prepTimeMinutes;
      _cookTimeMinutes = $v.cookTimeMinutes;
      _totalTimeMinutes = $v.totalTimeMinutes;
      _difficulty = $v.difficulty;
      _caloriesPerServing = $v.caloriesPerServing;
      _culturalNote = $v.culturalNote;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateRecipeDto other) {
    _$v = other as _$UpdateRecipeDto;
  }

  @override
  void update(void Function(UpdateRecipeDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateRecipeDto build() => _build();

  _$UpdateRecipeDto _build() {
    final _$result = _$v ??
        _$UpdateRecipeDto._(
          title: title,
          country: country,
          region: region,
          isHidden: isHidden,
          prepTimeMinutes: prepTimeMinutes,
          cookTimeMinutes: cookTimeMinutes,
          totalTimeMinutes: totalTimeMinutes,
          difficulty: difficulty,
          caloriesPerServing: caloriesPerServing,
          culturalNote: culturalNote,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
