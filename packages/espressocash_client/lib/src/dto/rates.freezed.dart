// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rates.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CryptoRateResponseDto {
  double get usdc;

  /// Create a copy of CryptoRateResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CryptoRateResponseDtoCopyWith<CryptoRateResponseDto> get copyWith =>
      _$CryptoRateResponseDtoCopyWithImpl<CryptoRateResponseDto>(
        this as CryptoRateResponseDto,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CryptoRateResponseDto &&
            (identical(other.usdc, usdc) || other.usdc == usdc));
  }

  @override
  int get hashCode => Object.hash(runtimeType, usdc);

  @override
  String toString() {
    return 'CryptoRateResponseDto(usdc: $usdc)';
  }
}

/// @nodoc
abstract mixin class $CryptoRateResponseDtoCopyWith<$Res> {
  factory $CryptoRateResponseDtoCopyWith(
    CryptoRateResponseDto value,
    $Res Function(CryptoRateResponseDto) _then,
  ) = _$CryptoRateResponseDtoCopyWithImpl;
  @useResult
  $Res call({double usdc});
}

/// @nodoc
class _$CryptoRateResponseDtoCopyWithImpl<$Res> implements $CryptoRateResponseDtoCopyWith<$Res> {
  _$CryptoRateResponseDtoCopyWithImpl(this._self, this._then);

  final CryptoRateResponseDto _self;
  final $Res Function(CryptoRateResponseDto) _then;

  /// Create a copy of CryptoRateResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? usdc = null}) {
    return _then(
      _self.copyWith(
        usdc:
            null == usdc
                ? _self.usdc
                : usdc // ignore: cast_nullable_to_non_nullable
                    as double,
      ),
    );
  }
}

/// @nodoc

class _CryptoRateResponseDto implements CryptoRateResponseDto {
  const _CryptoRateResponseDto({required this.usdc});

  @override
  final double usdc;

  /// Create a copy of CryptoRateResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CryptoRateResponseDtoCopyWith<_CryptoRateResponseDto> get copyWith =>
      __$CryptoRateResponseDtoCopyWithImpl<_CryptoRateResponseDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CryptoRateResponseDto &&
            (identical(other.usdc, usdc) || other.usdc == usdc));
  }

  @override
  int get hashCode => Object.hash(runtimeType, usdc);

  @override
  String toString() {
    return 'CryptoRateResponseDto(usdc: $usdc)';
  }
}

/// @nodoc
abstract mixin class _$CryptoRateResponseDtoCopyWith<$Res>
    implements $CryptoRateResponseDtoCopyWith<$Res> {
  factory _$CryptoRateResponseDtoCopyWith(
    _CryptoRateResponseDto value,
    $Res Function(_CryptoRateResponseDto) _then,
  ) = __$CryptoRateResponseDtoCopyWithImpl;
  @override
  @useResult
  $Res call({double usdc});
}

/// @nodoc
class __$CryptoRateResponseDtoCopyWithImpl<$Res> implements _$CryptoRateResponseDtoCopyWith<$Res> {
  __$CryptoRateResponseDtoCopyWithImpl(this._self, this._then);

  final _CryptoRateResponseDto _self;
  final $Res Function(_CryptoRateResponseDto) _then;

  /// Create a copy of CryptoRateResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? usdc = null}) {
    return _then(
      _CryptoRateResponseDto(
        usdc:
            null == usdc
                ? _self.usdc
                : usdc // ignore: cast_nullable_to_non_nullable
                    as double,
      ),
    );
  }
}

/// @nodoc
mixin _$FiatRateRequestDto {
  String get base;
  String get target;

  /// Create a copy of FiatRateRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FiatRateRequestDtoCopyWith<FiatRateRequestDto> get copyWith =>
      _$FiatRateRequestDtoCopyWithImpl<FiatRateRequestDto>(this as FiatRateRequestDto, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FiatRateRequestDto &&
            (identical(other.base, base) || other.base == base) &&
            (identical(other.target, target) || other.target == target));
  }

  @override
  int get hashCode => Object.hash(runtimeType, base, target);

  @override
  String toString() {
    return 'FiatRateRequestDto(base: $base, target: $target)';
  }
}

/// @nodoc
abstract mixin class $FiatRateRequestDtoCopyWith<$Res> {
  factory $FiatRateRequestDtoCopyWith(
    FiatRateRequestDto value,
    $Res Function(FiatRateRequestDto) _then,
  ) = _$FiatRateRequestDtoCopyWithImpl;
  @useResult
  $Res call({String base, String target});
}

/// @nodoc
class _$FiatRateRequestDtoCopyWithImpl<$Res> implements $FiatRateRequestDtoCopyWith<$Res> {
  _$FiatRateRequestDtoCopyWithImpl(this._self, this._then);

  final FiatRateRequestDto _self;
  final $Res Function(FiatRateRequestDto) _then;

