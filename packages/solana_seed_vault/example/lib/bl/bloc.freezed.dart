// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SeedVaultState implements DiagnosticableTreeMixin {
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties..add(DiagnosticsProperty('type', 'SeedVaultState'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is SeedVaultState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SeedVaultState()';
  }
}

/// @nodoc
class $SeedVaultStateCopyWith<$Res> {
  $SeedVaultStateCopyWith(SeedVaultState _, $Res Function(SeedVaultState) __);
}

/// @nodoc

class SeedVaultStateNone with DiagnosticableTreeMixin implements SeedVaultState {
  const SeedVaultStateNone();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties..add(DiagnosticsProperty('type', 'SeedVaultState.none'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SeedVaultStateNone);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SeedVaultState.none()';
  }
}

/// @nodoc

class SeedVaultStateError with DiagnosticableTreeMixin implements SeedVaultState {
  const SeedVaultStateError(this.err);

  final String err;

  /// Create a copy of SeedVaultState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SeedVaultStateErrorCopyWith<SeedVaultStateError> get copyWith =>
      _$SeedVaultStateErrorCopyWithImpl<SeedVaultStateError>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'SeedVaultState.error'))
      ..add(DiagnosticsProperty('err', err));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SeedVaultStateError &&
            (identical(other.err, err) || other.err == err));
  }

  @override
  int get hashCode => Object.hash(runtimeType, err);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SeedVaultState.error(err: $err)';
  }
}

/// @nodoc
abstract mixin class $SeedVaultStateErrorCopyWith<$Res> implements $SeedVaultStateCopyWith<$Res> {
  factory $SeedVaultStateErrorCopyWith(
    SeedVaultStateError value,
    $Res Function(SeedVaultStateError) _then,
  ) = _$SeedVaultStateErrorCopyWithImpl;
  @useResult
  $Res call({String err});
}

/// @nodoc
class _$SeedVaultStateErrorCopyWithImpl<$Res> implements $SeedVaultStateErrorCopyWith<$Res> {
  _$SeedVaultStateErrorCopyWithImpl(this._self, this._then);

  final SeedVaultStateError _self;
  final $Res Function(SeedVaultStateError) _then;

  /// Create a copy of SeedVaultState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? err = null}) {
    return _then(
      SeedVaultStateError(
        null == err
            ? _self.err
            : err // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class SeedVaultStateUnauthorized with DiagnosticableTreeMixin implements SeedVaultState {
  const SeedVaultStateUnauthorized();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties..add(DiagnosticsProperty('type', 'SeedVaultState.unauthorized'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SeedVaultStateUnauthorized);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SeedVaultState.unauthorized()';
  }
}

/// @nodoc

class SeedVaultStateLoaded with DiagnosticableTreeMixin implements SeedVaultState {
  const SeedVaultStateLoaded({
    required final List<Seed> seeds,
    required this.limits,
    required this.hasUnauthorizedSeeds,
    required this.firstRequestedPublicKey,
    required this.lastRequestedPublicKey,
  }) : _seeds = seeds;

  final List<Seed> _seeds;
  List<Seed> get seeds {
    if (_seeds is EqualUnmodifiableListView) return _seeds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_seeds);
  }

  final ImplementationLimits limits;
  final bool hasUnauthorizedSeeds;
  final Uri? firstRequestedPublicKey;
  final Uri? lastRequestedPublicKey;

  /// Create a copy of SeedVaultState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SeedVaultStateLoadedCopyWith<SeedVaultStateLoaded> get copyWith =>
      _$SeedVaultStateLoadedCopyWithImpl<SeedVaultStateLoaded>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'SeedVaultState.loaded'))
      ..add(DiagnosticsProperty('seeds', seeds))
      ..add(DiagnosticsProperty('limits', limits))
      ..add(DiagnosticsProperty('hasUnauthorizedSeeds', hasUnauthorizedSeeds))
      ..add(DiagnosticsProperty('firstRequestedPublicKey', firstRequestedPublicKey))
      ..add(DiagnosticsProperty('lastRequestedPublicKey', lastRequestedPublicKey));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SeedVaultStateLoaded &&
            const DeepCollectionEquality().equals(other._seeds, _seeds) &&
            (identical(other.limits, limits) || other.limits == limits) &&
            (identical(other.hasUnauthorizedSeeds, hasUnauthorizedSeeds) ||
                other.hasUnauthorizedSeeds == hasUnauthorizedSeeds) &&
            (identical(other.firstRequestedPublicKey, firstRequestedPublicKey) ||
                other.firstRequestedPublicKey == firstRequestedPublicKey) &&
            (identical(other.lastRequestedPublicKey, lastRequestedPublicKey) ||
                other.lastRequestedPublicKey == lastRequestedPublicKey));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_seeds),
    limits,
    hasUnauthorizedSeeds,
    firstRequestedPublicKey,
    lastRequestedPublicKey,
  );

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SeedVaultState.loaded(seeds: $seeds, limits: $limits, hasUnauthorizedSeeds: $hasUnauthorizedSeeds, firstRequestedPublicKey: $firstRequestedPublicKey, lastRequestedPublicKey: $lastRequestedPublicKey)';
  }
}

