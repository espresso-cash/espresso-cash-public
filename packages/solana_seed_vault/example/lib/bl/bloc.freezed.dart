// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SeedVaultState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(String err) error,
    required TResult Function() unauthorized,
    required TResult Function(
      List<Seed> seeds,
      ImplementationLimits limits,
      bool hasUnauthorizedSeeds,
      Uri? firstRequestedPublicKey,
      Uri? lastRequestedPublicKey,
    )
    loaded,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(String err)? error,
    TResult? Function()? unauthorized,
    TResult? Function(
      List<Seed> seeds,
      ImplementationLimits limits,
      bool hasUnauthorizedSeeds,
      Uri? firstRequestedPublicKey,
      Uri? lastRequestedPublicKey,
    )?
    loaded,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(String err)? error,
    TResult Function()? unauthorized,
    TResult Function(
      List<Seed> seeds,
      ImplementationLimits limits,
      bool hasUnauthorizedSeeds,
      Uri? firstRequestedPublicKey,
      Uri? lastRequestedPublicKey,
    )?
    loaded,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_None value) none,
    required TResult Function(_Error value) error,
    required TResult Function(_Unauthorized value) unauthorized,
    required TResult Function(_Loaded value) loaded,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_None value)? none,
    TResult? Function(_Error value)? error,
    TResult? Function(_Unauthorized value)? unauthorized,
    TResult? Function(_Loaded value)? loaded,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_None value)? none,
    TResult Function(_Error value)? error,
    TResult Function(_Unauthorized value)? unauthorized,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeedVaultStateCopyWith<$Res> {
  factory $SeedVaultStateCopyWith(SeedVaultState value, $Res Function(SeedVaultState) then) =
      _$SeedVaultStateCopyWithImpl<$Res, SeedVaultState>;
}

/// @nodoc
class _$SeedVaultStateCopyWithImpl<$Res, $Val extends SeedVaultState>
    implements $SeedVaultStateCopyWith<$Res> {
  _$SeedVaultStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$NoneImplCopyWith<$Res> {
  factory _$$NoneImplCopyWith(_$NoneImpl value, $Res Function(_$NoneImpl) then) =
      __$$NoneImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NoneImplCopyWithImpl<$Res> extends _$SeedVaultStateCopyWithImpl<$Res, _$NoneImpl>
    implements _$$NoneImplCopyWith<$Res> {
  __$$NoneImplCopyWithImpl(_$NoneImpl _value, $Res Function(_$NoneImpl) _then)
    : super(_value, _then);
}

/// @nodoc

class _$NoneImpl with DiagnosticableTreeMixin implements _None {
  const _$NoneImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SeedVaultState.none()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'SeedVaultState.none'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _$NoneImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(String err) error,
    required TResult Function() unauthorized,
    required TResult Function(
      List<Seed> seeds,
      ImplementationLimits limits,
      bool hasUnauthorizedSeeds,
      Uri? firstRequestedPublicKey,
      Uri? lastRequestedPublicKey,
    )
    loaded,
  }) {
    return none();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(String err)? error,
    TResult? Function()? unauthorized,
    TResult? Function(
      List<Seed> seeds,
      ImplementationLimits limits,
      bool hasUnauthorizedSeeds,
      Uri? firstRequestedPublicKey,
      Uri? lastRequestedPublicKey,
    )?
    loaded,
  }) {
    return none?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(String err)? error,
    TResult Function()? unauthorized,
    TResult Function(
      List<Seed> seeds,
      ImplementationLimits limits,
      bool hasUnauthorizedSeeds,
      Uri? firstRequestedPublicKey,
      Uri? lastRequestedPublicKey,
    )?
    loaded,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_None value) none,
    required TResult Function(_Error value) error,
    required TResult Function(_Unauthorized value) unauthorized,
    required TResult Function(_Loaded value) loaded,
  }) {
    return none(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_None value)? none,
    TResult? Function(_Error value)? error,
    TResult? Function(_Unauthorized value)? unauthorized,
    TResult? Function(_Loaded value)? loaded,
  }) {
    return none?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_None value)? none,
    TResult Function(_Error value)? error,
    TResult Function(_Unauthorized value)? unauthorized,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none(this);
    }
    return orElse();
  }
}

