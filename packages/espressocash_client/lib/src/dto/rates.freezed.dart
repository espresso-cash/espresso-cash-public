// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rates.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CryptoRateResponseDto {
  double get usdc => throw _privateConstructorUsedError;

  /// Create a copy of CryptoRateResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CryptoRateResponseDtoCopyWith<CryptoRateResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CryptoRateResponseDtoCopyWith<$Res> {
  factory $CryptoRateResponseDtoCopyWith(
    CryptoRateResponseDto value,
    $Res Function(CryptoRateResponseDto) then,
  ) = _$CryptoRateResponseDtoCopyWithImpl<$Res, CryptoRateResponseDto>;
  @useResult
  $Res call({double usdc});
}

/// @nodoc
class _$CryptoRateResponseDtoCopyWithImpl<$Res, $Val extends CryptoRateResponseDto>
    implements $CryptoRateResponseDtoCopyWith<$Res> {
  _$CryptoRateResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CryptoRateResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? usdc = null}) {
    return _then(
      _value.copyWith(
            usdc:
                null == usdc
                    ? _value.usdc
                    : usdc // ignore: cast_nullable_to_non_nullable
                        as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CryptoRateResponseDtoImplCopyWith<$Res>
    implements $CryptoRateResponseDtoCopyWith<$Res> {
  factory _$$CryptoRateResponseDtoImplCopyWith(
    _$CryptoRateResponseDtoImpl value,
    $Res Function(_$CryptoRateResponseDtoImpl) then,
  ) = __$$CryptoRateResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double usdc});
}

/// @nodoc
class __$$CryptoRateResponseDtoImplCopyWithImpl<$Res>
    extends _$CryptoRateResponseDtoCopyWithImpl<$Res, _$CryptoRateResponseDtoImpl>
    implements _$$CryptoRateResponseDtoImplCopyWith<$Res> {
  __$$CryptoRateResponseDtoImplCopyWithImpl(
    _$CryptoRateResponseDtoImpl _value,
    $Res Function(_$CryptoRateResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CryptoRateResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? usdc = null}) {
    return _then(
      _$CryptoRateResponseDtoImpl(
        usdc:
            null == usdc
                ? _value.usdc
                : usdc // ignore: cast_nullable_to_non_nullable
                    as double,
      ),
    );
  }
}

/// @nodoc

class _$CryptoRateResponseDtoImpl implements _CryptoRateResponseDto {
  const _$CryptoRateResponseDtoImpl({required this.usdc});

  @override
  final double usdc;

  @override
  String toString() {
    return 'CryptoRateResponseDto(usdc: $usdc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CryptoRateResponseDtoImpl &&
            (identical(other.usdc, usdc) || other.usdc == usdc));
  }

  @override
  int get hashCode => Object.hash(runtimeType, usdc);

  /// Create a copy of CryptoRateResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CryptoRateResponseDtoImplCopyWith<_$CryptoRateResponseDtoImpl> get copyWith =>
      __$$CryptoRateResponseDtoImplCopyWithImpl<_$CryptoRateResponseDtoImpl>(this, _$identity);
}

abstract class _CryptoRateResponseDto implements CryptoRateResponseDto {
  const factory _CryptoRateResponseDto({required final double usdc}) = _$CryptoRateResponseDtoImpl;

  @override
  double get usdc;

  /// Create a copy of CryptoRateResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CryptoRateResponseDtoImplCopyWith<_$CryptoRateResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FiatRateRequestDto {
  String get base => throw _privateConstructorUsedError;
  String get target => throw _privateConstructorUsedError;

  /// Create a copy of FiatRateRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FiatRateRequestDtoCopyWith<FiatRateRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FiatRateRequestDtoCopyWith<$Res> {
  factory $FiatRateRequestDtoCopyWith(
    FiatRateRequestDto value,
    $Res Function(FiatRateRequestDto) then,
  ) = _$FiatRateRequestDtoCopyWithImpl<$Res, FiatRateRequestDto>;
  @useResult
  $Res call({String base, String target});
}

