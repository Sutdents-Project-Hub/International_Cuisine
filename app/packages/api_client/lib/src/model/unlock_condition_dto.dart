//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'unlock_condition_dto.g.dart';

/// UnlockConditionDto
///
/// Properties:
/// * [conditionType] 
/// * [conditionData] 
/// * [description] 
@BuiltValue()
abstract class UnlockConditionDto implements Built<UnlockConditionDto, UnlockConditionDtoBuilder> {
  @BuiltValueField(wireName: r'conditionType')
  String get conditionType;

  @BuiltValueField(wireName: r'conditionData')
  JsonObject get conditionData;

  @BuiltValueField(wireName: r'description')
  String get description;

  UnlockConditionDto._();

  factory UnlockConditionDto([void updates(UnlockConditionDtoBuilder b)]) = _$UnlockConditionDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UnlockConditionDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UnlockConditionDto> get serializer => _$UnlockConditionDtoSerializer();
}

class _$UnlockConditionDtoSerializer implements PrimitiveSerializer<UnlockConditionDto> {
  @override
  final Iterable<Type> types = const [UnlockConditionDto, _$UnlockConditionDto];

  @override
  final String wireName = r'UnlockConditionDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UnlockConditionDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'conditionType';
    yield serializers.serialize(
      object.conditionType,
      specifiedType: const FullType(String),
    );
    yield r'conditionData';
    yield serializers.serialize(
      object.conditionData,
      specifiedType: const FullType(JsonObject),
    );
    yield r'description';
    yield serializers.serialize(
      object.description,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UnlockConditionDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UnlockConditionDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'conditionType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.conditionType = valueDes;
          break;
        case r'conditionData':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(JsonObject),
          ) as JsonObject;
          result.conditionData = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UnlockConditionDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UnlockConditionDtoBuilder();
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