abstract class _None implements SeedVaultState {
  const factory _None() = _$NoneImpl;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(_$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String err});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res> extends _$SeedVaultStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(_$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
    : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? err = null}) {
    return _then(
      _$ErrorImpl(
        null == err
            ? _value.err
            : err // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$ErrorImpl with DiagnosticableTreeMixin implements _Error {
  const _$ErrorImpl(this.err);

  @override
  final String err;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SeedVaultState.error(err: $err)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SeedVaultState.error'))
      ..add(DiagnosticsProperty('err', err));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.err, err) || other.err == err));
  }

  @override
  int get hashCode => Object.hash(runtimeType, err);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(String err) error,
    required TResult Function() unauthorized,
    required TResult Function(
      List<Seed> seeds,
      ImplementationLimits limits,
      bool hasUnauthorizedSeeds,
      Uri? firstRequestedPublicKey,
      Uri? lastRequestedPublicKey,
    )
    loaded,
  }) {
    return error(err);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(String err)? error,
    TResult? Function()? unauthorized,
    TResult? Function(
      List<Seed> seeds,
      ImplementationLimits limits,
      bool hasUnauthorizedSeeds,
      Uri? firstRequestedPublicKey,
      Uri? lastRequestedPublicKey,
    )?
    loaded,
  }) {
    return error?.call(err);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(String err)? error,
    TResult Function()? unauthorized,
    TResult Function(
      List<Seed> seeds,
      ImplementationLimits limits,
      bool hasUnauthorizedSeeds,
      Uri? firstRequestedPublicKey,
      Uri? lastRequestedPublicKey,
    )?
    loaded,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(err);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_None value) none,
    required TResult Function(_Error value) error,
    required TResult Function(_Unauthorized value) unauthorized,
    required TResult Function(_Loaded value) loaded,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_None value)? none,
    TResult? Function(_Error value)? error,
    TResult? Function(_Unauthorized value)? unauthorized,
    TResult? Function(_Loaded value)? loaded,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_None value)? none,
    TResult Function(_Error value)? error,
    TResult Function(_Unauthorized value)? unauthorized,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements SeedVaultState {
  const factory _Error(final String err) = _$ErrorImpl;

  String get err;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnauthorizedImplCopyWith<$Res> {
  factory _$$UnauthorizedImplCopyWith(
    _$UnauthorizedImpl value,
    $Res Function(_$UnauthorizedImpl) then,
  ) = __$$UnauthorizedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnauthorizedImplCopyWithImpl<$Res>
    extends _$SeedVaultStateCopyWithImpl<$Res, _$UnauthorizedImpl>
    implements _$$UnauthorizedImplCopyWith<$Res> {
  __$$UnauthorizedImplCopyWithImpl(
    _$UnauthorizedImpl _value,
    $Res Function(_$UnauthorizedImpl) _then,
  ) : super(_value, _then);
}

/// @nodoc

class _$UnauthorizedImpl with DiagnosticableTreeMixin implements _Unauthorized {
  const _$UnauthorizedImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SeedVaultState.unauthorized()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'SeedVaultState.unauthorized'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UnauthorizedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(String err) error,
    required TResult Function() unauthorized,
    required TResult Function(
      List<Seed> seeds,
      ImplementationLimits limits,
      bool hasUnauthorizedSeeds,
      Uri? firstRequestedPublicKey,
      Uri? lastRequestedPublicKey,
    )
    loaded,
  }) {
    return unauthorized();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(String err)? error,
    TResult? Function()? unauthorized,
    TResult? Function(
      List<Seed> seeds,
      ImplementationLimits limits,
      bool hasUnauthorizedSeeds,
      Uri? firstRequestedPublicKey,
      Uri? lastRequestedPublicKey,
    )?
    loaded,
  }) {
    return unauthorized?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(String err)? error,
    TResult Function()? unauthorized,
    TResult Function(
      List<Seed> seeds,
      ImplementationLimits limits,
      bool hasUnauthorizedSeeds,
      Uri? firstRequestedPublicKey,
      Uri? lastRequestedPublicKey,
    )?
    loaded,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_None value) none,
    required TResult Function(_Error value) error,
    required TResult Function(_Unauthorized value) unauthorized,
    required TResult Function(_Loaded value) loaded,
  }) {
    return unauthorized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_None value)? none,
    TResult? Function(_Error value)? error,
    TResult? Function(_Unauthorized value)? unauthorized,
    TResult? Function(_Loaded value)? loaded,
  }) {
    return unauthorized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_None value)? none,
    TResult Function(_Error value)? error,
    TResult Function(_Unauthorized value)? unauthorized,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized(this);
    }
    return orElse();
  }
}

