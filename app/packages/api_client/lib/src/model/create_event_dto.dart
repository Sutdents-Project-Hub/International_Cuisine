//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_event_dto.g.dart';

/// CreateEventDto
///
/// Properties:
/// * [recipeId] 
/// * [eventType] 
/// * [meta] 
@BuiltValue()
abstract class CreateEventDto implements Built<CreateEventDto, CreateEventDtoBuilder> {
  @BuiltValueField(wireName: r'recipeId')
  String? get recipeId;

  @BuiltValueField(wireName: r'eventType')
  CreateEventDtoEventTypeEnum get eventType;
  // enum eventTypeEnum {  VIEW,  START,  COMPLETE,  FAVORITE,  };

  @BuiltValueField(wireName: r'meta')
  JsonObject? get meta;

  CreateEventDto._();

  factory CreateEventDto([void updates(CreateEventDtoBuilder b)]) = _$CreateEventDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateEventDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateEventDto> get serializer => _$CreateEventDtoSerializer();
}

class _$CreateEventDtoSerializer implements PrimitiveSerializer<CreateEventDto> {
  @override
  final Iterable<Type> types = const [CreateEventDto, _$CreateEventDto];

  @override
  final String wireName = r'CreateEventDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateEventDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.recipeId != null) {
      yield r'recipeId';
      yield serializers.serialize(
        object.recipeId,
        specifiedType: const FullType(String),
      );
    }
    yield r'eventType';
    yield serializers.serialize(
      object.eventType,
      specifiedType: const FullType(CreateEventDtoEventTypeEnum),
    );
    if (object.meta != null) {
      yield r'meta';
      yield serializers.serialize(
        object.meta,
        specifiedType: const FullType(JsonObject),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateEventDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateEventDtoBuilder result,
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
        case r'eventType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreateEventDtoEventTypeEnum),
          ) as CreateEventDtoEventTypeEnum;
          result.eventType = valueDes;
          break;
        case r'meta':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(JsonObject),
          ) as JsonObject;
          result.meta = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateEventDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateEventDtoBuilder();
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

class CreateEventDtoEventTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'VIEW')
  static const CreateEventDtoEventTypeEnum VIEW = _$createEventDtoEventTypeEnum_VIEW;
  @BuiltValueEnumConst(wireName: r'START')
  static const CreateEventDtoEventTypeEnum START = _$createEventDtoEventTypeEnum_START;
  @BuiltValueEnumConst(wireName: r'COMPLETE')
  static const CreateEventDtoEventTypeEnum COMPLETE = _$createEventDtoEventTypeEnum_COMPLETE;
  @BuiltValueEnumConst(wireName: r'FAVORITE')
  static const CreateEventDtoEventTypeEnum FAVORITE = _$createEventDtoEventTypeEnum_FAVORITE;

  static Serializer<CreateEventDtoEventTypeEnum> get serializer => _$createEventDtoEventTypeEnumSerializer;

  const CreateEventDtoEventTypeEnum._(String name): super(name);

  static BuiltSet<CreateEventDtoEventTypeEnum> get values => _$createEventDtoEventTypeEnumValues;
  static CreateEventDtoEventTypeEnum valueOf(String name) => _$createEventDtoEventTypeEnumValueOf(name);
}

