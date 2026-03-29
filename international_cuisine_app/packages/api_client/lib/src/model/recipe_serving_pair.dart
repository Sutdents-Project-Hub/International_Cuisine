//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'recipe_serving_pair.g.dart';

/// RecipeServingPair
///
/// Properties:
/// * [recipeId] 
/// * [servings] 
@BuiltValue()
abstract class RecipeServingPair implements Built<RecipeServingPair, RecipeServingPairBuilder> {
  @BuiltValueField(wireName: r'recipeId')
  String get recipeId;

  @BuiltValueField(wireName: r'servings')
  num get servings;

  RecipeServingPair._();

  factory RecipeServingPair([void updates(RecipeServingPairBuilder b)]) = _$RecipeServingPair;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RecipeServingPairBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RecipeServingPair> get serializer => _$RecipeServingPairSerializer();
}

class _$RecipeServingPairSerializer implements PrimitiveSerializer<RecipeServingPair> {
  @override
  final Iterable<Type> types = const [RecipeServingPair, _$RecipeServingPair];

  @override
  final String wireName = r'RecipeServingPair';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RecipeServingPair object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'recipeId';
    yield serializers.serialize(
      object.recipeId,
      specifiedType: const FullType(String),
    );
    yield r'servings';
    yield serializers.serialize(
      object.servings,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RecipeServingPair object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RecipeServingPairBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'recipeId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.recipeId = valueDes;
          break;
        case r'servings':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.servings = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RecipeServingPair deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RecipeServingPairBuilder();
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