abstract class _Unauthorized implements SeedVaultState {
  const factory _Unauthorized() = _$UnauthorizedImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(_$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
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
class __$$LoadedImplCopyWithImpl<$Res> extends _$SeedVaultStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(_$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
    : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seeds = null,
    Object? limits = null,
    Object? hasUnauthorizedSeeds = null,
    Object? firstRequestedPublicKey = freezed,
    Object? lastRequestedPublicKey = freezed,
  }) {
    return _then(
      _$LoadedImpl(
        seeds:
            null == seeds
                ? _value._seeds
                : seeds // ignore: cast_nullable_to_non_nullable
                    as List<Seed>,
        limits:
            null == limits
                ? _value.limits
                : limits // ignore: cast_nullable_to_non_nullable
                    as ImplementationLimits,
        hasUnauthorizedSeeds:
            null == hasUnauthorizedSeeds
                ? _value.hasUnauthorizedSeeds
                : hasUnauthorizedSeeds // ignore: cast_nullable_to_non_nullable
                    as bool,
        firstRequestedPublicKey:
            freezed == firstRequestedPublicKey
                ? _value.firstRequestedPublicKey
                : firstRequestedPublicKey // ignore: cast_nullable_to_non_nullable
                    as Uri?,
        lastRequestedPublicKey:
            freezed == lastRequestedPublicKey
                ? _value.lastRequestedPublicKey
                : lastRequestedPublicKey // ignore: cast_nullable_to_non_nullable
                    as Uri?,
      ),
    );
  }

  @override
  @pragma('vm:prefer-inline')
  $ImplementationLimitsCopyWith<$Res> get limits {
    return $ImplementationLimitsCopyWith<$Res>(_value.limits, (value) {
      return _then(_value.copyWith(limits: value));
    });
  }
}

/// @nodoc

class _$LoadedImpl with DiagnosticableTreeMixin implements _Loaded {
  const _$LoadedImpl({
    required final List<Seed> seeds,
    required this.limits,
    required this.hasUnauthorizedSeeds,
    required this.firstRequestedPublicKey,
    required this.lastRequestedPublicKey,
  }) : _seeds = seeds;

  final List<Seed> _seeds;
  @override
  List<Seed> get seeds {
    if (_seeds is EqualUnmodifiableListView) return _seeds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_seeds);
  }

  @override
  final ImplementationLimits limits;
  @override
  final bool hasUnauthorizedSeeds;
  @override
  final Uri? firstRequestedPublicKey;
  @override
  final Uri? lastRequestedPublicKey;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SeedVaultState.loaded(seeds: $seeds, limits: $limits, hasUnauthorizedSeeds: $hasUnauthorizedSeeds, firstRequestedPublicKey: $firstRequestedPublicKey, lastRequestedPublicKey: $lastRequestedPublicKey)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
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
            other is _$LoadedImpl &&
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(String err) error,
    required TResult Function() unauthorized,
    required TResult Function(
      List<Seed> seeds,
      ImplementationLimits limits,
      bool hasUnauthorizedSeeds,
      Uri? firstRequestedPublicKey,
      Uri? lastRequestedPublicKey,
    )
    loaded,
  }) {
    return loaded(
      seeds,
      limits,
      hasUnauthorizedSeeds,
      firstRequestedPublicKey,
      lastRequestedPublicKey,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(String err)? error,
    TResult? Function()? unauthorized,
    TResult? Function(
      List<Seed> seeds,
      ImplementationLimits limits,
      bool hasUnauthorizedSeeds,
      Uri? firstRequestedPublicKey,
      Uri? lastRequestedPublicKey,
    )?
    loaded,
  }) {
    return loaded?.call(
      seeds,
      limits,
      hasUnauthorizedSeeds,
      firstRequestedPublicKey,
      lastRequestedPublicKey,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(String err)? error,
    TResult Function()? unauthorized,
    TResult Function(
      List<Seed> seeds,
      ImplementationLimits limits,
      bool hasUnauthorizedSeeds,
      Uri? firstRequestedPublicKey,
      Uri? lastRequestedPublicKey,
    )?
    loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(
        seeds,
        limits,
        hasUnauthorizedSeeds,
        firstRequestedPublicKey,
        lastRequestedPublicKey,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_None value) none,
    required TResult Function(_Error value) error,
    required TResult Function(_Unauthorized value) unauthorized,
    required TResult Function(_Loaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_None value)? none,
    TResult? Function(_Error value)? error,
    TResult? Function(_Unauthorized value)? unauthorized,
    TResult? Function(_Loaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_None value)? none,
    TResult Function(_Error value)? error,
    TResult Function(_Unauthorized value)? unauthorized,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements SeedVaultState {
  const factory _Loaded({
    required final List<Seed> seeds,
    required final ImplementationLimits limits,
    required final bool hasUnauthorizedSeeds,
    required final Uri? firstRequestedPublicKey,
    required final Uri? lastRequestedPublicKey,
  }) = _$LoadedImpl;

  List<Seed> get seeds;
  ImplementationLimits get limits;
  bool get hasUnauthorizedSeeds;
  Uri? get firstRequestedPublicKey;
  Uri? get lastRequestedPublicKey;
  @JsonKey(ignore: true)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith => throw _privateConstructorUsedError;
}
