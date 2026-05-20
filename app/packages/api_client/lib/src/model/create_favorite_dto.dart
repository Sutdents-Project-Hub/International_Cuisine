//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_favorite_dto.g.dart';

/// CreateFavoriteDto
///
/// Properties:
/// * [recipeId] 
/// * [categoryName] - Custom category name for organizing favorites
@BuiltValue()
abstract class CreateFavoriteDto implements Built<CreateFavoriteDto, CreateFavoriteDtoBuilder> {
  @BuiltValueField(wireName: r'recipeId')
  String get recipeId;

  /// Custom category name for organizing favorites
  @BuiltValueField(wireName: r'categoryName')
  String? get categoryName;

  CreateFavoriteDto._();

  factory CreateFavoriteDto([void updates(CreateFavoriteDtoBuilder b)]) = _$CreateFavoriteDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateFavoriteDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateFavoriteDto> get serializer => _$CreateFavoriteDtoSerializer();
}

class _$CreateFavoriteDtoSerializer implements PrimitiveSerializer<CreateFavoriteDto> {
  @override
  final Iterable<Type> types = const [CreateFavoriteDto, _$CreateFavoriteDto];

  @override
  final String wireName = r'CreateFavoriteDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateFavoriteDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'recipeId';
    yield serializers.serialize(
      object.recipeId,
      specifiedType: const FullType(String),
    );
    if (object.categoryName != null) {
      yield r'categoryName';
      yield serializers.serialize(
        object.categoryName,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateFavoriteDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateFavoriteDtoBuilder result,
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
        case r'categoryName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.categoryName = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateFavoriteDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateFavoriteDtoBuilder();
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

