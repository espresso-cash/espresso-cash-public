// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'type_definition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TypeDefinition _$TypeDefinitionFromJson(Map<String, dynamic> json) {
  switch (json['type'] as String?) {
    case 'enum':
      return EnumType.fromJson(json);
    case 'object':
      return ObjectType.fromJson(json);

    default:
      return AliasType.fromJson(json);
  }
}

/// @nodoc
class _$TypeDefinitionTearOff {
  const _$TypeDefinitionTearOff();

  EnumType enumType(
      {required String name,
      required List<EnumValue> values,
      required String description}) {
    return EnumType(
      name: name,
      values: values,
      description: description,
    );
  }

  ObjectType objectType(
      {required String name,
      required List<ObjectMember> fields,
      String? description}) {
    return ObjectType(
      name: name,
      fields: fields,
      description: description,
    );
  }

  AliasType alias(
      {required String name,
      required String description,
      required String type}) {
    return AliasType(
      name: name,
      description: description,
      type: type,
    );
  }

  TypeDefinition fromJson(Map<String, Object> json) {
    return TypeDefinition.fromJson(json);
  }
}

/// @nodoc
const $TypeDefinition = _$TypeDefinitionTearOff();

/// @nodoc
mixin _$TypeDefinition {
  String get name => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String name, List<EnumValue> values, String description)
        enumType,
    required TResult Function(
            String name, List<ObjectMember> fields, String? description)
        objectType,
    required TResult Function(String name, String description, String type)
        alias,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name, List<EnumValue> values, String description)?
        enumType,
    TResult Function(
            String name, List<ObjectMember> fields, String? description)?
        objectType,
    TResult Function(String name, String description, String type)? alias,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, List<EnumValue> values, String description)?
        enumType,
    TResult Function(
            String name, List<ObjectMember> fields, String? description)?
        objectType,
    TResult Function(String name, String description, String type)? alias,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EnumType value) enumType,
    required TResult Function(ObjectType value) objectType,
    required TResult Function(AliasType value) alias,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(EnumType value)? enumType,
    TResult Function(ObjectType value)? objectType,
    TResult Function(AliasType value)? alias,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EnumType value)? enumType,
    TResult Function(ObjectType value)? objectType,
    TResult Function(AliasType value)? alias,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TypeDefinitionCopyWith<TypeDefinition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TypeDefinitionCopyWith<$Res> {
  factory $TypeDefinitionCopyWith(
          TypeDefinition value, $Res Function(TypeDefinition) then) =
      _$TypeDefinitionCopyWithImpl<$Res>;
  $Res call({String name});
}

