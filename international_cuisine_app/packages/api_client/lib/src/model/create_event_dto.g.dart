// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_event_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateEventDtoEventTypeEnum _$createEventDtoEventTypeEnum_VIEW =
    const CreateEventDtoEventTypeEnum._('VIEW');
const CreateEventDtoEventTypeEnum _$createEventDtoEventTypeEnum_START =
    const CreateEventDtoEventTypeEnum._('START');
const CreateEventDtoEventTypeEnum _$createEventDtoEventTypeEnum_COMPLETE =
    const CreateEventDtoEventTypeEnum._('COMPLETE');
const CreateEventDtoEventTypeEnum _$createEventDtoEventTypeEnum_FAVORITE =
    const CreateEventDtoEventTypeEnum._('FAVORITE');

CreateEventDtoEventTypeEnum _$createEventDtoEventTypeEnumValueOf(String name) {
  switch (name) {
    case 'VIEW':
      return _$createEventDtoEventTypeEnum_VIEW;
    case 'START':
      return _$createEventDtoEventTypeEnum_START;
    case 'COMPLETE':
      return _$createEventDtoEventTypeEnum_COMPLETE;
    case 'FAVORITE':
      return _$createEventDtoEventTypeEnum_FAVORITE;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateEventDtoEventTypeEnum>
    _$createEventDtoEventTypeEnumValues =
    BuiltSet<CreateEventDtoEventTypeEnum>(const <CreateEventDtoEventTypeEnum>[
  _$createEventDtoEventTypeEnum_VIEW,
  _$createEventDtoEventTypeEnum_START,
  _$createEventDtoEventTypeEnum_COMPLETE,
  _$createEventDtoEventTypeEnum_FAVORITE,
]);

Serializer<CreateEventDtoEventTypeEnum>
    _$createEventDtoEventTypeEnumSerializer =
    _$CreateEventDtoEventTypeEnumSerializer();

class _$CreateEventDtoEventTypeEnumSerializer
    implements PrimitiveSerializer<CreateEventDtoEventTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'VIEW': 'VIEW',
    'START': 'START',
    'COMPLETE': 'COMPLETE',
    'FAVORITE': 'FAVORITE',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'VIEW': 'VIEW',
    'START': 'START',
    'COMPLETE': 'COMPLETE',
    'FAVORITE': 'FAVORITE',
  };

  @override
  final Iterable<Type> types = const <Type>[CreateEventDtoEventTypeEnum];
  @override
  final String wireName = 'CreateEventDtoEventTypeEnum';

  @override
  Object serialize(Serializers serializers, CreateEventDtoEventTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CreateEventDtoEventTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CreateEventDtoEventTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CreateEventDto extends CreateEventDto {
  @override
  final String? recipeId;
  @override
  final CreateEventDtoEventTypeEnum eventType;
  @override
  final JsonObject? meta;

  factory _$CreateEventDto([void Function(CreateEventDtoBuilder)? updates]) =>
      (CreateEventDtoBuilder()..update(updates))._build();

  _$CreateEventDto._({this.recipeId, required this.eventType, this.meta})
      : super._();
  @override
  CreateEventDto rebuild(void Function(CreateEventDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateEventDtoBuilder toBuilder() => CreateEventDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateEventDto &&
        recipeId == other.recipeId &&
        eventType == other.eventType &&
        meta == other.meta;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, recipeId.hashCode);
    _$hash = $jc(_$hash, eventType.hashCode);
    _$hash = $jc(_$hash, meta.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateEventDto')
          ..add('recipeId', recipeId)
          ..add('eventType', eventType)
          ..add('meta', meta))
        .toString();
  }
}

class CreateEventDtoBuilder
    implements Builder<CreateEventDto, CreateEventDtoBuilder> {
  _$CreateEventDto? _$v;

  String? _recipeId;
  String? get recipeId => _$this._recipeId;
  set recipeId(String? recipeId) => _$this._recipeId = recipeId;

  CreateEventDtoEventTypeEnum? _eventType;
  CreateEventDtoEventTypeEnum? get eventType => _$this._eventType;
  set eventType(CreateEventDtoEventTypeEnum? eventType) =>
      _$this._eventType = eventType;

  JsonObject? _meta;
  JsonObject? get meta => _$this._meta;
  set meta(JsonObject? meta) => _$this._meta = meta;

  CreateEventDtoBuilder() {
    CreateEventDto._defaults(this);
  }

  CreateEventDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _recipeId = $v.recipeId;
      _eventType = $v.eventType;
      _meta = $v.meta;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateEventDto other) {
    _$v = other as _$CreateEventDto;
  }

  @override
  void update(void Function(CreateEventDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateEventDto build() => _build();

  _$CreateEventDto _build() {
    final _$result = _$v ??
        _$CreateEventDto._(
          recipeId: recipeId,
          eventType: BuiltValueNullFieldError.checkNotNull(
              eventType, r'CreateEventDto', 'eventType'),
          meta: meta,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
