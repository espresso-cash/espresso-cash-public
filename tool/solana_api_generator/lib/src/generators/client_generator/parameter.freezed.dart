// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'parameter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Parameter _$ParameterFromJson(Map<String, dynamic> json) {
  return _Parameter.fromJson(json);
}

/// @nodoc
class _$ParameterTearOff {
  const _$ParameterTearOff();

  _Parameter call(
      {required String type,
      required String name,
      required String description,
      required String? url,
      @JsonKey(name: 'is_optional')
          required bool isOptional,
      @JsonKey(name: 'default_value')
          required dynamic defaultValue,
      @JsonKey(name: 'with_default_parameter')
          bool withDefaultParameter = false}) {
    return _Parameter(
      type: type,
      name: name,
      description: description,
      url: url,
      isOptional: isOptional,
      defaultValue: defaultValue,
      withDefaultParameter: withDefaultParameter,
    );
  }

  Parameter fromJson(Map<String, Object> json) {
    return Parameter.fromJson(json);
  }
}

/// @nodoc
const $Parameter = _$ParameterTearOff();

/// @nodoc
mixin _$Parameter {
  String get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_optional')
  bool get isOptional => throw _privateConstructorUsedError;
  @JsonKey(name: 'default_value')
  dynamic get defaultValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'with_default_parameter')
  bool get withDefaultParameter => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ParameterCopyWith<Parameter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParameterCopyWith<$Res> {
  factory $ParameterCopyWith(Parameter value, $Res Function(Parameter) then) =
      _$ParameterCopyWithImpl<$Res>;
  $Res call(
      {String type,
      String name,
      String description,
      String? url,
      @JsonKey(name: 'is_optional') bool isOptional,
      @JsonKey(name: 'default_value') dynamic defaultValue,
      @JsonKey(name: 'with_default_parameter') bool withDefaultParameter});
}

/// @nodoc
class _$ParameterCopyWithImpl<$Res> implements $ParameterCopyWith<$Res> {
  _$ParameterCopyWithImpl(this._value, this._then);

  final Parameter _value;
  // ignore: unused_field
  final $Res Function(Parameter) _then;

  @override
  $Res call({
    Object? type = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? url = freezed,
    Object? isOptional = freezed,
    Object? defaultValue = freezed,
    Object? withDefaultParameter = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      isOptional: isOptional == freezed
          ? _value.isOptional
          : isOptional // ignore: cast_nullable_to_non_nullable
              as bool,
      defaultValue: defaultValue == freezed
          ? _value.defaultValue
          : defaultValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
      withDefaultParameter: withDefaultParameter == freezed
          ? _value.withDefaultParameter
          : withDefaultParameter // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$ParameterCopyWith<$Res> implements $ParameterCopyWith<$Res> {
  factory _$ParameterCopyWith(
          _Parameter value, $Res Function(_Parameter) then) =
      __$ParameterCopyWithImpl<$Res>;
  @override
  $Res call(
      {String type,
      String name,
      String description,
      String? url,
      @JsonKey(name: 'is_optional') bool isOptional,
      @JsonKey(name: 'default_value') dynamic defaultValue,
      @JsonKey(name: 'with_default_parameter') bool withDefaultParameter});
}

/// @nodoc
class __$ParameterCopyWithImpl<$Res> extends _$ParameterCopyWithImpl<$Res>
    implements _$ParameterCopyWith<$Res> {
  __$ParameterCopyWithImpl(_Parameter _value, $Res Function(_Parameter) _then)
      : super(_value, (v) => _then(v as _Parameter));

  @override
  _Parameter get _value => super._value as _Parameter;

  @override
  $Res call({
    Object? type = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? url = freezed,
    Object? isOptional = freezed,
    Object? defaultValue = freezed,
    Object? withDefaultParameter = freezed,
  }) {
    return _then(_Parameter(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      isOptional: isOptional == freezed
          ? _value.isOptional
          : isOptional // ignore: cast_nullable_to_non_nullable
              as bool,
      defaultValue: defaultValue == freezed
          ? _value.defaultValue
          : defaultValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
      withDefaultParameter: withDefaultParameter == freezed
          ? _value.withDefaultParameter
          : withDefaultParameter // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Parameter extends _Parameter {
  const _$_Parameter(
      {required this.type,
      required this.name,
      required this.description,
      required this.url,
      @JsonKey(name: 'is_optional')
          required this.isOptional,
      @JsonKey(name: 'default_value')
          required this.defaultValue,
      @JsonKey(name: 'with_default_parameter')
          this.withDefaultParameter = false})
      : super._();

  factory _$_Parameter.fromJson(Map<String, dynamic> json) =>
      _$$_ParameterFromJson(json);

  @override
  final String type;
  @override
  final String name;
  @override
  final String description;
  @override
  final String? url;
  @override
  @JsonKey(name: 'is_optional')
  final bool isOptional;
  @override
  @JsonKey(name: 'default_value')
  final dynamic defaultValue;
  @override
  @JsonKey(name: 'with_default_parameter')
  final bool withDefaultParameter;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Parameter &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.isOptional, isOptional) ||
                const DeepCollectionEquality()
                    .equals(other.isOptional, isOptional)) &&
            (identical(other.defaultValue, defaultValue) ||
                const DeepCollectionEquality()
                    .equals(other.defaultValue, defaultValue)) &&
            (identical(other.withDefaultParameter, withDefaultParameter) ||
                const DeepCollectionEquality()
                    .equals(other.withDefaultParameter, withDefaultParameter)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(isOptional) ^
      const DeepCollectionEquality().hash(defaultValue) ^
      const DeepCollectionEquality().hash(withDefaultParameter);

  @JsonKey(ignore: true)
  @override
  _$ParameterCopyWith<_Parameter> get copyWith =>
      __$ParameterCopyWithImpl<_Parameter>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ParameterToJson(this);
  }
}

abstract class _Parameter extends Parameter {
  const factory _Parameter(
          {required String type,
          required String name,
          required String description,
          required String? url,
          @JsonKey(name: 'is_optional') required bool isOptional,
          @JsonKey(name: 'default_value') required dynamic defaultValue,
          @JsonKey(name: 'with_default_parameter') bool withDefaultParameter}) =
      _$_Parameter;
  const _Parameter._() : super._();

  factory _Parameter.fromJson(Map<String, dynamic> json) =
      _$_Parameter.fromJson;

  @override
  String get type => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get description => throw _privateConstructorUsedError;
  @override
  String? get url => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'is_optional')
  bool get isOptional => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'default_value')
  dynamic get defaultValue => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'with_default_parameter')
  bool get withDefaultParameter => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ParameterCopyWith<_Parameter> get copyWith =>
      throw _privateConstructorUsedError;
}