/// @nodoc
abstract mixin class $SeedVaultStateLoadedCopyWith<$Res> implements $SeedVaultStateCopyWith<$Res> {
  factory $SeedVaultStateLoadedCopyWith(
    SeedVaultStateLoaded value,
    $Res Function(SeedVaultStateLoaded) _then,
  ) = _$SeedVaultStateLoadedCopyWithImpl;
  @useResult
  $Res call({
    List<Seed> seeds,
    ImplementationLimits limits,
    bool hasUnauthorizedSeeds,
    Uri? firstRequestedPublicKey,
    Uri? lastRequestedPublicKey,
  });

  $ImplementationLimitsCopyWith<$Res> get limits;
}

/// @nodoc
class _$SeedVaultStateLoadedCopyWithImpl<$Res> implements $SeedVaultStateLoadedCopyWith<$Res> {
  _$SeedVaultStateLoadedCopyWithImpl(this._self, this._then);

  final SeedVaultStateLoaded _self;
  final $Res Function(SeedVaultStateLoaded) _then;

  /// Create a copy of SeedVaultState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? seeds = null,
    Object? limits = null,
    Object? hasUnauthorizedSeeds = null,
    Object? firstRequestedPublicKey = freezed,
    Object? lastRequestedPublicKey = freezed,
  }) {
    return _then(
      SeedVaultStateLoaded(
        seeds:
            null == seeds
                ? _self._seeds
                : seeds // ignore: cast_nullable_to_non_nullable
                    as List<Seed>,
        limits:
            null == limits
                ? _self.limits
                : limits // ignore: cast_nullable_to_non_nullable
                    as ImplementationLimits,
        hasUnauthorizedSeeds:
            null == hasUnauthorizedSeeds
                ? _self.hasUnauthorizedSeeds
                : hasUnauthorizedSeeds // ignore: cast_nullable_to_non_nullable
                    as bool,
        firstRequestedPublicKey:
            freezed == firstRequestedPublicKey
                ? _self.firstRequestedPublicKey
                : firstRequestedPublicKey // ignore: cast_nullable_to_non_nullable
                    as Uri?,
        lastRequestedPublicKey:
            freezed == lastRequestedPublicKey
                ? _self.lastRequestedPublicKey
                : lastRequestedPublicKey // ignore: cast_nullable_to_non_nullable
                    as Uri?,
      ),
    );
  }

  /// Create a copy of SeedVaultState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ImplementationLimitsCopyWith<$Res> get limits {
    return $ImplementationLimitsCopyWith<$Res>(_self.limits, (value) {
      return _then(_self.copyWith(limits: value));
    });
  }
}
