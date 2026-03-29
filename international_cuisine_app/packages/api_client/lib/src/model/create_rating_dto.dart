//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_rating_dto.g.dart';

/// CreateRatingDto
///
/// Properties:
/// * [score] - Rating score from 1 to 5
/// * [comment] 
@BuiltValue()
abstract class CreateRatingDto implements Built<CreateRatingDto, CreateRatingDtoBuilder> {
  /// Rating score from 1 to 5
  @BuiltValueField(wireName: r'score')
  num get score;

  @BuiltValueField(wireName: r'comment')
  String? get comment;

  CreateRatingDto._();

  factory CreateRatingDto([void updates(CreateRatingDtoBuilder b)]) = _$CreateRatingDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateRatingDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateRatingDto> get serializer => _$CreateRatingDtoSerializer();
}

class _$CreateRatingDtoSerializer implements PrimitiveSerializer<CreateRatingDto> {
  @override
  final Iterable<Type> types = const [CreateRatingDto, _$CreateRatingDto];

  @override
  final String wireName = r'CreateRatingDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateRatingDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'score';
    yield serializers.serialize(
      object.score,
      specifiedType: const FullType(num),
    );
    if (object.comment != null) {
      yield r'comment';
      yield serializers.serialize(
        object.comment,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateRatingDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateRatingDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'score':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.score = valueDes;
          break;
        case r'comment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.comment = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateRatingDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateRatingDtoBuilder();
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

