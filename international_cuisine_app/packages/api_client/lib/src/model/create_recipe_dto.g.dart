// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_recipe_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateRecipeDtoDifficultyEnum _$createRecipeDtoDifficultyEnum_BEGINNER =
    const CreateRecipeDtoDifficultyEnum._('BEGINNER');
const CreateRecipeDtoDifficultyEnum
    _$createRecipeDtoDifficultyEnum_INTERMEDIATE =
    const CreateRecipeDtoDifficultyEnum._('INTERMEDIATE');
const CreateRecipeDtoDifficultyEnum _$createRecipeDtoDifficultyEnum_ADVANCED =
    const CreateRecipeDtoDifficultyEnum._('ADVANCED');

CreateRecipeDtoDifficultyEnum _$createRecipeDtoDifficultyEnumValueOf(
    String name) {
  switch (name) {
    case 'BEGINNER':
      return _$createRecipeDtoDifficultyEnum_BEGINNER;
    case 'INTERMEDIATE':
      return _$createRecipeDtoDifficultyEnum_INTERMEDIATE;
    case 'ADVANCED':
      return _$createRecipeDtoDifficultyEnum_ADVANCED;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateRecipeDtoDifficultyEnum>
    _$createRecipeDtoDifficultyEnumValues = BuiltSet<
        CreateRecipeDtoDifficultyEnum>(const <CreateRecipeDtoDifficultyEnum>[
  _$createRecipeDtoDifficultyEnum_BEGINNER,
  _$createRecipeDtoDifficultyEnum_INTERMEDIATE,
  _$createRecipeDtoDifficultyEnum_ADVANCED,
]);

Serializer<CreateRecipeDtoDifficultyEnum>
    _$createRecipeDtoDifficultyEnumSerializer =
    _$CreateRecipeDtoDifficultyEnumSerializer();

class _$CreateRecipeDtoDifficultyEnumSerializer
    implements PrimitiveSerializer<CreateRecipeDtoDifficultyEnum> {
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
  final Iterable<Type> types = const <Type>[CreateRecipeDtoDifficultyEnum];
  @override
  final String wireName = 'CreateRecipeDtoDifficultyEnum';

  @override
  Object serialize(
          Serializers serializers, CreateRecipeDtoDifficultyEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CreateRecipeDtoDifficultyEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CreateRecipeDtoDifficultyEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CreateRecipeDto extends CreateRecipeDto {
  @override
  final String title;
  @override
  final BuiltList<String>? altTitles;
  @override
  final String country;
  @override
  final String? region;
  @override
  final String? city;
  @override
  final BuiltList<String>? cuisineTags;
  @override
  final bool? isHidden;
  @override
  final num prepTimeMinutes;
  @override
  final num cookTimeMinutes;
  @override
  final num totalTimeMinutes;
  @override
  final CreateRecipeDtoDifficultyEnum difficulty;
  @override
  final num? servingsBase;
  @override
  final num? caloriesPerServing;
  @override
  final String? culturalNote;
  @override
  final BuiltList<IngredientDto> ingredients;
  @override
  final BuiltList<StepDto> steps;
  @override
  final BuiltList<UnlockConditionDto>? unlockConditions;

  factory _$CreateRecipeDto([void Function(CreateRecipeDtoBuilder)? updates]) =>
      (CreateRecipeDtoBuilder()..update(updates))._build();

  _$CreateRecipeDto._(
      {required this.title,
      this.altTitles,
      required this.country,
      this.region,
      this.city,
      this.cuisineTags,
      this.isHidden,
      required this.prepTimeMinutes,
      required this.cookTimeMinutes,
      required this.totalTimeMinutes,
      required this.difficulty,
      this.servingsBase,
      this.caloriesPerServing,
      this.culturalNote,
      required this.ingredients,
      required this.steps,
      this.unlockConditions})
      : super._();
  @override
  CreateRecipeDto rebuild(void Function(CreateRecipeDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateRecipeDtoBuilder toBuilder() => CreateRecipeDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateRecipeDto &&
        title == other.title &&
        altTitles == other.altTitles &&
        country == other.country &&
        region == other.region &&
        city == other.city &&
        cuisineTags == other.cuisineTags &&
        isHidden == other.isHidden &&
        prepTimeMinutes == other.prepTimeMinutes &&
        cookTimeMinutes == other.cookTimeMinutes &&
        totalTimeMinutes == other.totalTimeMinutes &&
        difficulty == other.difficulty &&
        servingsBase == other.servingsBase &&
        caloriesPerServing == other.caloriesPerServing &&
        culturalNote == other.culturalNote &&
        ingredients == other.ingredients &&
        steps == other.steps &&
        unlockConditions == other.unlockConditions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, altTitles.hashCode);
    _$hash = $jc(_$hash, country.hashCode);
    _$hash = $jc(_$hash, region.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, cuisineTags.hashCode);
    _$hash = $jc(_$hash, isHidden.hashCode);
    _$hash = $jc(_$hash, prepTimeMinutes.hashCode);
    _$hash = $jc(_$hash, cookTimeMinutes.hashCode);
    _$hash = $jc(_$hash, totalTimeMinutes.hashCode);
    _$hash = $jc(_$hash, difficulty.hashCode);
    _$hash = $jc(_$hash, servingsBase.hashCode);
    _$hash = $jc(_$hash, caloriesPerServing.hashCode);
    _$hash = $jc(_$hash, culturalNote.hashCode);
    _$hash = $jc(_$hash, ingredients.hashCode);
    _$hash = $jc(_$hash, steps.hashCode);
    _$hash = $jc(_$hash, unlockConditions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateRecipeDto')
          ..add('title', title)
          ..add('altTitles', altTitles)
          ..add('country', country)
          ..add('region', region)
          ..add('city', city)
          ..add('cuisineTags', cuisineTags)
          ..add('isHidden', isHidden)
          ..add('prepTimeMinutes', prepTimeMinutes)
          ..add('cookTimeMinutes', cookTimeMinutes)
          ..add('totalTimeMinutes', totalTimeMinutes)
          ..add('difficulty', difficulty)
          ..add('servingsBase', servingsBase)
          ..add('caloriesPerServing', caloriesPerServing)
          ..add('culturalNote', culturalNote)
          ..add('ingredients', ingredients)
          ..add('steps', steps)
          ..add('unlockConditions', unlockConditions))
        .toString();
  }
}

class CreateRecipeDtoBuilder
    implements Builder<CreateRecipeDto, CreateRecipeDtoBuilder> {
  _$CreateRecipeDto? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  ListBuilder<String>? _altTitles;
  ListBuilder<String> get altTitles =>
      _$this._altTitles ??= ListBuilder<String>();
  set altTitles(ListBuilder<String>? altTitles) =>
      _$this._altTitles = altTitles;

  String? _country;
  String? get country => _$this._country;
  set country(String? country) => _$this._country = country;

  String? _region;
  String? get region => _$this._region;
  set region(String? region) => _$this._region = region;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  ListBuilder<String>? _cuisineTags;
  ListBuilder<String> get cuisineTags =>
      _$this._cuisineTags ??= ListBuilder<String>();
  set cuisineTags(ListBuilder<String>? cuisineTags) =>
      _$this._cuisineTags = cuisineTags;

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

  CreateRecipeDtoDifficultyEnum? _difficulty;
  CreateRecipeDtoDifficultyEnum? get difficulty => _$this._difficulty;
  set difficulty(CreateRecipeDtoDifficultyEnum? difficulty) =>
      _$this._difficulty = difficulty;

  num? _servingsBase;
  num? get servingsBase => _$this._servingsBase;
  set servingsBase(num? servingsBase) => _$this._servingsBase = servingsBase;

  num? _caloriesPerServing;
  num? get caloriesPerServing => _$this._caloriesPerServing;
  set caloriesPerServing(num? caloriesPerServing) =>
      _$this._caloriesPerServing = caloriesPerServing;

  String? _culturalNote;
  String? get culturalNote => _$this._culturalNote;
  set culturalNote(String? culturalNote) => _$this._culturalNote = culturalNote;

  ListBuilder<IngredientDto>? _ingredients;
  ListBuilder<IngredientDto> get ingredients =>
      _$this._ingredients ??= ListBuilder<IngredientDto>();
  set ingredients(ListBuilder<IngredientDto>? ingredients) =>
      _$this._ingredients = ingredients;

  ListBuilder<StepDto>? _steps;
  ListBuilder<StepDto> get steps => _$this._steps ??= ListBuilder<StepDto>();
  set steps(ListBuilder<StepDto>? steps) => _$this._steps = steps;

  ListBuilder<UnlockConditionDto>? _unlockConditions;
  ListBuilder<UnlockConditionDto> get unlockConditions =>
      _$this._unlockConditions ??= ListBuilder<UnlockConditionDto>();
  set unlockConditions(ListBuilder<UnlockConditionDto>? unlockConditions) =>
      _$this._unlockConditions = unlockConditions;

  CreateRecipeDtoBuilder() {
    CreateRecipeDto._defaults(this);
  }

  CreateRecipeDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _altTitles = $v.altTitles?.toBuilder();
      _country = $v.country;
      _region = $v.region;
      _city = $v.city;
      _cuisineTags = $v.cuisineTags?.toBuilder();
      _isHidden = $v.isHidden;
      _prepTimeMinutes = $v.prepTimeMinutes;
      _cookTimeMinutes = $v.cookTimeMinutes;
      _totalTimeMinutes = $v.totalTimeMinutes;
      _difficulty = $v.difficulty;
      _servingsBase = $v.servingsBase;
      _caloriesPerServing = $v.caloriesPerServing;
      _culturalNote = $v.culturalNote;
      _ingredients = $v.ingredients.toBuilder();
      _steps = $v.steps.toBuilder();
      _unlockConditions = $v.unlockConditions?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateRecipeDto other) {
    _$v = other as _$CreateRecipeDto;
  }

  @override
  void update(void Function(CreateRecipeDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateRecipeDto build() => _build();

  _$CreateRecipeDto _build() {
    _$CreateRecipeDto _$result;
    try {
      _$result = _$v ??
          _$CreateRecipeDto._(
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'CreateRecipeDto', 'title'),
            altTitles: _altTitles?.build(),
            country: BuiltValueNullFieldError.checkNotNull(
                country, r'CreateRecipeDto', 'country'),
            region: region,
            city: city,
            cuisineTags: _cuisineTags?.build(),
            isHidden: isHidden,
            prepTimeMinutes: BuiltValueNullFieldError.checkNotNull(
                prepTimeMinutes, r'CreateRecipeDto', 'prepTimeMinutes'),
            cookTimeMinutes: BuiltValueNullFieldError.checkNotNull(
                cookTimeMinutes, r'CreateRecipeDto', 'cookTimeMinutes'),
            totalTimeMinutes: BuiltValueNullFieldError.checkNotNull(
                totalTimeMinutes, r'CreateRecipeDto', 'totalTimeMinutes'),
            difficulty: BuiltValueNullFieldError.checkNotNull(
                difficulty, r'CreateRecipeDto', 'difficulty'),
            servingsBase: servingsBase,
            caloriesPerServing: caloriesPerServing,
            culturalNote: culturalNote,
            ingredients: ingredients.build(),
            steps: steps.build(),
            unlockConditions: _unlockConditions?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'altTitles';
        _altTitles?.build();

        _$failedField = 'cuisineTags';
        _cuisineTags?.build();

        _$failedField = 'ingredients';
        ingredients.build();
        _$failedField = 'steps';
        steps.build();
        _$failedField = 'unlockConditions';
        _unlockConditions?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'CreateRecipeDto', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
