// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'enum_value.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EnumValue _$EnumValueFromJson(Map<String, dynamic> json) {
  return _EnumValue.fromJson(json);
}

/// @nodoc
class _$EnumValueTearOff {
  const _$EnumValueTearOff();

  _EnumValue call({required String name, required String description}) {
    return _EnumValue(
      name: name,
      description: description,
    );
  }

  EnumValue fromJson(Map<String, Object> json) {
    return EnumValue.fromJson(json);
  }
}

/// @nodoc
const $EnumValue = _$EnumValueTearOff();

/// @nodoc
mixin _$EnumValue {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EnumValueCopyWith<EnumValue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnumValueCopyWith<$Res> {
  factory $EnumValueCopyWith(EnumValue value, $Res Function(EnumValue) then) =
      _$EnumValueCopyWithImpl<$Res>;
  $Res call({String name, String description});
}

/// @nodoc
class _$EnumValueCopyWithImpl<$Res> implements $EnumValueCopyWith<$Res> {
  _$EnumValueCopyWithImpl(this._value, this._then);

  final EnumValue _value;
  // ignore: unused_field
  final $Res Function(EnumValue) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$EnumValueCopyWith<$Res> implements $EnumValueCopyWith<$Res> {
  factory _$EnumValueCopyWith(
          _EnumValue value, $Res Function(_EnumValue) then) =
      __$EnumValueCopyWithImpl<$Res>;
  @override
  $Res call({String name, String description});
}

/// @nodoc
class __$EnumValueCopyWithImpl<$Res> extends _$EnumValueCopyWithImpl<$Res>
    implements _$EnumValueCopyWith<$Res> {
  __$EnumValueCopyWithImpl(_EnumValue _value, $Res Function(_EnumValue) _then)
      : super(_value, (v) => _then(v as _EnumValue));

  @override
  _EnumValue get _value => super._value as _EnumValue;

  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
  }) {
    return _then(_EnumValue(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EnumValue extends _EnumValue {
  const _$_EnumValue({required this.name, required this.description})
      : super._();

  factory _$_EnumValue.fromJson(Map<String, dynamic> json) =>
      _$$_EnumValueFromJson(json);

  @override
  final String name;
  @override
  final String description;

  @override
  String toString() {
    return 'EnumValue(name: $name, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _EnumValue &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description);

  @JsonKey(ignore: true)
  @override
  _$EnumValueCopyWith<_EnumValue> get copyWith =>
      __$EnumValueCopyWithImpl<_EnumValue>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EnumValueToJson(this);
  }
}

abstract class _EnumValue extends EnumValue {
  const factory _EnumValue(
      {required String name, required String description}) = _$_EnumValue;
  const _EnumValue._() : super._();

  factory _EnumValue.fromJson(Map<String, dynamic> json) =
      _$_EnumValue.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get description => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$EnumValueCopyWith<_EnumValue> get copyWith =>
      throw _privateConstructorUsedError;
}
