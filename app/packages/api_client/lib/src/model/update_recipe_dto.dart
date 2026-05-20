//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_recipe_dto.g.dart';

/// UpdateRecipeDto
///
/// Properties:
/// * [title] 
/// * [country] 
/// * [region] 
/// * [isHidden] 
/// * [prepTimeMinutes] 
/// * [cookTimeMinutes] 
/// * [totalTimeMinutes] 
/// * [difficulty] 
/// * [caloriesPerServing] 
/// * [culturalNote] 
@BuiltValue()
abstract class UpdateRecipeDto implements Built<UpdateRecipeDto, UpdateRecipeDtoBuilder> {
  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'country')
  String? get country;

  @BuiltValueField(wireName: r'region')
  String? get region;

  @BuiltValueField(wireName: r'isHidden')
  bool? get isHidden;

  @BuiltValueField(wireName: r'prepTimeMinutes')
  num? get prepTimeMinutes;

  @BuiltValueField(wireName: r'cookTimeMinutes')
  num? get cookTimeMinutes;

  @BuiltValueField(wireName: r'totalTimeMinutes')
  num? get totalTimeMinutes;

  @BuiltValueField(wireName: r'difficulty')
  UpdateRecipeDtoDifficultyEnum? get difficulty;
  // enum difficultyEnum {  BEGINNER,  INTERMEDIATE,  ADVANCED,  };

  @BuiltValueField(wireName: r'caloriesPerServing')
  num? get caloriesPerServing;

  @BuiltValueField(wireName: r'culturalNote')
  String? get culturalNote;

  UpdateRecipeDto._();

  factory UpdateRecipeDto([void updates(UpdateRecipeDtoBuilder b)]) = _$UpdateRecipeDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateRecipeDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateRecipeDto> get serializer => _$UpdateRecipeDtoSerializer();
}

class _$UpdateRecipeDtoSerializer implements PrimitiveSerializer<UpdateRecipeDto> {
  @override
  final Iterable<Type> types = const [UpdateRecipeDto, _$UpdateRecipeDto];

  @override
  final String wireName = r'UpdateRecipeDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateRecipeDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    if (object.country != null) {
      yield r'country';
      yield serializers.serialize(
        object.country,
        specifiedType: const FullType(String),
      );
    }
    if (object.region != null) {
      yield r'region';
      yield serializers.serialize(
        object.region,
        specifiedType: const FullType(String),
      );
    }
    if (object.isHidden != null) {
      yield r'isHidden';
      yield serializers.serialize(
        object.isHidden,
        specifiedType: const FullType(bool),
      );
    }
    if (object.prepTimeMinutes != null) {
      yield r'prepTimeMinutes';
      yield serializers.serialize(
        object.prepTimeMinutes,
        specifiedType: const FullType(num),
      );
    }
    if (object.cookTimeMinutes != null) {
      yield r'cookTimeMinutes';
      yield serializers.serialize(
        object.cookTimeMinutes,
        specifiedType: const FullType(num),
      );
    }
    if (object.totalTimeMinutes != null) {
      yield r'totalTimeMinutes';
      yield serializers.serialize(
        object.totalTimeMinutes,
        specifiedType: const FullType(num),
      );
    }
    if (object.difficulty != null) {
      yield r'difficulty';
      yield serializers.serialize(
        object.difficulty,
        specifiedType: const FullType(UpdateRecipeDtoDifficultyEnum),
      );
    }
    if (object.caloriesPerServing != null) {
      yield r'caloriesPerServing';
      yield serializers.serialize(
        object.caloriesPerServing,
        specifiedType: const FullType(num),
      );
    }
    if (object.culturalNote != null) {
      yield r'culturalNote';
      yield serializers.serialize(
        object.culturalNote,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateRecipeDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateRecipeDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'country':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.country = valueDes;
          break;
        case r'region':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.region = valueDes;
          break;
        case r'isHidden':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isHidden = valueDes;
          break;
        case r'prepTimeMinutes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.prepTimeMinutes = valueDes;
          break;
        case r'cookTimeMinutes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.cookTimeMinutes = valueDes;
          break;
        case r'totalTimeMinutes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalTimeMinutes = valueDes;
          break;
        case r'difficulty':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UpdateRecipeDtoDifficultyEnum),
          ) as UpdateRecipeDtoDifficultyEnum;
          result.difficulty = valueDes;
          break;
        case r'caloriesPerServing':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.caloriesPerServing = valueDes;
          break;
        case r'culturalNote':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.culturalNote = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateRecipeDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateRecipeDtoBuilder();
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

class UpdateRecipeDtoDifficultyEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'BEGINNER')
  static const UpdateRecipeDtoDifficultyEnum BEGINNER = _$updateRecipeDtoDifficultyEnum_BEGINNER;
  @BuiltValueEnumConst(wireName: r'INTERMEDIATE')
  static const UpdateRecipeDtoDifficultyEnum INTERMEDIATE = _$updateRecipeDtoDifficultyEnum_INTERMEDIATE;
  @BuiltValueEnumConst(wireName: r'ADVANCED')
  static const UpdateRecipeDtoDifficultyEnum ADVANCED = _$updateRecipeDtoDifficultyEnum_ADVANCED;

  static Serializer<UpdateRecipeDtoDifficultyEnum> get serializer => _$updateRecipeDtoDifficultyEnumSerializer;

  const UpdateRecipeDtoDifficultyEnum._(String name): super(name);

  static BuiltSet<UpdateRecipeDtoDifficultyEnum> get values => _$updateRecipeDtoDifficultyEnumValues;
  static UpdateRecipeDtoDifficultyEnum valueOf(String name) => _$updateRecipeDtoDifficultyEnumValueOf(name);
}

