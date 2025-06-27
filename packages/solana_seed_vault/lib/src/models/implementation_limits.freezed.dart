// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'implementation_limits.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ImplementationLimits {
  int get maxBip32PathDepth;
  int get maxSigningRequests;
  int get maxRequestedSignatures;
  int get maxRequestedPublicKeys;

  /// Create a copy of ImplementationLimits
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ImplementationLimitsCopyWith<ImplementationLimits> get copyWith =>
      _$ImplementationLimitsCopyWithImpl<ImplementationLimits>(
        this as ImplementationLimits,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ImplementationLimits &&
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
  int get hashCode => Object.hash(
    runtimeType,
    maxBip32PathDepth,
    maxSigningRequests,
    maxRequestedSignatures,
    maxRequestedPublicKeys,
  );

  @override
  String toString() {
    return 'ImplementationLimits(maxBip32PathDepth: $maxBip32PathDepth, maxSigningRequests: $maxSigningRequests, maxRequestedSignatures: $maxRequestedSignatures, maxRequestedPublicKeys: $maxRequestedPublicKeys)';
  }
}

/// @nodoc
abstract mixin class $ImplementationLimitsCopyWith<$Res> {
  factory $ImplementationLimitsCopyWith(
    ImplementationLimits value,
    $Res Function(ImplementationLimits) _then,
  ) = _$ImplementationLimitsCopyWithImpl;
  @useResult
  $Res call({
    int maxBip32PathDepth,
    int maxSigningRequests,
    int maxRequestedSignatures,
    int maxRequestedPublicKeys,
  });
}

/// @nodoc
class _$ImplementationLimitsCopyWithImpl<$Res> implements $ImplementationLimitsCopyWith<$Res> {
  _$ImplementationLimitsCopyWithImpl(this._self, this._then);

  final ImplementationLimits _self;
  final $Res Function(ImplementationLimits) _then;

  /// Create a copy of ImplementationLimits
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxBip32PathDepth = null,
    Object? maxSigningRequests = null,
    Object? maxRequestedSignatures = null,
    Object? maxRequestedPublicKeys = null,
  }) {
    return _then(
      _self.copyWith(
        maxBip32PathDepth:
            null == maxBip32PathDepth
                ? _self.maxBip32PathDepth
                : maxBip32PathDepth // ignore: cast_nullable_to_non_nullable
                    as int,
        maxSigningRequests:
            null == maxSigningRequests
                ? _self.maxSigningRequests
                : maxSigningRequests // ignore: cast_nullable_to_non_nullable
                    as int,
        maxRequestedSignatures:
            null == maxRequestedSignatures
                ? _self.maxRequestedSignatures
                : maxRequestedSignatures // ignore: cast_nullable_to_non_nullable
                    as int,
        maxRequestedPublicKeys:
            null == maxRequestedPublicKeys
                ? _self.maxRequestedPublicKeys
                : maxRequestedPublicKeys // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _ImplementationLimits implements ImplementationLimits {
  const _ImplementationLimits({
    required this.maxBip32PathDepth,
    required this.maxSigningRequests,
    required this.maxRequestedSignatures,
    required this.maxRequestedPublicKeys,
  });

  @override
  final int maxBip32PathDepth;
  @override
  final int maxSigningRequests;
  @override
  final int maxRequestedSignatures;
  @override
  final int maxRequestedPublicKeys;

  /// Create a copy of ImplementationLimits
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ImplementationLimitsCopyWith<_ImplementationLimits> get copyWith =>
      __$ImplementationLimitsCopyWithImpl<_ImplementationLimits>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ImplementationLimits &&
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
  int get hashCode => Object.hash(
    runtimeType,
    maxBip32PathDepth,
    maxSigningRequests,
    maxRequestedSignatures,
    maxRequestedPublicKeys,
  );

  @override
  String toString() {
    return 'ImplementationLimits(maxBip32PathDepth: $maxBip32PathDepth, maxSigningRequests: $maxSigningRequests, maxRequestedSignatures: $maxRequestedSignatures, maxRequestedPublicKeys: $maxRequestedPublicKeys)';
  }
}

/// @nodoc
abstract mixin class _$ImplementationLimitsCopyWith<$Res>
    implements $ImplementationLimitsCopyWith<$Res> {
  factory _$ImplementationLimitsCopyWith(
    _ImplementationLimits value,
    $Res Function(_ImplementationLimits) _then,
  ) = __$ImplementationLimitsCopyWithImpl;
  @override
  @useResult
  $Res call({
    int maxBip32PathDepth,
    int maxSigningRequests,
    int maxRequestedSignatures,
    int maxRequestedPublicKeys,
  });
}

/// @nodoc
class __$ImplementationLimitsCopyWithImpl<$Res> implements _$ImplementationLimitsCopyWith<$Res> {
  __$ImplementationLimitsCopyWithImpl(this._self, this._then);

  final _ImplementationLimits _self;
  final $Res Function(_ImplementationLimits) _then;

  /// Create a copy of ImplementationLimits
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? maxBip32PathDepth = null,
    Object? maxSigningRequests = null,
    Object? maxRequestedSignatures = null,
    Object? maxRequestedPublicKeys = null,
  }) {
    return _then(
      _ImplementationLimits(
        maxBip32PathDepth:
            null == maxBip32PathDepth
                ? _self.maxBip32PathDepth
                : maxBip32PathDepth // ignore: cast_nullable_to_non_nullable
                    as int,
        maxSigningRequests:
            null == maxSigningRequests
                ? _self.maxSigningRequests
                : maxSigningRequests // ignore: cast_nullable_to_non_nullable
                    as int,
        maxRequestedSignatures:
            null == maxRequestedSignatures
                ? _self.maxRequestedSignatures
                : maxRequestedSignatures // ignore: cast_nullable_to_non_nullable
                    as int,
        maxRequestedPublicKeys:
            null == maxRequestedPublicKeys
                ? _self.maxRequestedPublicKeys
                : maxRequestedPublicKeys // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}
