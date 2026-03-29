//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ingredient_dto.g.dart';

/// IngredientDto
///
/// Properties:
/// * [name] 
/// * [qtyPerServing] 
/// * [unit] 
/// * [optional] 
/// * [notes] 
/// * [gramEquivalent] 
/// * [category] 
/// * [scaleStrategy] 
/// * [kcalPer100g] 
@BuiltValue()
abstract class IngredientDto implements Built<IngredientDto, IngredientDtoBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'qtyPerServing')
  num get qtyPerServing;

  @BuiltValueField(wireName: r'unit')
  String get unit;

  @BuiltValueField(wireName: r'optional')
  bool? get optional;

  @BuiltValueField(wireName: r'notes')
  String? get notes;

  @BuiltValueField(wireName: r'gramEquivalent')
  num? get gramEquivalent;

  @BuiltValueField(wireName: r'category')
  IngredientDtoCategoryEnum? get category;
  // enum categoryEnum {  VEGETABLE,  MEAT,  DRY_GOODS,  SEASONING,  REFRIGERATED,  OTHER,  };

  @BuiltValueField(wireName: r'scaleStrategy')
  IngredientDtoScaleStrategyEnum? get scaleStrategy;
  // enum scaleStrategyEnum {  LINEAR,  CLAMPED,  MIN_UNIT,  };

  @BuiltValueField(wireName: r'kcalPer100g')
  num? get kcalPer100g;

  IngredientDto._();

  factory IngredientDto([void updates(IngredientDtoBuilder b)]) = _$IngredientDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(IngredientDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<IngredientDto> get serializer => _$IngredientDtoSerializer();
}

class _$IngredientDtoSerializer implements PrimitiveSerializer<IngredientDto> {
  @override
  final Iterable<Type> types = const [IngredientDto, _$IngredientDto];

  @override
  final String wireName = r'IngredientDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    IngredientDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'qtyPerServing';
    yield serializers.serialize(
      object.qtyPerServing,
      specifiedType: const FullType(num),
    );
    yield r'unit';
    yield serializers.serialize(
      object.unit,
      specifiedType: const FullType(String),
    );
    if (object.optional != null) {
      yield r'optional';
      yield serializers.serialize(
        object.optional,
        specifiedType: const FullType(bool),
      );
    }
    if (object.notes != null) {
      yield r'notes';
      yield serializers.serialize(
        object.notes,
        specifiedType: const FullType(String),
      );
    }
    if (object.gramEquivalent != null) {
      yield r'gramEquivalent';
      yield serializers.serialize(
        object.gramEquivalent,
        specifiedType: const FullType(num),
      );
    }
    if (object.category != null) {
      yield r'category';
      yield serializers.serialize(
        object.category,
        specifiedType: const FullType(IngredientDtoCategoryEnum),
      );
    }
    if (object.scaleStrategy != null) {
      yield r'scaleStrategy';
      yield serializers.serialize(
        object.scaleStrategy,
        specifiedType: const FullType(IngredientDtoScaleStrategyEnum),
      );
    }
    if (object.kcalPer100g != null) {
      yield r'kcalPer100g';
      yield serializers.serialize(
        object.kcalPer100g,
        specifiedType: const FullType(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    IngredientDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required IngredientDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'qtyPerServing':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.qtyPerServing = valueDes;
          break;
        case r'unit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.unit = valueDes;
          break;
        case r'optional':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.optional = valueDes;
          break;
        case r'notes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.notes = valueDes;
          break;
        case r'gramEquivalent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.gramEquivalent = valueDes;
          break;
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(IngredientDtoCategoryEnum),
          ) as IngredientDtoCategoryEnum;
          result.category = valueDes;
          break;
        case r'scaleStrategy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(IngredientDtoScaleStrategyEnum),
          ) as IngredientDtoScaleStrategyEnum;
          result.scaleStrategy = valueDes;
          break;
        case r'kcalPer100g':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.kcalPer100g = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  IngredientDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = IngredientDtoBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

class IngredientDtoCategoryEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'VEGETABLE')
  static const IngredientDtoCategoryEnum VEGETABLE = _$ingredientDtoCategoryEnum_VEGETABLE;
  @BuiltValueEnumConst(wireName: r'MEAT')
  static const IngredientDtoCategoryEnum MEAT = _$ingredientDtoCategoryEnum_MEAT;
  @BuiltValueEnumConst(wireName: r'DRY_GOODS')
  static const IngredientDtoCategoryEnum DRY_GOODS = _$ingredientDtoCategoryEnum_DRY_GOODS;
  @BuiltValueEnumConst(wireName: r'SEASONING')
  static const IngredientDtoCategoryEnum SEASONING = _$ingredientDtoCategoryEnum_SEASONING;
  @BuiltValueEnumConst(wireName: r'REFRIGERATED')
  static const IngredientDtoCategoryEnum REFRIGERATED = _$ingredientDtoCategoryEnum_REFRIGERATED;
  @BuiltValueEnumConst(wireName: r'OTHER')
  static const IngredientDtoCategoryEnum OTHER = _$ingredientDtoCategoryEnum_OTHER;

  static Serializer<IngredientDtoCategoryEnum> get serializer => _$ingredientDtoCategoryEnumSerializer;

  const IngredientDtoCategoryEnum._(String name): super(name);

  static BuiltSet<IngredientDtoCategoryEnum> get values => _$ingredientDtoCategoryEnumValues;
  static IngredientDtoCategoryEnum valueOf(String name) => _$ingredientDtoCategoryEnumValueOf(name);
}

class IngredientDtoScaleStrategyEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'LINEAR')
  static const IngredientDtoScaleStrategyEnum LINEAR = _$ingredientDtoScaleStrategyEnum_LINEAR;
  @BuiltValueEnumConst(wireName: r'CLAMPED')
  static const IngredientDtoScaleStrategyEnum CLAMPED = _$ingredientDtoScaleStrategyEnum_CLAMPED;
  @BuiltValueEnumConst(wireName: r'MIN_UNIT')
  static const IngredientDtoScaleStrategyEnum MIN_UNIT = _$ingredientDtoScaleStrategyEnum_MIN_UNIT;

  static Serializer<IngredientDtoScaleStrategyEnum> get serializer => _$ingredientDtoScaleStrategyEnumSerializer;

  const IngredientDtoScaleStrategyEnum._(String name): super(name);

  static BuiltSet<IngredientDtoScaleStrategyEnum> get values => _$ingredientDtoScaleStrategyEnumValues;
  static IngredientDtoScaleStrategyEnum valueOf(String name) => _$ingredientDtoScaleStrategyEnumValueOf(name);
}

