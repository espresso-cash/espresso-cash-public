// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ambassador.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AmbassadorReferralRequestDto _$AmbassadorReferralRequestDtoFromJson(
    Map<String, dynamic> json) {
  return _AmbassadorReferralRequestDto.fromJson(json);
}

/// @nodoc
mixin _$AmbassadorReferralRequestDto {
  String get ambassadorAddress => throw _privateConstructorUsedError;

  /// Serializes this AmbassadorReferralRequestDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AmbassadorReferralRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AmbassadorReferralRequestDtoCopyWith<AmbassadorReferralRequestDto>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AmbassadorReferralRequestDtoCopyWith<$Res> {
  factory $AmbassadorReferralRequestDtoCopyWith(
          AmbassadorReferralRequestDto value,
          $Res Function(AmbassadorReferralRequestDto) then) =
      _$AmbassadorReferralRequestDtoCopyWithImpl<$Res,
          AmbassadorReferralRequestDto>;
  @useResult
  $Res call({String ambassadorAddress});
}

/// @nodoc
class _$AmbassadorReferralRequestDtoCopyWithImpl<$Res,
        $Val extends AmbassadorReferralRequestDto>
    implements $AmbassadorReferralRequestDtoCopyWith<$Res> {
  _$AmbassadorReferralRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AmbassadorReferralRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ambassadorAddress = null,
  }) {
    return _then(_value.copyWith(
      ambassadorAddress: null == ambassadorAddress
          ? _value.ambassadorAddress
          : ambassadorAddress // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AmbassadorReferralRequestDtoImplCopyWith<$Res>
    implements $AmbassadorReferralRequestDtoCopyWith<$Res> {
  factory _$$AmbassadorReferralRequestDtoImplCopyWith(
          _$AmbassadorReferralRequestDtoImpl value,
          $Res Function(_$AmbassadorReferralRequestDtoImpl) then) =
      __$$AmbassadorReferralRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String ambassadorAddress});
}

/// @nodoc
class __$$AmbassadorReferralRequestDtoImplCopyWithImpl<$Res>
    extends _$AmbassadorReferralRequestDtoCopyWithImpl<$Res,
        _$AmbassadorReferralRequestDtoImpl>
    implements _$$AmbassadorReferralRequestDtoImplCopyWith<$Res> {
  __$$AmbassadorReferralRequestDtoImplCopyWithImpl(
      _$AmbassadorReferralRequestDtoImpl _value,
      $Res Function(_$AmbassadorReferralRequestDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of AmbassadorReferralRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ambassadorAddress = null,
  }) {
    return _then(_$AmbassadorReferralRequestDtoImpl(
      ambassadorAddress: null == ambassadorAddress
          ? _value.ambassadorAddress
          : ambassadorAddress // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AmbassadorReferralRequestDtoImpl
    implements _AmbassadorReferralRequestDto {
  const _$AmbassadorReferralRequestDtoImpl({required this.ambassadorAddress});

  factory _$AmbassadorReferralRequestDtoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AmbassadorReferralRequestDtoImplFromJson(json);

  @override
  final String ambassadorAddress;

  @override
  String toString() {
    return 'AmbassadorReferralRequestDto(ambassadorAddress: $ambassadorAddress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AmbassadorReferralRequestDtoImpl &&
            (identical(other.ambassadorAddress, ambassadorAddress) ||
                other.ambassadorAddress == ambassadorAddress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, ambassadorAddress);

  /// Create a copy of AmbassadorReferralRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AmbassadorReferralRequestDtoImplCopyWith<
          _$AmbassadorReferralRequestDtoImpl>
      get copyWith => __$$AmbassadorReferralRequestDtoImplCopyWithImpl<
          _$AmbassadorReferralRequestDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AmbassadorReferralRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _AmbassadorReferralRequestDto
    implements AmbassadorReferralRequestDto {
  const factory _AmbassadorReferralRequestDto(
          {required final String ambassadorAddress}) =
      _$AmbassadorReferralRequestDtoImpl;

  factory _AmbassadorReferralRequestDto.fromJson(Map<String, dynamic> json) =
      _$AmbassadorReferralRequestDtoImpl.fromJson;

  @override
  String get ambassadorAddress;

  /// Create a copy of AmbassadorReferralRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AmbassadorReferralRequestDtoImplCopyWith<
          _$AmbassadorReferralRequestDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AmbassadorStatsResponseDto _$AmbassadorStatsResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _AmbassadorStatsResponseDto.fromJson(json);
}

/// @nodoc
mixin _$AmbassadorStatsResponseDto {
  int get referralCount => throw _privateConstructorUsedError;

  /// Serializes this AmbassadorStatsResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AmbassadorStatsResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AmbassadorStatsResponseDtoCopyWith<AmbassadorStatsResponseDto>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AmbassadorStatsResponseDtoCopyWith<$Res> {
  factory $AmbassadorStatsResponseDtoCopyWith(AmbassadorStatsResponseDto value,
          $Res Function(AmbassadorStatsResponseDto) then) =
      _$AmbassadorStatsResponseDtoCopyWithImpl<$Res,
          AmbassadorStatsResponseDto>;
  @useResult
  $Res call({int referralCount});
}

/// @nodoc
class _$AmbassadorStatsResponseDtoCopyWithImpl<$Res,
        $Val extends AmbassadorStatsResponseDto>
    implements $AmbassadorStatsResponseDtoCopyWith<$Res> {
  _$AmbassadorStatsResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AmbassadorStatsResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? referralCount = null,
  }) {
    return _then(_value.copyWith(
      referralCount: null == referralCount
          ? _value.referralCount
          : referralCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AmbassadorStatsResponseDtoImplCopyWith<$Res>
    implements $AmbassadorStatsResponseDtoCopyWith<$Res> {
  factory _$$AmbassadorStatsResponseDtoImplCopyWith(
          _$AmbassadorStatsResponseDtoImpl value,
          $Res Function(_$AmbassadorStatsResponseDtoImpl) then) =
      __$$AmbassadorStatsResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int referralCount});
}

/// @nodoc
class __$$AmbassadorStatsResponseDtoImplCopyWithImpl<$Res>
    extends _$AmbassadorStatsResponseDtoCopyWithImpl<$Res,
        _$AmbassadorStatsResponseDtoImpl>
    implements _$$AmbassadorStatsResponseDtoImplCopyWith<$Res> {
  __$$AmbassadorStatsResponseDtoImplCopyWithImpl(
      _$AmbassadorStatsResponseDtoImpl _value,
      $Res Function(_$AmbassadorStatsResponseDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of AmbassadorStatsResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? referralCount = null,
  }) {
    return _then(_$AmbassadorStatsResponseDtoImpl(
      referralCount: null == referralCount
          ? _value.referralCount
          : referralCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AmbassadorStatsResponseDtoImpl implements _AmbassadorStatsResponseDto {
  const _$AmbassadorStatsResponseDtoImpl({required this.referralCount});

  factory _$AmbassadorStatsResponseDtoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AmbassadorStatsResponseDtoImplFromJson(json);

  @override
  final int referralCount;

  @override
  String toString() {
    return 'AmbassadorStatsResponseDto(referralCount: $referralCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AmbassadorStatsResponseDtoImpl &&
            (identical(other.referralCount, referralCount) ||
                other.referralCount == referralCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, referralCount);

  /// Create a copy of AmbassadorStatsResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AmbassadorStatsResponseDtoImplCopyWith<_$AmbassadorStatsResponseDtoImpl>
      get copyWith => __$$AmbassadorStatsResponseDtoImplCopyWithImpl<
          _$AmbassadorStatsResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AmbassadorStatsResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _AmbassadorStatsResponseDto
    implements AmbassadorStatsResponseDto {
  const factory _AmbassadorStatsResponseDto(
      {required final int referralCount}) = _$AmbassadorStatsResponseDtoImpl;

  factory _AmbassadorStatsResponseDto.fromJson(Map<String, dynamic> json) =
      _$AmbassadorStatsResponseDtoImpl.fromJson;

  @override
  int get referralCount;

  /// Create a copy of AmbassadorStatsResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AmbassadorStatsResponseDtoImplCopyWith<_$AmbassadorStatsResponseDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AmbassadorVerificationRequestDto _$AmbassadorVerificationRequestDtoFromJson(
    Map<String, dynamic> json) {
  return _AmbassadorVerificationRequestDto.fromJson(json);
}

/// @nodoc
mixin _$AmbassadorVerificationRequestDto {
  String get address => throw _privateConstructorUsedError;

  /// Serializes this AmbassadorVerificationRequestDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AmbassadorVerificationRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AmbassadorVerificationRequestDtoCopyWith<AmbassadorVerificationRequestDto>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AmbassadorVerificationRequestDtoCopyWith<$Res> {
  factory $AmbassadorVerificationRequestDtoCopyWith(
          AmbassadorVerificationRequestDto value,
          $Res Function(AmbassadorVerificationRequestDto) then) =
      _$AmbassadorVerificationRequestDtoCopyWithImpl<$Res,
          AmbassadorVerificationRequestDto>;
  @useResult
  $Res call({String address});
}

/// @nodoc
class _$AmbassadorVerificationRequestDtoCopyWithImpl<$Res,
        $Val extends AmbassadorVerificationRequestDto>
    implements $AmbassadorVerificationRequestDtoCopyWith<$Res> {
  _$AmbassadorVerificationRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AmbassadorVerificationRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AmbassadorVerificationRequestDtoImplCopyWith<$Res>
    implements $AmbassadorVerificationRequestDtoCopyWith<$Res> {
  factory _$$AmbassadorVerificationRequestDtoImplCopyWith(
          _$AmbassadorVerificationRequestDtoImpl value,
          $Res Function(_$AmbassadorVerificationRequestDtoImpl) then) =
      __$$AmbassadorVerificationRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String address});
}

/// @nodoc
class __$$AmbassadorVerificationRequestDtoImplCopyWithImpl<$Res>
    extends _$AmbassadorVerificationRequestDtoCopyWithImpl<$Res,
        _$AmbassadorVerificationRequestDtoImpl>
    implements _$$AmbassadorVerificationRequestDtoImplCopyWith<$Res> {
  __$$AmbassadorVerificationRequestDtoImplCopyWithImpl(
      _$AmbassadorVerificationRequestDtoImpl _value,
      $Res Function(_$AmbassadorVerificationRequestDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of AmbassadorVerificationRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
  }) {
    return _then(_$AmbassadorVerificationRequestDtoImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AmbassadorVerificationRequestDtoImpl
    implements _AmbassadorVerificationRequestDto {
  const _$AmbassadorVerificationRequestDtoImpl({required this.address});

  factory _$AmbassadorVerificationRequestDtoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AmbassadorVerificationRequestDtoImplFromJson(json);

  @override
  final String address;

  @override
  String toString() {
    return 'AmbassadorVerificationRequestDto(address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AmbassadorVerificationRequestDtoImpl &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, address);

  /// Create a copy of AmbassadorVerificationRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AmbassadorVerificationRequestDtoImplCopyWith<
          _$AmbassadorVerificationRequestDtoImpl>
      get copyWith => __$$AmbassadorVerificationRequestDtoImplCopyWithImpl<
          _$AmbassadorVerificationRequestDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AmbassadorVerificationRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _AmbassadorVerificationRequestDto
    implements AmbassadorVerificationRequestDto {
  const factory _AmbassadorVerificationRequestDto(
      {required final String address}) = _$AmbassadorVerificationRequestDtoImpl;

  factory _AmbassadorVerificationRequestDto.fromJson(
          Map<String, dynamic> json) =
      _$AmbassadorVerificationRequestDtoImpl.fromJson;

  @override
  String get address;

  /// Create a copy of AmbassadorVerificationRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AmbassadorVerificationRequestDtoImplCopyWith<
          _$AmbassadorVerificationRequestDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AmbassadorVerificationResponseDto _$AmbassadorVerificationResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _AmbassadorVerificationResponseDto.fromJson(json);
}

/// @nodoc
mixin _$AmbassadorVerificationResponseDto {
  bool get isAmbassador => throw _privateConstructorUsedError;

  /// Serializes this AmbassadorVerificationResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AmbassadorVerificationResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AmbassadorVerificationResponseDtoCopyWith<AmbassadorVerificationResponseDto>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AmbassadorVerificationResponseDtoCopyWith<$Res> {
  factory $AmbassadorVerificationResponseDtoCopyWith(
          AmbassadorVerificationResponseDto value,
          $Res Function(AmbassadorVerificationResponseDto) then) =
      _$AmbassadorVerificationResponseDtoCopyWithImpl<$Res,
          AmbassadorVerificationResponseDto>;
  @useResult
  $Res call({bool isAmbassador});
}

/// @nodoc
class _$AmbassadorVerificationResponseDtoCopyWithImpl<$Res,
        $Val extends AmbassadorVerificationResponseDto>
    implements $AmbassadorVerificationResponseDtoCopyWith<$Res> {
  _$AmbassadorVerificationResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AmbassadorVerificationResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAmbassador = null,
  }) {
    return _then(_value.copyWith(
      isAmbassador: null == isAmbassador
          ? _value.isAmbassador
          : isAmbassador // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AmbassadorVerificationResponseDtoImplCopyWith<$Res>
    implements $AmbassadorVerificationResponseDtoCopyWith<$Res> {
  factory _$$AmbassadorVerificationResponseDtoImplCopyWith(
          _$AmbassadorVerificationResponseDtoImpl value,
          $Res Function(_$AmbassadorVerificationResponseDtoImpl) then) =
      __$$AmbassadorVerificationResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isAmbassador});
}

/// @nodoc
class __$$AmbassadorVerificationResponseDtoImplCopyWithImpl<$Res>
    extends _$AmbassadorVerificationResponseDtoCopyWithImpl<$Res,
        _$AmbassadorVerificationResponseDtoImpl>
    implements _$$AmbassadorVerificationResponseDtoImplCopyWith<$Res> {
  __$$AmbassadorVerificationResponseDtoImplCopyWithImpl(
      _$AmbassadorVerificationResponseDtoImpl _value,
      $Res Function(_$AmbassadorVerificationResponseDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of AmbassadorVerificationResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAmbassador = null,
  }) {
    return _then(_$AmbassadorVerificationResponseDtoImpl(
      isAmbassador: null == isAmbassador
          ? _value.isAmbassador
          : isAmbassador // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AmbassadorVerificationResponseDtoImpl
    implements _AmbassadorVerificationResponseDto {
  const _$AmbassadorVerificationResponseDtoImpl({required this.isAmbassador});

  factory _$AmbassadorVerificationResponseDtoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AmbassadorVerificationResponseDtoImplFromJson(json);

  @override
  final bool isAmbassador;

  @override
  String toString() {
    return 'AmbassadorVerificationResponseDto(isAmbassador: $isAmbassador)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AmbassadorVerificationResponseDtoImpl &&
            (identical(other.isAmbassador, isAmbassador) ||
                other.isAmbassador == isAmbassador));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isAmbassador);

  /// Create a copy of AmbassadorVerificationResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AmbassadorVerificationResponseDtoImplCopyWith<
          _$AmbassadorVerificationResponseDtoImpl>
      get copyWith => __$$AmbassadorVerificationResponseDtoImplCopyWithImpl<
          _$AmbassadorVerificationResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AmbassadorVerificationResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _AmbassadorVerificationResponseDto
    implements AmbassadorVerificationResponseDto {
  const factory _AmbassadorVerificationResponseDto(
          {required final bool isAmbassador}) =
      _$AmbassadorVerificationResponseDtoImpl;

  factory _AmbassadorVerificationResponseDto.fromJson(
          Map<String, dynamic> json) =
      _$AmbassadorVerificationResponseDtoImpl.fromJson;

  @override
  bool get isAmbassador;

  /// Create a copy of AmbassadorVerificationResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AmbassadorVerificationResponseDtoImplCopyWith<
          _$AmbassadorVerificationResponseDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