/// @nodoc
class _$TypeDefinitionCopyWithImpl<$Res>
    implements $TypeDefinitionCopyWith<$Res> {
  _$TypeDefinitionCopyWithImpl(this._value, this._then);

  final TypeDefinition _value;
  // ignore: unused_field
  final $Res Function(TypeDefinition) _then;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class $EnumTypeCopyWith<$Res>
    implements $TypeDefinitionCopyWith<$Res> {
  factory $EnumTypeCopyWith(EnumType value, $Res Function(EnumType) then) =
      _$EnumTypeCopyWithImpl<$Res>;
  @override
  $Res call({String name, List<EnumValue> values, String description});
}

/// @nodoc
class _$EnumTypeCopyWithImpl<$Res> extends _$TypeDefinitionCopyWithImpl<$Res>
    implements $EnumTypeCopyWith<$Res> {
  _$EnumTypeCopyWithImpl(EnumType _value, $Res Function(EnumType) _then)
      : super(_value, (v) => _then(v as EnumType));

  @override
  EnumType get _value => super._value as EnumType;

  @override
  $Res call({
    Object? name = freezed,
    Object? values = freezed,
    Object? description = freezed,
  }) {
    return _then(EnumType(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      values: values == freezed
          ? _value.values
          : values // ignore: cast_nullable_to_non_nullable
              as List<EnumValue>,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('enum')
class _$EnumType extends EnumType {
  const _$EnumType(
      {required this.name, required this.values, required this.description})
      : super._();

  factory _$EnumType.fromJson(Map<String, dynamic> json) =>
      _$$EnumTypeFromJson(json);

  @override
  final String name;
  @override
  final List<EnumValue> values;
  @override
  final String description;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is EnumType &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.values, values) ||
                const DeepCollectionEquality().equals(other.values, values)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(values) ^
      const DeepCollectionEquality().hash(description);

  @JsonKey(ignore: true)
  @override
  $EnumTypeCopyWith<EnumType> get copyWith =>
      _$EnumTypeCopyWithImpl<EnumType>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String name, List<EnumValue> values, String description)
        enumType,
    required TResult Function(
            String name, List<ObjectMember> fields, String? description)
        objectType,
    required TResult Function(String name, String description, String type)
        alias,
  }) {
    return enumType(name, values, description);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name, List<EnumValue> values, String description)?
        enumType,
    TResult Function(
            String name, List<ObjectMember> fields, String? description)?
        objectType,
    TResult Function(String name, String description, String type)? alias,
  }) {
    return enumType?.call(name, values, description);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, List<EnumValue> values, String description)?
        enumType,
    TResult Function(
            String name, List<ObjectMember> fields, String? description)?
        objectType,
    TResult Function(String name, String description, String type)? alias,
    required TResult orElse(),
  }) {
    if (enumType != null) {
      return enumType(name, values, description);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EnumType value) enumType,
    required TResult Function(ObjectType value) objectType,
    required TResult Function(AliasType value) alias,
  }) {
    return enumType(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(EnumType value)? enumType,
    TResult Function(ObjectType value)? objectType,
    TResult Function(AliasType value)? alias,
  }) {
    return enumType?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EnumType value)? enumType,
    TResult Function(ObjectType value)? objectType,
    TResult Function(AliasType value)? alias,
    required TResult orElse(),
  }) {
    if (enumType != null) {
      return enumType(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$EnumTypeToJson(this)..['type'] = 'enum';
  }
}

abstract class EnumType extends TypeDefinition {
  const factory EnumType(
      {required String name,
      required List<EnumValue> values,
      required String description}) = _$EnumType;
  const EnumType._() : super._();

  factory EnumType.fromJson(Map<String, dynamic> json) = _$EnumType.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  List<EnumValue> get values => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $EnumTypeCopyWith<EnumType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ObjectTypeCopyWith<$Res>
    implements $TypeDefinitionCopyWith<$Res> {
  factory $ObjectTypeCopyWith(
          ObjectType value, $Res Function(ObjectType) then) =
      _$ObjectTypeCopyWithImpl<$Res>;
  @override
  $Res call({String name, List<ObjectMember> fields, String? description});
}

/// @nodoc
class _$ObjectTypeCopyWithImpl<$Res> extends _$TypeDefinitionCopyWithImpl<$Res>
    implements $ObjectTypeCopyWith<$Res> {
  _$ObjectTypeCopyWithImpl(ObjectType _value, $Res Function(ObjectType) _then)
      : super(_value, (v) => _then(v as ObjectType));

  @override
  ObjectType get _value => super._value as ObjectType;

  @override
  $Res call({
    Object? name = freezed,
    Object? fields = freezed,
    Object? description = freezed,
  }) {
    return _then(ObjectType(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      fields: fields == freezed
          ? _value.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<ObjectMember>,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('object')
class _$ObjectType extends ObjectType {
  const _$ObjectType(
      {required this.name, required this.fields, this.description})
      : super._();

  factory _$ObjectType.fromJson(Map<String, dynamic> json) =>
      _$$ObjectTypeFromJson(json);

  @override
  final String name;
  @override
  final List<ObjectMember> fields;
  @override
  final String? description;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ObjectType &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.fields, fields) ||
                const DeepCollectionEquality().equals(other.fields, fields)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(fields) ^
      const DeepCollectionEquality().hash(description);

  @JsonKey(ignore: true)
  @override
  $ObjectTypeCopyWith<ObjectType> get copyWith =>
      _$ObjectTypeCopyWithImpl<ObjectType>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String name, List<EnumValue> values, String description)
        enumType,
    required TResult Function(
            String name, List<ObjectMember> fields, String? description)
        objectType,
    required TResult Function(String name, String description, String type)
        alias,
  }) {
    return objectType(name, fields, description);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name, List<EnumValue> values, String description)?
        enumType,
    TResult Function(
            String name, List<ObjectMember> fields, String? description)?
        objectType,
    TResult Function(String name, String description, String type)? alias,
  }) {
    return objectType?.call(name, fields, description);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, List<EnumValue> values, String description)?
        enumType,
    TResult Function(
            String name, List<ObjectMember> fields, String? description)?
        objectType,
    TResult Function(String name, String description, String type)? alias,
    required TResult orElse(),
  }) {
    if (objectType != null) {
      return objectType(name, fields, description);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EnumType value) enumType,
    required TResult Function(ObjectType value) objectType,
    required TResult Function(AliasType value) alias,
  }) {
    return objectType(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(EnumType value)? enumType,
    TResult Function(ObjectType value)? objectType,
    TResult Function(AliasType value)? alias,
  }) {
    return objectType?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EnumType value)? enumType,
    TResult Function(ObjectType value)? objectType,
    TResult Function(AliasType value)? alias,
    required TResult orElse(),
  }) {
    if (objectType != null) {
      return objectType(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ObjectTypeToJson(this)..['type'] = 'object';
  }
}

abstract class ObjectType extends TypeDefinition {
  const factory ObjectType(
      {required String name,
      required List<ObjectMember> fields,
      String? description}) = _$ObjectType;
  const ObjectType._() : super._();

  factory ObjectType.fromJson(Map<String, dynamic> json) =
      _$ObjectType.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  List<ObjectMember> get fields => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $ObjectTypeCopyWith<ObjectType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AliasTypeCopyWith<$Res>
    implements $TypeDefinitionCopyWith<$Res> {
  factory $AliasTypeCopyWith(AliasType value, $Res Function(AliasType) then) =
      _$AliasTypeCopyWithImpl<$Res>;
  @override
  $Res call({String name, String description, String type});
}

/// @nodoc
class _$AliasTypeCopyWithImpl<$Res> extends _$TypeDefinitionCopyWithImpl<$Res>
    implements $AliasTypeCopyWith<$Res> {
  _$AliasTypeCopyWithImpl(AliasType _value, $Res Function(AliasType) _then)
      : super(_value, (v) => _then(v as AliasType));

  @override
  AliasType get _value => super._value as AliasType;

  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? type = freezed,
  }) {
    return _then(AliasType(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AliasType extends AliasType {
  const _$AliasType(
      {required this.name, required this.description, required this.type})
      : super._();

  factory _$AliasType.fromJson(Map<String, dynamic> json) =>
      _$$AliasTypeFromJson(json);

  @override
  final String name;
  @override
  final String description;
  @override
  final String type;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AliasType &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(type);

  @JsonKey(ignore: true)
  @override
  $AliasTypeCopyWith<AliasType> get copyWith =>
      _$AliasTypeCopyWithImpl<AliasType>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String name, List<EnumValue> values, String description)
        enumType,
    required TResult Function(
            String name, List<ObjectMember> fields, String? description)
        objectType,
    required TResult Function(String name, String description, String type)
        alias,
  }) {
    return alias(name, description, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name, List<EnumValue> values, String description)?
        enumType,
    TResult Function(
            String name, List<ObjectMember> fields, String? description)?
        objectType,
    TResult Function(String name, String description, String type)? alias,
  }) {
    return alias?.call(name, description, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, List<EnumValue> values, String description)?
        enumType,
    TResult Function(
            String name, List<ObjectMember> fields, String? description)?
        objectType,
    TResult Function(String name, String description, String type)? alias,
    required TResult orElse(),
  }) {
    if (alias != null) {
      return alias(name, description, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EnumType value) enumType,
    required TResult Function(ObjectType value) objectType,
    required TResult Function(AliasType value) alias,
  }) {
    return alias(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(EnumType value)? enumType,
    TResult Function(ObjectType value)? objectType,
    TResult Function(AliasType value)? alias,
  }) {
    return alias?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EnumType value)? enumType,
    TResult Function(ObjectType value)? objectType,
    TResult Function(AliasType value)? alias,
    required TResult orElse(),
  }) {
    if (alias != null) {
      return alias(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AliasTypeToJson(this)..['type'] = 'alias';
  }
}

abstract class AliasType extends TypeDefinition {
  const factory AliasType(
      {required String name,
      required String description,
      required String type}) = _$AliasType;
  const AliasType._() : super._();

  factory AliasType.fromJson(Map<String, dynamic> json) = _$AliasType.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $AliasTypeCopyWith<AliasType> get copyWith =>
      throw _privateConstructorUsedError;
}