/// @nodoc
class _$FiatRateRequestDtoCopyWithImpl<$Res, $Val extends FiatRateRequestDto>
    implements $FiatRateRequestDtoCopyWith<$Res> {
  _$FiatRateRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FiatRateRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? base = null, Object? target = null}) {
    return _then(
      _value.copyWith(
            base:
                null == base
                    ? _value.base
                    : base // ignore: cast_nullable_to_non_nullable
                        as String,
            target:
                null == target
                    ? _value.target
                    : target // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FiatRateRequestDtoImplCopyWith<$Res>
    implements $FiatRateRequestDtoCopyWith<$Res> {
  factory _$$FiatRateRequestDtoImplCopyWith(
    _$FiatRateRequestDtoImpl value,
    $Res Function(_$FiatRateRequestDtoImpl) then,
  ) = __$$FiatRateRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String base, String target});
}

/// @nodoc
class __$$FiatRateRequestDtoImplCopyWithImpl<$Res>
    extends _$FiatRateRequestDtoCopyWithImpl<$Res, _$FiatRateRequestDtoImpl>
    implements _$$FiatRateRequestDtoImplCopyWith<$Res> {
  __$$FiatRateRequestDtoImplCopyWithImpl(
    _$FiatRateRequestDtoImpl _value,
    $Res Function(_$FiatRateRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FiatRateRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? base = null, Object? target = null}) {
    return _then(
      _$FiatRateRequestDtoImpl(
        base:
            null == base
                ? _value.base
                : base // ignore: cast_nullable_to_non_nullable
                    as String,
        target:
            null == target
                ? _value.target
                : target // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$FiatRateRequestDtoImpl implements _FiatRateRequestDto {
  const _$FiatRateRequestDtoImpl({required this.base, required this.target});

  @override
  final String base;
  @override
  final String target;

  @override
  String toString() {
    return 'FiatRateRequestDto(base: $base, target: $target)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FiatRateRequestDtoImpl &&
            (identical(other.base, base) || other.base == base) &&
            (identical(other.target, target) || other.target == target));
  }

  @override
  int get hashCode => Object.hash(runtimeType, base, target);

  /// Create a copy of FiatRateRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FiatRateRequestDtoImplCopyWith<_$FiatRateRequestDtoImpl> get copyWith =>
      __$$FiatRateRequestDtoImplCopyWithImpl<_$FiatRateRequestDtoImpl>(this, _$identity);
}

abstract class _FiatRateRequestDto implements FiatRateRequestDto {
  const factory _FiatRateRequestDto({required final String base, required final String target}) =
      _$FiatRateRequestDtoImpl;

  @override
  String get base;
  @override
  String get target;

  /// Create a copy of FiatRateRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FiatRateRequestDtoImplCopyWith<_$FiatRateRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FiatRateResponseDto {
  double get rate => throw _privateConstructorUsedError;

  /// Create a copy of FiatRateResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FiatRateResponseDtoCopyWith<FiatRateResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FiatRateResponseDtoCopyWith<$Res> {
  factory $FiatRateResponseDtoCopyWith(
    FiatRateResponseDto value,
    $Res Function(FiatRateResponseDto) then,
  ) = _$FiatRateResponseDtoCopyWithImpl<$Res, FiatRateResponseDto>;
  @useResult
  $Res call({double rate});
}

/// @nodoc
class _$FiatRateResponseDtoCopyWithImpl<$Res, $Val extends FiatRateResponseDto>
    implements $FiatRateResponseDtoCopyWith<$Res> {
  _$FiatRateResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FiatRateResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? rate = null}) {
    return _then(
      _value.copyWith(
            rate:
                null == rate
                    ? _value.rate
                    : rate // ignore: cast_nullable_to_non_nullable
                        as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FiatRateResponseDtoImplCopyWith<$Res>
    implements $FiatRateResponseDtoCopyWith<$Res> {
  factory _$$FiatRateResponseDtoImplCopyWith(
    _$FiatRateResponseDtoImpl value,
    $Res Function(_$FiatRateResponseDtoImpl) then,
  ) = __$$FiatRateResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double rate});
}

/// @nodoc
class __$$FiatRateResponseDtoImplCopyWithImpl<$Res>
    extends _$FiatRateResponseDtoCopyWithImpl<$Res, _$FiatRateResponseDtoImpl>
    implements _$$FiatRateResponseDtoImplCopyWith<$Res> {
  __$$FiatRateResponseDtoImplCopyWithImpl(
    _$FiatRateResponseDtoImpl _value,
    $Res Function(_$FiatRateResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FiatRateResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? rate = null}) {
    return _then(
      _$FiatRateResponseDtoImpl(
        rate:
            null == rate
                ? _value.rate
                : rate // ignore: cast_nullable_to_non_nullable
                    as double,
      ),
    );
  }
}

/// @nodoc

class _$FiatRateResponseDtoImpl implements _FiatRateResponseDto {
  const _$FiatRateResponseDtoImpl({required this.rate});

  @override
  final double rate;

  @override
  String toString() {
    return 'FiatRateResponseDto(rate: $rate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FiatRateResponseDtoImpl &&
            (identical(other.rate, rate) || other.rate == rate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, rate);

  /// Create a copy of FiatRateResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FiatRateResponseDtoImplCopyWith<_$FiatRateResponseDtoImpl> get copyWith =>
      __$$FiatRateResponseDtoImplCopyWithImpl<_$FiatRateResponseDtoImpl>(this, _$identity);
}

abstract class _FiatRateResponseDto implements FiatRateResponseDto {
  const factory _FiatRateResponseDto({required final double rate}) = _$FiatRateResponseDtoImpl;

  @override
  double get rate;

  /// Create a copy of FiatRateResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FiatRateResponseDtoImplCopyWith<_$FiatRateResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