  /// Create a copy of FiatRateRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? base = null, Object? target = null}) {
    return _then(
      _self.copyWith(
        base:
            null == base
                ? _self.base
                : base // ignore: cast_nullable_to_non_nullable
                    as String,
        target:
            null == target
                ? _self.target
                : target // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _FiatRateRequestDto implements FiatRateRequestDto {
  const _FiatRateRequestDto({required this.base, required this.target});

  @override
  final String base;
  @override
  final String target;

  /// Create a copy of FiatRateRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FiatRateRequestDtoCopyWith<_FiatRateRequestDto> get copyWith =>
      __$FiatRateRequestDtoCopyWithImpl<_FiatRateRequestDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FiatRateRequestDto &&
            (identical(other.base, base) || other.base == base) &&
            (identical(other.target, target) || other.target == target));
  }

  @override
  int get hashCode => Object.hash(runtimeType, base, target);

  @override
  String toString() {
    return 'FiatRateRequestDto(base: $base, target: $target)';
  }
}

/// @nodoc
abstract mixin class _$FiatRateRequestDtoCopyWith<$Res>
    implements $FiatRateRequestDtoCopyWith<$Res> {
  factory _$FiatRateRequestDtoCopyWith(
    _FiatRateRequestDto value,
    $Res Function(_FiatRateRequestDto) _then,
  ) = __$FiatRateRequestDtoCopyWithImpl;
  @override
  @useResult
  $Res call({String base, String target});
}

/// @nodoc
class __$FiatRateRequestDtoCopyWithImpl<$Res> implements _$FiatRateRequestDtoCopyWith<$Res> {
  __$FiatRateRequestDtoCopyWithImpl(this._self, this._then);

  final _FiatRateRequestDto _self;
  final $Res Function(_FiatRateRequestDto) _then;

  /// Create a copy of FiatRateRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? base = null, Object? target = null}) {
    return _then(
      _FiatRateRequestDto(
        base:
            null == base
                ? _self.base
                : base // ignore: cast_nullable_to_non_nullable
                    as String,
        target:
            null == target
                ? _self.target
                : target // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
mixin _$FiatRateResponseDto {
  double get rate;

  /// Create a copy of FiatRateResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FiatRateResponseDtoCopyWith<FiatRateResponseDto> get copyWith =>
      _$FiatRateResponseDtoCopyWithImpl<FiatRateResponseDto>(
        this as FiatRateResponseDto,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FiatRateResponseDto &&
            (identical(other.rate, rate) || other.rate == rate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, rate);

  @override
  String toString() {
    return 'FiatRateResponseDto(rate: $rate)';
  }
}

/// @nodoc
abstract mixin class $FiatRateResponseDtoCopyWith<$Res> {
  factory $FiatRateResponseDtoCopyWith(
    FiatRateResponseDto value,
    $Res Function(FiatRateResponseDto) _then,
  ) = _$FiatRateResponseDtoCopyWithImpl;
  @useResult
  $Res call({double rate});
}

/// @nodoc
class _$FiatRateResponseDtoCopyWithImpl<$Res> implements $FiatRateResponseDtoCopyWith<$Res> {
  _$FiatRateResponseDtoCopyWithImpl(this._self, this._then);

  final FiatRateResponseDto _self;
  final $Res Function(FiatRateResponseDto) _then;

  /// Create a copy of FiatRateResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? rate = null}) {
    return _then(
      _self.copyWith(
        rate:
            null == rate
                ? _self.rate
                : rate // ignore: cast_nullable_to_non_nullable
                    as double,
      ),
    );
  }
}

/// @nodoc

class _FiatRateResponseDto implements FiatRateResponseDto {
  const _FiatRateResponseDto({required this.rate});

  @override
  final double rate;

  /// Create a copy of FiatRateResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FiatRateResponseDtoCopyWith<_FiatRateResponseDto> get copyWith =>
      __$FiatRateResponseDtoCopyWithImpl<_FiatRateResponseDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FiatRateResponseDto &&
            (identical(other.rate, rate) || other.rate == rate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, rate);

  @override
  String toString() {
    return 'FiatRateResponseDto(rate: $rate)';
  }
}

/// @nodoc
abstract mixin class _$FiatRateResponseDtoCopyWith<$Res>
    implements $FiatRateResponseDtoCopyWith<$Res> {
  factory _$FiatRateResponseDtoCopyWith(
    _FiatRateResponseDto value,
    $Res Function(_FiatRateResponseDto) _then,
  ) = __$FiatRateResponseDtoCopyWithImpl;
  @override
  @useResult
  $Res call({double rate});
}

/// @nodoc
class __$FiatRateResponseDtoCopyWithImpl<$Res> implements _$FiatRateResponseDtoCopyWith<$Res> {
  __$FiatRateResponseDtoCopyWithImpl(this._self, this._then);

  final _FiatRateResponseDto _self;
  final $Res Function(_FiatRateResponseDto) _then;

  /// Create a copy of FiatRateResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? rate = null}) {
    return _then(
      _FiatRateResponseDto(
        rate:
            null == rate
                ? _self.rate
                : rate // ignore: cast_nullable_to_non_nullable
                    as double,
      ),
    );
  }
}
