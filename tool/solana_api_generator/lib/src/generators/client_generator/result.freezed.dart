// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Result _$ResultFromJson(Map<String, dynamic> json) {
  return _Result.fromJson(json);
}

/// @nodoc
class _$ResultTearOff {
  const _$ResultTearOff();

  _Result call(
      {required String type,
      required String description,
      bool wrapped = false,
      bool nullable = false}) {
    return _Result(
      type: type,
      description: description,
      wrapped: wrapped,
      nullable: nullable,
    );
  }

  Result fromJson(Map<String, Object> json) {
    return Result.fromJson(json);
  }
}

/// @nodoc
const $Result = _$ResultTearOff();

/// @nodoc
mixin _$Result {
  String get type => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  bool get wrapped => throw _privateConstructorUsedError;
  bool get nullable => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResultCopyWith<Result> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultCopyWith<$Res> {
  factory $ResultCopyWith(Result value, $Res Function(Result) then) =
      _$ResultCopyWithImpl<$Res>;
  $Res call({String type, String description, bool wrapped, bool nullable});
}

/// @nodoc
class _$ResultCopyWithImpl<$Res> implements $ResultCopyWith<$Res> {
  _$ResultCopyWithImpl(this._value, this._then);

  final Result _value;
  // ignore: unused_field
  final $Res Function(Result) _then;

  @override
  $Res call({
    Object? type = freezed,
    Object? description = freezed,
    Object? wrapped = freezed,
    Object? nullable = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      wrapped: wrapped == freezed
          ? _value.wrapped
          : wrapped // ignore: cast_nullable_to_non_nullable
              as bool,
      nullable: nullable == freezed
          ? _value.nullable
          : nullable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$ResultCopyWith<$Res> implements $ResultCopyWith<$Res> {
  factory _$ResultCopyWith(_Result value, $Res Function(_Result) then) =
      __$ResultCopyWithImpl<$Res>;
  @override
  $Res call({String type, String description, bool wrapped, bool nullable});
}

/// @nodoc
class __$ResultCopyWithImpl<$Res> extends _$ResultCopyWithImpl<$Res>
    implements _$ResultCopyWith<$Res> {
  __$ResultCopyWithImpl(_Result _value, $Res Function(_Result) _then)
      : super(_value, (v) => _then(v as _Result));

  @override
  _Result get _value => super._value as _Result;

  @override
  $Res call({
    Object? type = freezed,
    Object? description = freezed,
    Object? wrapped = freezed,
    Object? nullable = freezed,
  }) {
    return _then(_Result(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      wrapped: wrapped == freezed
          ? _value.wrapped
          : wrapped // ignore: cast_nullable_to_non_nullable
              as bool,
      nullable: nullable == freezed
          ? _value.nullable
          : nullable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Result extends _Result {
  const _$_Result(
      {required this.type,
      required this.description,
      this.wrapped = false,
      this.nullable = false})
      : super._();

  factory _$_Result.fromJson(Map<String, dynamic> json) =>
      _$$_ResultFromJson(json);

  @override
  final String type;
  @override
  final String description;
  @JsonKey(defaultValue: false)
  @override
  final bool wrapped;
  @JsonKey(defaultValue: false)
  @override
  final bool nullable;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Result &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.wrapped, wrapped) ||
                const DeepCollectionEquality()
                    .equals(other.wrapped, wrapped)) &&
            (identical(other.nullable, nullable) ||
                const DeepCollectionEquality()
                    .equals(other.nullable, nullable)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(wrapped) ^
      const DeepCollectionEquality().hash(nullable);

  @JsonKey(ignore: true)
  @override
  _$ResultCopyWith<_Result> get copyWith =>
      __$ResultCopyWithImpl<_Result>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ResultToJson(this);
  }
}

abstract class _Result extends Result {
  const factory _Result(
      {required String type,
      required String description,
      bool wrapped,
      bool nullable}) = _$_Result;
  const _Result._() : super._();

  factory _Result.fromJson(Map<String, dynamic> json) = _$_Result.fromJson;

  @override
  String get type => throw _privateConstructorUsedError;
  @override
  String get description => throw _privateConstructorUsedError;
  @override
  bool get wrapped => throw _privateConstructorUsedError;
  @override
  bool get nullable => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ResultCopyWith<_Result> get copyWith => throw _privateConstructorUsedError;
}
