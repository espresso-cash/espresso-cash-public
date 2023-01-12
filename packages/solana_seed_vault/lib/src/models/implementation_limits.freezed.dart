// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'implementation_limits.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ImplementationLimits {
  int get maxBip32PathDepth => throw _privateConstructorUsedError;
  int get maxSigningRequests => throw _privateConstructorUsedError;
  int get maxRequestedSignatures => throw _privateConstructorUsedError;
  int get maxRequestedPublicKeys => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ImplementationLimitsCopyWith<ImplementationLimits> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImplementationLimitsCopyWith<$Res> {
  factory $ImplementationLimitsCopyWith(ImplementationLimits value,
          $Res Function(ImplementationLimits) then) =
      _$ImplementationLimitsCopyWithImpl<$Res, ImplementationLimits>;
  @useResult
  $Res call(
      {int maxBip32PathDepth,
      int maxSigningRequests,
      int maxRequestedSignatures,
      int maxRequestedPublicKeys});
}

/// @nodoc
class _$ImplementationLimitsCopyWithImpl<$Res,
        $Val extends ImplementationLimits>
    implements $ImplementationLimitsCopyWith<$Res> {
  _$ImplementationLimitsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxBip32PathDepth = null,
    Object? maxSigningRequests = null,
    Object? maxRequestedSignatures = null,
    Object? maxRequestedPublicKeys = null,
  }) {
    return _then(_value.copyWith(
      maxBip32PathDepth: null == maxBip32PathDepth
          ? _value.maxBip32PathDepth
          : maxBip32PathDepth // ignore: cast_nullable_to_non_nullable
              as int,
      maxSigningRequests: null == maxSigningRequests
          ? _value.maxSigningRequests
          : maxSigningRequests // ignore: cast_nullable_to_non_nullable
              as int,
      maxRequestedSignatures: null == maxRequestedSignatures
          ? _value.maxRequestedSignatures
          : maxRequestedSignatures // ignore: cast_nullable_to_non_nullable
              as int,
      maxRequestedPublicKeys: null == maxRequestedPublicKeys
          ? _value.maxRequestedPublicKeys
          : maxRequestedPublicKeys // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ImplementationLimitsCopyWith<$Res>
    implements $ImplementationLimitsCopyWith<$Res> {
  factory _$$_ImplementationLimitsCopyWith(_$_ImplementationLimits value,
          $Res Function(_$_ImplementationLimits) then) =
      __$$_ImplementationLimitsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int maxBip32PathDepth,
      int maxSigningRequests,
      int maxRequestedSignatures,
      int maxRequestedPublicKeys});
}

/// @nodoc
class __$$_ImplementationLimitsCopyWithImpl<$Res>
    extends _$ImplementationLimitsCopyWithImpl<$Res, _$_ImplementationLimits>
    implements _$$_ImplementationLimitsCopyWith<$Res> {
  __$$_ImplementationLimitsCopyWithImpl(_$_ImplementationLimits _value,
      $Res Function(_$_ImplementationLimits) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxBip32PathDepth = null,
    Object? maxSigningRequests = null,
    Object? maxRequestedSignatures = null,
    Object? maxRequestedPublicKeys = null,
  }) {
    return _then(_$_ImplementationLimits(
      maxBip32PathDepth: null == maxBip32PathDepth
          ? _value.maxBip32PathDepth
          : maxBip32PathDepth // ignore: cast_nullable_to_non_nullable
              as int,
      maxSigningRequests: null == maxSigningRequests
          ? _value.maxSigningRequests
          : maxSigningRequests // ignore: cast_nullable_to_non_nullable
              as int,
      maxRequestedSignatures: null == maxRequestedSignatures
          ? _value.maxRequestedSignatures
          : maxRequestedSignatures // ignore: cast_nullable_to_non_nullable
              as int,
      maxRequestedPublicKeys: null == maxRequestedPublicKeys
          ? _value.maxRequestedPublicKeys
          : maxRequestedPublicKeys // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_ImplementationLimits implements _ImplementationLimits {
  const _$_ImplementationLimits(
      {required this.maxBip32PathDepth,
      required this.maxSigningRequests,
      required this.maxRequestedSignatures,
      required this.maxRequestedPublicKeys});

  @override
  final int maxBip32PathDepth;
  @override
  final int maxSigningRequests;
  @override
  final int maxRequestedSignatures;
  @override
  final int maxRequestedPublicKeys;

  @override
  String toString() {
    return 'ImplementationLimits(maxBip32PathDepth: $maxBip32PathDepth, maxSigningRequests: $maxSigningRequests, maxRequestedSignatures: $maxRequestedSignatures, maxRequestedPublicKeys: $maxRequestedPublicKeys)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ImplementationLimits &&
            (identical(other.maxBip32PathDepth, maxBip32PathDepth) ||
                other.maxBip32PathDepth == maxBip32PathDepth) &&
            (identical(other.maxSigningRequests, maxSigningRequests) ||
                other.maxSigningRequests == maxSigningRequests) &&
            (identical(other.maxRequestedSignatures, maxRequestedSignatures) ||
                other.maxRequestedSignatures == maxRequestedSignatures) &&
            (identical(other.maxRequestedPublicKeys, maxRequestedPublicKeys) ||
                other.maxRequestedPublicKeys == maxRequestedPublicKeys));
  }

  @override
  int get hashCode => Object.hash(runtimeType, maxBip32PathDepth,
      maxSigningRequests, maxRequestedSignatures, maxRequestedPublicKeys);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ImplementationLimitsCopyWith<_$_ImplementationLimits> get copyWith =>
      __$$_ImplementationLimitsCopyWithImpl<_$_ImplementationLimits>(
          this, _$identity);
}

abstract class _ImplementationLimits implements ImplementationLimits {
  const factory _ImplementationLimits(
      {required final int maxBip32PathDepth,
      required final int maxSigningRequests,
      required final int maxRequestedSignatures,
      required final int maxRequestedPublicKeys}) = _$_ImplementationLimits;

  @override
  int get maxBip32PathDepth;
  @override
  int get maxSigningRequests;
  @override
  int get maxRequestedSignatures;
  @override
  int get maxRequestedPublicKeys;
  @override
  @JsonKey(ignore: true)
  _$$_ImplementationLimitsCopyWith<_$_ImplementationLimits> get copyWith =>
      throw _privateConstructorUsedError;
}
