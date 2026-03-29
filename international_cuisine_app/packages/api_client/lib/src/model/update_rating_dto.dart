//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_rating_dto.g.dart';

/// UpdateRatingDto
///
/// Properties:
/// * [score] 
/// * [comment] 
@BuiltValue()
abstract class UpdateRatingDto implements Built<UpdateRatingDto, UpdateRatingDtoBuilder> {
  @BuiltValueField(wireName: r'score')
  num? get score;

  @BuiltValueField(wireName: r'comment')
  String? get comment;

  UpdateRatingDto._();

  factory UpdateRatingDto([void updates(UpdateRatingDtoBuilder b)]) = _$UpdateRatingDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateRatingDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateRatingDto> get serializer => _$UpdateRatingDtoSerializer();
}

class _$UpdateRatingDtoSerializer implements PrimitiveSerializer<UpdateRatingDto> {
  @override
  final Iterable<Type> types = const [UpdateRatingDto, _$UpdateRatingDto];

  @override
  final String wireName = r'UpdateRatingDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateRatingDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.score != null) {
      yield r'score';
      yield serializers.serialize(
        object.score,
        specifiedType: const FullType(num),
      );
    }
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
    UpdateRatingDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateRatingDtoBuilder result,
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
  UpdateRatingDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateRatingDtoBuilder();
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

