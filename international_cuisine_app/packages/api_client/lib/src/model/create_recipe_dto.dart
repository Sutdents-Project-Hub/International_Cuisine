//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/ingredient_dto.dart';
import 'package:api_client/src/model/unlock_condition_dto.dart';
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/step_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_recipe_dto.g.dart';

/// CreateRecipeDto
///
/// Properties:
/// * [title] 
/// * [altTitles] 
/// * [country] 
/// * [region] 
/// * [city] 
/// * [cuisineTags] 
/// * [isHidden] 
/// * [prepTimeMinutes] 
/// * [cookTimeMinutes] 
/// * [totalTimeMinutes] 
/// * [difficulty] 
/// * [servingsBase] 
/// * [caloriesPerServing] 
/// * [culturalNote] 
/// * [ingredients] 
/// * [steps] 
/// * [unlockConditions] 
@BuiltValue()
abstract class CreateRecipeDto implements Built<CreateRecipeDto, CreateRecipeDtoBuilder> {
  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'altTitles')
  BuiltList<String>? get altTitles;

  @BuiltValueField(wireName: r'country')
  String get country;

  @BuiltValueField(wireName: r'region')
  String? get region;

  @BuiltValueField(wireName: r'city')
  String? get city;

  @BuiltValueField(wireName: r'cuisineTags')
  BuiltList<String>? get cuisineTags;

  @BuiltValueField(wireName: r'isHidden')
  bool? get isHidden;

  @BuiltValueField(wireName: r'prepTimeMinutes')
  num get prepTimeMinutes;

  @BuiltValueField(wireName: r'cookTimeMinutes')
  num get cookTimeMinutes;

  @BuiltValueField(wireName: r'totalTimeMinutes')
  num get totalTimeMinutes;

  @BuiltValueField(wireName: r'difficulty')
  CreateRecipeDtoDifficultyEnum get difficulty;
  // enum difficultyEnum {  BEGINNER,  INTERMEDIATE,  ADVANCED,  };

  @BuiltValueField(wireName: r'servingsBase')
  num? get servingsBase;

  @BuiltValueField(wireName: r'caloriesPerServing')
  num? get caloriesPerServing;

  @BuiltValueField(wireName: r'culturalNote')
  String? get culturalNote;

  @BuiltValueField(wireName: r'ingredients')
  BuiltList<IngredientDto> get ingredients;

  @BuiltValueField(wireName: r'steps')
  BuiltList<StepDto> get steps;

  @BuiltValueField(wireName: r'unlockConditions')
  BuiltList<UnlockConditionDto>? get unlockConditions;

  CreateRecipeDto._();

  factory CreateRecipeDto([void updates(CreateRecipeDtoBuilder b)]) = _$CreateRecipeDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateRecipeDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateRecipeDto> get serializer => _$CreateRecipeDtoSerializer();
}

class _$CreateRecipeDtoSerializer implements PrimitiveSerializer<CreateRecipeDto> {
  @override
  final Iterable<Type> types = const [CreateRecipeDto, _$CreateRecipeDto];

  @override
  final String wireName = r'CreateRecipeDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateRecipeDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    if (object.altTitles != null) {
      yield r'altTitles';
      yield serializers.serialize(
        object.altTitles,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    yield r'country';
    yield serializers.serialize(
      object.country,
      specifiedType: const FullType(String),
    );
    if (object.region != null) {
      yield r'region';
      yield serializers.serialize(
        object.region,
        specifiedType: const FullType(String),
      );
    }
    if (object.city != null) {
      yield r'city';
      yield serializers.serialize(
        object.city,
        specifiedType: const FullType(String),
      );
    }
    if (object.cuisineTags != null) {
      yield r'cuisineTags';
      yield serializers.serialize(
        object.cuisineTags,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.isHidden != null) {
      yield r'isHidden';
      yield serializers.serialize(
        object.isHidden,
        specifiedType: const FullType(bool),
      );
    }
    yield r'prepTimeMinutes';
    yield serializers.serialize(
      object.prepTimeMinutes,
      specifiedType: const FullType(num),
    );
    yield r'cookTimeMinutes';
    yield serializers.serialize(
      object.cookTimeMinutes,
      specifiedType: const FullType(num),
    );
    yield r'totalTimeMinutes';
    yield serializers.serialize(
      object.totalTimeMinutes,
      specifiedType: const FullType(num),
    );
    yield r'difficulty';
    yield serializers.serialize(
      object.difficulty,
      specifiedType: const FullType(CreateRecipeDtoDifficultyEnum),
    );
    if (object.servingsBase != null) {
      yield r'servingsBase';
      yield serializers.serialize(
        object.servingsBase,
        specifiedType: const FullType(num),
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
    yield r'ingredients';
    yield serializers.serialize(
      object.ingredients,
      specifiedType: const FullType(BuiltList, [FullType(IngredientDto)]),
    );
    yield r'steps';
    yield serializers.serialize(
      object.steps,
      specifiedType: const FullType(BuiltList, [FullType(StepDto)]),
    );
    if (object.unlockConditions != null) {
      yield r'unlockConditions';
      yield serializers.serialize(
        object.unlockConditions,
        specifiedType: const FullType(BuiltList, [FullType(UnlockConditionDto)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateRecipeDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateRecipeDtoBuilder result,
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
        case r'altTitles':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.altTitles.replace(valueDes);
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
        case r'city':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.city = valueDes;
          break;
        case r'cuisineTags':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.cuisineTags.replace(valueDes);
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
            specifiedType: const FullType(CreateRecipeDtoDifficultyEnum),
          ) as CreateRecipeDtoDifficultyEnum;
          result.difficulty = valueDes;
          break;
        case r'servingsBase':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.servingsBase = valueDes;
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
        case r'ingredients':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(IngredientDto)]),
          ) as BuiltList<IngredientDto>;
          result.ingredients.replace(valueDes);
          break;
        case r'steps':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(StepDto)]),
          ) as BuiltList<StepDto>;
          result.steps.replace(valueDes);
          break;
        case r'unlockConditions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(UnlockConditionDto)]),
          ) as BuiltList<UnlockConditionDto>;
          result.unlockConditions.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateRecipeDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateRecipeDtoBuilder();
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

class CreateRecipeDtoDifficultyEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'BEGINNER')
  static const CreateRecipeDtoDifficultyEnum BEGINNER = _$createRecipeDtoDifficultyEnum_BEGINNER;
  @BuiltValueEnumConst(wireName: r'INTERMEDIATE')
  static const CreateRecipeDtoDifficultyEnum INTERMEDIATE = _$createRecipeDtoDifficultyEnum_INTERMEDIATE;
  @BuiltValueEnumConst(wireName: r'ADVANCED')
  static const CreateRecipeDtoDifficultyEnum ADVANCED = _$createRecipeDtoDifficultyEnum_ADVANCED;

  static Serializer<CreateRecipeDtoDifficultyEnum> get serializer => _$createRecipeDtoDifficultyEnumSerializer;

  const CreateRecipeDtoDifficultyEnum._(String name): super(name);

  static BuiltSet<CreateRecipeDtoDifficultyEnum> get values => _$createRecipeDtoDifficultyEnumValues;
  static CreateRecipeDtoDifficultyEnum valueOf(String name) => _$createRecipeDtoDifficultyEnumValueOf(name);
}

