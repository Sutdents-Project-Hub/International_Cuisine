//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/recipe_serving_pair.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_shopping_list_dto.g.dart';

/// CreateShoppingListDto
///
/// Properties:
/// * [title] 
/// * [recipes] - Array of recipe IDs with desired servings
@BuiltValue()
abstract class CreateShoppingListDto implements Built<CreateShoppingListDto, CreateShoppingListDtoBuilder> {
  @BuiltValueField(wireName: r'title')
  String? get title;

  /// Array of recipe IDs with desired servings
  @BuiltValueField(wireName: r'recipes')
  BuiltList<RecipeServingPair> get recipes;

  CreateShoppingListDto._();

  factory CreateShoppingListDto([void updates(CreateShoppingListDtoBuilder b)]) = _$CreateShoppingListDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateShoppingListDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateShoppingListDto> get serializer => _$CreateShoppingListDtoSerializer();
}

class _$CreateShoppingListDtoSerializer implements PrimitiveSerializer<CreateShoppingListDto> {
  @override
  final Iterable<Type> types = const [CreateShoppingListDto, _$CreateShoppingListDto];

  @override
  final String wireName = r'CreateShoppingListDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateShoppingListDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    yield r'recipes';
    yield serializers.serialize(
      object.recipes,
      specifiedType: const FullType(BuiltList, [FullType(RecipeServingPair)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateShoppingListDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateShoppingListDtoBuilder result,
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
        case r'recipes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(RecipeServingPair)]),
          ) as BuiltList<RecipeServingPair>;
          result.recipes.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateShoppingListDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateShoppingListDtoBuilder();
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

