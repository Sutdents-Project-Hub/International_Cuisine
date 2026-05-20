// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const IngredientDtoCategoryEnum _$ingredientDtoCategoryEnum_VEGETABLE =
    const IngredientDtoCategoryEnum._('VEGETABLE');
const IngredientDtoCategoryEnum _$ingredientDtoCategoryEnum_MEAT =
    const IngredientDtoCategoryEnum._('MEAT');
const IngredientDtoCategoryEnum _$ingredientDtoCategoryEnum_DRY_GOODS =
    const IngredientDtoCategoryEnum._('DRY_GOODS');
const IngredientDtoCategoryEnum _$ingredientDtoCategoryEnum_SEASONING =
    const IngredientDtoCategoryEnum._('SEASONING');
const IngredientDtoCategoryEnum _$ingredientDtoCategoryEnum_REFRIGERATED =
    const IngredientDtoCategoryEnum._('REFRIGERATED');
const IngredientDtoCategoryEnum _$ingredientDtoCategoryEnum_OTHER =
    const IngredientDtoCategoryEnum._('OTHER');

IngredientDtoCategoryEnum _$ingredientDtoCategoryEnumValueOf(String name) {
  switch (name) {
    case 'VEGETABLE':
      return _$ingredientDtoCategoryEnum_VEGETABLE;
    case 'MEAT':
      return _$ingredientDtoCategoryEnum_MEAT;
    case 'DRY_GOODS':
      return _$ingredientDtoCategoryEnum_DRY_GOODS;
    case 'SEASONING':
      return _$ingredientDtoCategoryEnum_SEASONING;
    case 'REFRIGERATED':
      return _$ingredientDtoCategoryEnum_REFRIGERATED;
    case 'OTHER':
      return _$ingredientDtoCategoryEnum_OTHER;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<IngredientDtoCategoryEnum> _$ingredientDtoCategoryEnumValues =
    BuiltSet<IngredientDtoCategoryEnum>(const <IngredientDtoCategoryEnum>[
  _$ingredientDtoCategoryEnum_VEGETABLE,
  _$ingredientDtoCategoryEnum_MEAT,
  _$ingredientDtoCategoryEnum_DRY_GOODS,
  _$ingredientDtoCategoryEnum_SEASONING,
  _$ingredientDtoCategoryEnum_REFRIGERATED,
  _$ingredientDtoCategoryEnum_OTHER,
]);

const IngredientDtoScaleStrategyEnum _$ingredientDtoScaleStrategyEnum_LINEAR =
    const IngredientDtoScaleStrategyEnum._('LINEAR');
const IngredientDtoScaleStrategyEnum _$ingredientDtoScaleStrategyEnum_CLAMPED =
    const IngredientDtoScaleStrategyEnum._('CLAMPED');
const IngredientDtoScaleStrategyEnum _$ingredientDtoScaleStrategyEnum_MIN_UNIT =
    const IngredientDtoScaleStrategyEnum._('MIN_UNIT');

IngredientDtoScaleStrategyEnum _$ingredientDtoScaleStrategyEnumValueOf(
    String name) {
  switch (name) {
    case 'LINEAR':
      return _$ingredientDtoScaleStrategyEnum_LINEAR;
    case 'CLAMPED':
      return _$ingredientDtoScaleStrategyEnum_CLAMPED;
    case 'MIN_UNIT':
      return _$ingredientDtoScaleStrategyEnum_MIN_UNIT;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<IngredientDtoScaleStrategyEnum>
    _$ingredientDtoScaleStrategyEnumValues = BuiltSet<
        IngredientDtoScaleStrategyEnum>(const <IngredientDtoScaleStrategyEnum>[
  _$ingredientDtoScaleStrategyEnum_LINEAR,
  _$ingredientDtoScaleStrategyEnum_CLAMPED,
  _$ingredientDtoScaleStrategyEnum_MIN_UNIT,
]);

Serializer<IngredientDtoCategoryEnum> _$ingredientDtoCategoryEnumSerializer =
    _$IngredientDtoCategoryEnumSerializer();
Serializer<IngredientDtoScaleStrategyEnum>
    _$ingredientDtoScaleStrategyEnumSerializer =
    _$IngredientDtoScaleStrategyEnumSerializer();

class _$IngredientDtoCategoryEnumSerializer
    implements PrimitiveSerializer<IngredientDtoCategoryEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'VEGETABLE': 'VEGETABLE',
    'MEAT': 'MEAT',
    'DRY_GOODS': 'DRY_GOODS',
    'SEASONING': 'SEASONING',
    'REFRIGERATED': 'REFRIGERATED',
    'OTHER': 'OTHER',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'VEGETABLE': 'VEGETABLE',
    'MEAT': 'MEAT',
    'DRY_GOODS': 'DRY_GOODS',
    'SEASONING': 'SEASONING',
    'REFRIGERATED': 'REFRIGERATED',
    'OTHER': 'OTHER',
  };

  @override
  final Iterable<Type> types = const <Type>[IngredientDtoCategoryEnum];
  @override
  final String wireName = 'IngredientDtoCategoryEnum';

  @override
  Object serialize(Serializers serializers, IngredientDtoCategoryEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  IngredientDtoCategoryEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      IngredientDtoCategoryEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$IngredientDtoScaleStrategyEnumSerializer
    implements PrimitiveSerializer<IngredientDtoScaleStrategyEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'LINEAR': 'LINEAR',
    'CLAMPED': 'CLAMPED',
    'MIN_UNIT': 'MIN_UNIT',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'LINEAR': 'LINEAR',
    'CLAMPED': 'CLAMPED',
    'MIN_UNIT': 'MIN_UNIT',
  };

  @override
  final Iterable<Type> types = const <Type>[IngredientDtoScaleStrategyEnum];
  @override
  final String wireName = 'IngredientDtoScaleStrategyEnum';

  @override
  Object serialize(
          Serializers serializers, IngredientDtoScaleStrategyEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  IngredientDtoScaleStrategyEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      IngredientDtoScaleStrategyEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$IngredientDto extends IngredientDto {
  @override
  final String name;
  @override
  final num qtyPerServing;
  @override
  final String unit;
  @override
  final bool? optional;
  @override
  final String? notes;
  @override
  final num? gramEquivalent;
  @override
  final IngredientDtoCategoryEnum? category;
  @override
  final IngredientDtoScaleStrategyEnum? scaleStrategy;
  @override
  final num? kcalPer100g;

  factory _$IngredientDto([void Function(IngredientDtoBuilder)? updates]) =>
      (IngredientDtoBuilder()..update(updates))._build();

  _$IngredientDto._(
      {required this.name,
      required this.qtyPerServing,
      required this.unit,
      this.optional,
      this.notes,
      this.gramEquivalent,
      this.category,
      this.scaleStrategy,
      this.kcalPer100g})
      : super._();
  @override
  IngredientDto rebuild(void Function(IngredientDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  IngredientDtoBuilder toBuilder() => IngredientDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IngredientDto &&
        name == other.name &&
        qtyPerServing == other.qtyPerServing &&
        unit == other.unit &&
        optional == other.optional &&
        notes == other.notes &&
        gramEquivalent == other.gramEquivalent &&
        category == other.category &&
        scaleStrategy == other.scaleStrategy &&
        kcalPer100g == other.kcalPer100g;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, qtyPerServing.hashCode);
    _$hash = $jc(_$hash, unit.hashCode);
    _$hash = $jc(_$hash, optional.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jc(_$hash, gramEquivalent.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, scaleStrategy.hashCode);
    _$hash = $jc(_$hash, kcalPer100g.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'IngredientDto')
          ..add('name', name)
          ..add('qtyPerServing', qtyPerServing)
          ..add('unit', unit)
          ..add('optional', optional)
          ..add('notes', notes)
          ..add('gramEquivalent', gramEquivalent)
          ..add('category', category)
          ..add('scaleStrategy', scaleStrategy)
          ..add('kcalPer100g', kcalPer100g))
        .toString();
  }
}

class IngredientDtoBuilder
    implements Builder<IngredientDto, IngredientDtoBuilder> {
  _$IngredientDto? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  num? _qtyPerServing;
  num? get qtyPerServing => _$this._qtyPerServing;
  set qtyPerServing(num? qtyPerServing) =>
      _$this._qtyPerServing = qtyPerServing;

  String? _unit;
  String? get unit => _$this._unit;
  set unit(String? unit) => _$this._unit = unit;

  bool? _optional;
  bool? get optional => _$this._optional;
  set optional(bool? optional) => _$this._optional = optional;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  num? _gramEquivalent;
  num? get gramEquivalent => _$this._gramEquivalent;
  set gramEquivalent(num? gramEquivalent) =>
      _$this._gramEquivalent = gramEquivalent;

  IngredientDtoCategoryEnum? _category;
  IngredientDtoCategoryEnum? get category => _$this._category;
  set category(IngredientDtoCategoryEnum? category) =>
      _$this._category = category;

  IngredientDtoScaleStrategyEnum? _scaleStrategy;
  IngredientDtoScaleStrategyEnum? get scaleStrategy => _$this._scaleStrategy;
  set scaleStrategy(IngredientDtoScaleStrategyEnum? scaleStrategy) =>
      _$this._scaleStrategy = scaleStrategy;

  num? _kcalPer100g;
  num? get kcalPer100g => _$this._kcalPer100g;
  set kcalPer100g(num? kcalPer100g) => _$this._kcalPer100g = kcalPer100g;

  IngredientDtoBuilder() {
    IngredientDto._defaults(this);
  }

  IngredientDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _qtyPerServing = $v.qtyPerServing;
      _unit = $v.unit;
      _optional = $v.optional;
      _notes = $v.notes;
      _gramEquivalent = $v.gramEquivalent;
      _category = $v.category;
      _scaleStrategy = $v.scaleStrategy;
      _kcalPer100g = $v.kcalPer100g;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(IngredientDto other) {
    _$v = other as _$IngredientDto;
  }

  @override
  void update(void Function(IngredientDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  IngredientDto build() => _build();

  _$IngredientDto _build() {
    final _$result = _$v ??
        _$IngredientDto._(
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'IngredientDto', 'name'),
          qtyPerServing: BuiltValueNullFieldError.checkNotNull(
              qtyPerServing, r'IngredientDto', 'qtyPerServing'),
          unit: BuiltValueNullFieldError.checkNotNull(
              unit, r'IngredientDto', 'unit'),
          optional: optional,
          notes: notes,
          gramEquivalent: gramEquivalent,
          category: category,
          scaleStrategy: scaleStrategy,
          kcalPer100g: kcalPer100g,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
