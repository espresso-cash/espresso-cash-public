// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'parsed_message_header.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ParsedMessageHeader _$ParsedMessageHeaderFromJson(Map<String, dynamic> json) {
  return _ParsedMessageHeader.fromJson(json);
}

/// @nodoc
class _$ParsedMessageHeaderTearOff {
  const _$ParsedMessageHeaderTearOff();

  _ParsedMessageHeader call(
      {required int numRequiredSignatures,
      required int numReadonlySignedAccounts,
      required int numReadonlyUnsignedAccounts}) {
    return _ParsedMessageHeader(
      numRequiredSignatures: numRequiredSignatures,
      numReadonlySignedAccounts: numReadonlySignedAccounts,
      numReadonlyUnsignedAccounts: numReadonlyUnsignedAccounts,
    );
  }

  ParsedMessageHeader fromJson(Map<String, Object> json) {
    return ParsedMessageHeader.fromJson(json);
  }
}

/// @nodoc
const $ParsedMessageHeader = _$ParsedMessageHeaderTearOff();

/// @nodoc
mixin _$ParsedMessageHeader {
  int get numRequiredSignatures => throw _privateConstructorUsedError;
  int get numReadonlySignedAccounts => throw _privateConstructorUsedError;
  int get numReadonlyUnsignedAccounts => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ParsedMessageHeaderCopyWith<ParsedMessageHeader> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParsedMessageHeaderCopyWith<$Res> {
  factory $ParsedMessageHeaderCopyWith(
          ParsedMessageHeader value, $Res Function(ParsedMessageHeader) then) =
      _$ParsedMessageHeaderCopyWithImpl<$Res>;
  $Res call(
      {int numRequiredSignatures,
      int numReadonlySignedAccounts,
      int numReadonlyUnsignedAccounts});
}

/// @nodoc
class _$ParsedMessageHeaderCopyWithImpl<$Res>
    implements $ParsedMessageHeaderCopyWith<$Res> {
  _$ParsedMessageHeaderCopyWithImpl(this._value, this._then);

  final ParsedMessageHeader _value;
  // ignore: unused_field
  final $Res Function(ParsedMessageHeader) _then;

  @override
  $Res call({
    Object? numRequiredSignatures = freezed,
    Object? numReadonlySignedAccounts = freezed,
    Object? numReadonlyUnsignedAccounts = freezed,
  }) {
    return _then(_value.copyWith(
      numRequiredSignatures: numRequiredSignatures == freezed
          ? _value.numRequiredSignatures
          : numRequiredSignatures // ignore: cast_nullable_to_non_nullable
              as int,
      numReadonlySignedAccounts: numReadonlySignedAccounts == freezed
          ? _value.numReadonlySignedAccounts
          : numReadonlySignedAccounts // ignore: cast_nullable_to_non_nullable
              as int,
      numReadonlyUnsignedAccounts: numReadonlyUnsignedAccounts == freezed
          ? _value.numReadonlyUnsignedAccounts
          : numReadonlyUnsignedAccounts // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$ParsedMessageHeaderCopyWith<$Res>
    implements $ParsedMessageHeaderCopyWith<$Res> {
  factory _$ParsedMessageHeaderCopyWith(_ParsedMessageHeader value,
          $Res Function(_ParsedMessageHeader) then) =
      __$ParsedMessageHeaderCopyWithImpl<$Res>;
  @override
  $Res call(
      {int numRequiredSignatures,
      int numReadonlySignedAccounts,
      int numReadonlyUnsignedAccounts});
}

/// @nodoc
class __$ParsedMessageHeaderCopyWithImpl<$Res>
    extends _$ParsedMessageHeaderCopyWithImpl<$Res>
    implements _$ParsedMessageHeaderCopyWith<$Res> {
  __$ParsedMessageHeaderCopyWithImpl(
      _ParsedMessageHeader _value, $Res Function(_ParsedMessageHeader) _then)
      : super(_value, (v) => _then(v as _ParsedMessageHeader));

  @override
  _ParsedMessageHeader get _value => super._value as _ParsedMessageHeader;

  @override
  $Res call({
    Object? numRequiredSignatures = freezed,
    Object? numReadonlySignedAccounts = freezed,
    Object? numReadonlyUnsignedAccounts = freezed,
  }) {
    return _then(_ParsedMessageHeader(
      numRequiredSignatures: numRequiredSignatures == freezed
          ? _value.numRequiredSignatures
          : numRequiredSignatures // ignore: cast_nullable_to_non_nullable
              as int,
      numReadonlySignedAccounts: numReadonlySignedAccounts == freezed
          ? _value.numReadonlySignedAccounts
          : numReadonlySignedAccounts // ignore: cast_nullable_to_non_nullable
              as int,
      numReadonlyUnsignedAccounts: numReadonlyUnsignedAccounts == freezed
          ? _value.numReadonlyUnsignedAccounts
          : numReadonlyUnsignedAccounts // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ParsedMessageHeader implements _ParsedMessageHeader {
  const _$_ParsedMessageHeader(
      {required this.numRequiredSignatures,
      required this.numReadonlySignedAccounts,
      required this.numReadonlyUnsignedAccounts});

  factory _$_ParsedMessageHeader.fromJson(Map<String, dynamic> json) =>
      _$$_ParsedMessageHeaderFromJson(json);

  @override
  final int numRequiredSignatures;
  @override
  final int numReadonlySignedAccounts;
  @override
  final int numReadonlyUnsignedAccounts;

  @override
  String toString() {
    return 'ParsedMessageHeader(numRequiredSignatures: $numRequiredSignatures, numReadonlySignedAccounts: $numReadonlySignedAccounts, numReadonlyUnsignedAccounts: $numReadonlyUnsignedAccounts)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ParsedMessageHeader &&
            (identical(other.numRequiredSignatures, numRequiredSignatures) ||
                const DeepCollectionEquality().equals(
                    other.numRequiredSignatures, numRequiredSignatures)) &&
            (identical(other.numReadonlySignedAccounts,
                    numReadonlySignedAccounts) ||
                const DeepCollectionEquality().equals(
                    other.numReadonlySignedAccounts,
                    numReadonlySignedAccounts)) &&
            (identical(other.numReadonlyUnsignedAccounts,
                    numReadonlyUnsignedAccounts) ||
                const DeepCollectionEquality().equals(
                    other.numReadonlyUnsignedAccounts,
                    numReadonlyUnsignedAccounts)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(numRequiredSignatures) ^
      const DeepCollectionEquality().hash(numReadonlySignedAccounts) ^
      const DeepCollectionEquality().hash(numReadonlyUnsignedAccounts);

  @JsonKey(ignore: true)
  @override
  _$ParsedMessageHeaderCopyWith<_ParsedMessageHeader> get copyWith =>
      __$ParsedMessageHeaderCopyWithImpl<_ParsedMessageHeader>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ParsedMessageHeaderToJson(this);
  }
}

abstract class _ParsedMessageHeader implements ParsedMessageHeader {
  const factory _ParsedMessageHeader(
      {required int numRequiredSignatures,
      required int numReadonlySignedAccounts,
      required int numReadonlyUnsignedAccounts}) = _$_ParsedMessageHeader;

  factory _ParsedMessageHeader.fromJson(Map<String, dynamic> json) =
      _$_ParsedMessageHeader.fromJson;

  @override
  int get numRequiredSignatures => throw _privateConstructorUsedError;
  @override
  int get numReadonlySignedAccounts => throw _privateConstructorUsedError;
  @override
  int get numReadonlyUnsignedAccounts => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ParsedMessageHeaderCopyWith<_ParsedMessageHeader> get copyWith =>
      throw _privateConstructorUsedError;
}
