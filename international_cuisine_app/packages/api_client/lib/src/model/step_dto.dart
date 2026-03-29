//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'step_dto.g.dart';

/// StepDto
///
/// Properties:
/// * [order] 
/// * [description] 
/// * [defaultTimerSeconds] 
/// * [mediaUrl] 
@BuiltValue()
abstract class StepDto implements Built<StepDto, StepDtoBuilder> {
  @BuiltValueField(wireName: r'order')
  num get order;

  @BuiltValueField(wireName: r'description')
  String get description;

  @BuiltValueField(wireName: r'defaultTimerSeconds')
  num? get defaultTimerSeconds;

  @BuiltValueField(wireName: r'mediaUrl')
  String? get mediaUrl;

  StepDto._();

  factory StepDto([void updates(StepDtoBuilder b)]) = _$StepDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StepDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StepDto> get serializer => _$StepDtoSerializer();
}

class _$StepDtoSerializer implements PrimitiveSerializer<StepDto> {
  @override
  final Iterable<Type> types = const [StepDto, _$StepDto];

  @override
  final String wireName = r'StepDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StepDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'order';
    yield serializers.serialize(
      object.order,
      specifiedType: const FullType(num),
    );
    yield r'description';
    yield serializers.serialize(
      object.description,
      specifiedType: const FullType(String),
    );
    if (object.defaultTimerSeconds != null) {
      yield r'defaultTimerSeconds';
      yield serializers.serialize(
        object.defaultTimerSeconds,
        specifiedType: const FullType(num),
      );
    }
    if (object.mediaUrl != null) {
      yield r'mediaUrl';
      yield serializers.serialize(
        object.mediaUrl,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    StepDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StepDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'order':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.order = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'defaultTimerSeconds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.defaultTimerSeconds = valueDes;
          break;
        case r'mediaUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.mediaUrl = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StepDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StepDtoBuilder();
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

