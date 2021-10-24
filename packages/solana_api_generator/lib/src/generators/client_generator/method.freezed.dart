// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'method.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Method _$MethodFromJson(Map<String, dynamic> json) {
  return _Method.fromJson(json);
}

/// @nodoc
class _$MethodTearOff {
  const _$MethodTearOff();

  _Method call(
      {required String name,
      required String description,
      @JsonKey(name: 'is_deprecated') bool isDeprecated = false,
      @JsonKey(name: 'is_new') bool isNew = false,
      required Result result,
      List<Parameter>? parameters}) {
    return _Method(
      name: name,
      description: description,
      isDeprecated: isDeprecated,
      isNew: isNew,
      result: result,
      parameters: parameters,
    );
  }

  Method fromJson(Map<String, Object> json) {
    return Method.fromJson(json);
  }
}

/// @nodoc
const $Method = _$MethodTearOff();

/// @nodoc
mixin _$Method {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_deprecated')
  bool get isDeprecated => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_new')
  bool get isNew => throw _privateConstructorUsedError;
  Result get result => throw _privateConstructorUsedError;
  List<Parameter>? get parameters => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MethodCopyWith<Method> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MethodCopyWith<$Res> {
  factory $MethodCopyWith(Method value, $Res Function(Method) then) =
      _$MethodCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String description,
      @JsonKey(name: 'is_deprecated') bool isDeprecated,
      @JsonKey(name: 'is_new') bool isNew,
      Result result,
      List<Parameter>? parameters});

  $ResultCopyWith<$Res> get result;
}

/// @nodoc
class _$MethodCopyWithImpl<$Res> implements $MethodCopyWith<$Res> {
  _$MethodCopyWithImpl(this._value, this._then);

  final Method _value;
  // ignore: unused_field
  final $Res Function(Method) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? isDeprecated = freezed,
    Object? isNew = freezed,
    Object? result = freezed,
    Object? parameters = freezed,
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
      isDeprecated: isDeprecated == freezed
          ? _value.isDeprecated
          : isDeprecated // ignore: cast_nullable_to_non_nullable
              as bool,
      isNew: isNew == freezed
          ? _value.isNew
          : isNew // ignore: cast_nullable_to_non_nullable
              as bool,
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Result,
      parameters: parameters == freezed
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as List<Parameter>?,
    ));
  }

  @override
  $ResultCopyWith<$Res> get result {
    return $ResultCopyWith<$Res>(_value.result, (value) {
      return _then(_value.copyWith(result: value));
    });
  }
}

/// @nodoc
abstract class _$MethodCopyWith<$Res> implements $MethodCopyWith<$Res> {
  factory _$MethodCopyWith(_Method value, $Res Function(_Method) then) =
      __$MethodCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String description,
      @JsonKey(name: 'is_deprecated') bool isDeprecated,
      @JsonKey(name: 'is_new') bool isNew,
      Result result,
      List<Parameter>? parameters});

  @override
  $ResultCopyWith<$Res> get result;
}

/// @nodoc
class __$MethodCopyWithImpl<$Res> extends _$MethodCopyWithImpl<$Res>
    implements _$MethodCopyWith<$Res> {
  __$MethodCopyWithImpl(_Method _value, $Res Function(_Method) _then)
      : super(_value, (v) => _then(v as _Method));

  @override
  _Method get _value => super._value as _Method;

  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? isDeprecated = freezed,
    Object? isNew = freezed,
    Object? result = freezed,
    Object? parameters = freezed,
  }) {
    return _then(_Method(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      isDeprecated: isDeprecated == freezed
          ? _value.isDeprecated
          : isDeprecated // ignore: cast_nullable_to_non_nullable
              as bool,
      isNew: isNew == freezed
          ? _value.isNew
          : isNew // ignore: cast_nullable_to_non_nullable
              as bool,
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Result,
      parameters: parameters == freezed
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as List<Parameter>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Method extends _Method {
  const _$_Method(
      {required this.name,
      required this.description,
      @JsonKey(name: 'is_deprecated') this.isDeprecated = false,
      @JsonKey(name: 'is_new') this.isNew = false,
      required this.result,
      this.parameters})
      : super._();

  factory _$_Method.fromJson(Map<String, dynamic> json) =>
      _$$_MethodFromJson(json);

  @override
  final String name;
  @override
  final String description;
  @override
  @JsonKey(name: 'is_deprecated')
  final bool isDeprecated;
  @override
  @JsonKey(name: 'is_new')
  final bool isNew;
  @override
  final Result result;
  @override
  final List<Parameter>? parameters;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Method &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.isDeprecated, isDeprecated) ||
                const DeepCollectionEquality()
                    .equals(other.isDeprecated, isDeprecated)) &&
            (identical(other.isNew, isNew) ||
                const DeepCollectionEquality().equals(other.isNew, isNew)) &&
            (identical(other.result, result) ||
                const DeepCollectionEquality().equals(other.result, result)) &&
            (identical(other.parameters, parameters) ||
                const DeepCollectionEquality()
                    .equals(other.parameters, parameters)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(isDeprecated) ^
      const DeepCollectionEquality().hash(isNew) ^
      const DeepCollectionEquality().hash(result) ^
      const DeepCollectionEquality().hash(parameters);

  @JsonKey(ignore: true)
  @override
  _$MethodCopyWith<_Method> get copyWith =>
      __$MethodCopyWithImpl<_Method>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MethodToJson(this);
  }
}

abstract class _Method extends Method {
  const factory _Method(
      {required String name,
      required String description,
      @JsonKey(name: 'is_deprecated') bool isDeprecated,
      @JsonKey(name: 'is_new') bool isNew,
      required Result result,
      List<Parameter>? parameters}) = _$_Method;
  const _Method._() : super._();

  factory _Method.fromJson(Map<String, dynamic> json) = _$_Method.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get description => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'is_deprecated')
  bool get isDeprecated => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'is_new')
  bool get isNew => throw _privateConstructorUsedError;
  @override
  Result get result => throw _privateConstructorUsedError;
  @override
  List<Parameter>? get parameters => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MethodCopyWith<_Method> get copyWith => throw _privateConstructorUsedError;
}
