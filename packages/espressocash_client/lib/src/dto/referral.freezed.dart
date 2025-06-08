// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'referral.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AmbassadorReferralRequestDto {
  String get ambassadorAddress;

  /// Create a copy of AmbassadorReferralRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AmbassadorReferralRequestDtoCopyWith<AmbassadorReferralRequestDto> get copyWith =>
      _$AmbassadorReferralRequestDtoCopyWithImpl<AmbassadorReferralRequestDto>(
        this as AmbassadorReferralRequestDto,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AmbassadorReferralRequestDto &&
            (identical(other.ambassadorAddress, ambassadorAddress) ||
                other.ambassadorAddress == ambassadorAddress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ambassadorAddress);

  @override
  String toString() {
    return 'AmbassadorReferralRequestDto(ambassadorAddress: $ambassadorAddress)';
  }
}

/// @nodoc
abstract mixin class $AmbassadorReferralRequestDtoCopyWith<$Res> {
  factory $AmbassadorReferralRequestDtoCopyWith(
    AmbassadorReferralRequestDto value,
    $Res Function(AmbassadorReferralRequestDto) _then,
  ) = _$AmbassadorReferralRequestDtoCopyWithImpl;
  @useResult
  $Res call({String ambassadorAddress});
}

/// @nodoc
class _$AmbassadorReferralRequestDtoCopyWithImpl<$Res>
    implements $AmbassadorReferralRequestDtoCopyWith<$Res> {
  _$AmbassadorReferralRequestDtoCopyWithImpl(this._self, this._then);

  final AmbassadorReferralRequestDto _self;
  final $Res Function(AmbassadorReferralRequestDto) _then;

  /// Create a copy of AmbassadorReferralRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? ambassadorAddress = null}) {
    return _then(
      _self.copyWith(
        ambassadorAddress:
            null == ambassadorAddress
                ? _self.ambassadorAddress
                : ambassadorAddress // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _AmbassadorReferralRequestDto implements AmbassadorReferralRequestDto {
  const _AmbassadorReferralRequestDto({required this.ambassadorAddress});

  @override
  final String ambassadorAddress;

  /// Create a copy of AmbassadorReferralRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AmbassadorReferralRequestDtoCopyWith<_AmbassadorReferralRequestDto> get copyWith =>
      __$AmbassadorReferralRequestDtoCopyWithImpl<_AmbassadorReferralRequestDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AmbassadorReferralRequestDto &&
            (identical(other.ambassadorAddress, ambassadorAddress) ||
                other.ambassadorAddress == ambassadorAddress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ambassadorAddress);

  @override
  String toString() {
    return 'AmbassadorReferralRequestDto(ambassadorAddress: $ambassadorAddress)';
  }
}

/// @nodoc
abstract mixin class _$AmbassadorReferralRequestDtoCopyWith<$Res>
    implements $AmbassadorReferralRequestDtoCopyWith<$Res> {
  factory _$AmbassadorReferralRequestDtoCopyWith(
    _AmbassadorReferralRequestDto value,
    $Res Function(_AmbassadorReferralRequestDto) _then,
  ) = __$AmbassadorReferralRequestDtoCopyWithImpl;
  @override
  @useResult
  $Res call({String ambassadorAddress});
}

/// @nodoc
class __$AmbassadorReferralRequestDtoCopyWithImpl<$Res>
    implements _$AmbassadorReferralRequestDtoCopyWith<$Res> {
  __$AmbassadorReferralRequestDtoCopyWithImpl(this._self, this._then);

  final _AmbassadorReferralRequestDto _self;
  final $Res Function(_AmbassadorReferralRequestDto) _then;

  /// Create a copy of AmbassadorReferralRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? ambassadorAddress = null}) {
    return _then(
      _AmbassadorReferralRequestDto(
        ambassadorAddress:
            null == ambassadorAddress
                ? _self.ambassadorAddress
                : ambassadorAddress // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
mixin _$AmbassadorStatsResponseDto {
  int get referralCount;

  /// Create a copy of AmbassadorStatsResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AmbassadorStatsResponseDtoCopyWith<AmbassadorStatsResponseDto> get copyWith =>
      _$AmbassadorStatsResponseDtoCopyWithImpl<AmbassadorStatsResponseDto>(
        this as AmbassadorStatsResponseDto,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AmbassadorStatsResponseDto &&
            (identical(other.referralCount, referralCount) ||
                other.referralCount == referralCount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, referralCount);

  @override
  String toString() {
    return 'AmbassadorStatsResponseDto(referralCount: $referralCount)';
  }
}

/// @nodoc
abstract mixin class $AmbassadorStatsResponseDtoCopyWith<$Res> {
  factory $AmbassadorStatsResponseDtoCopyWith(
    AmbassadorStatsResponseDto value,
    $Res Function(AmbassadorStatsResponseDto) _then,
  ) = _$AmbassadorStatsResponseDtoCopyWithImpl;
  @useResult
  $Res call({int referralCount});
}

/// @nodoc
class _$AmbassadorStatsResponseDtoCopyWithImpl<$Res>
    implements $AmbassadorStatsResponseDtoCopyWith<$Res> {
  _$AmbassadorStatsResponseDtoCopyWithImpl(this._self, this._then);

  final AmbassadorStatsResponseDto _self;
  final $Res Function(AmbassadorStatsResponseDto) _then;

  /// Create a copy of AmbassadorStatsResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? referralCount = null}) {
    return _then(
      _self.copyWith(
        referralCount:
            null == referralCount
                ? _self.referralCount
                : referralCount // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _AmbassadorStatsResponseDto implements AmbassadorStatsResponseDto {
  const _AmbassadorStatsResponseDto({required this.referralCount});

  @override
  final int referralCount;

  /// Create a copy of AmbassadorStatsResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AmbassadorStatsResponseDtoCopyWith<_AmbassadorStatsResponseDto> get copyWith =>
      __$AmbassadorStatsResponseDtoCopyWithImpl<_AmbassadorStatsResponseDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AmbassadorStatsResponseDto &&
            (identical(other.referralCount, referralCount) ||
                other.referralCount == referralCount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, referralCount);

  @override
  String toString() {
    return 'AmbassadorStatsResponseDto(referralCount: $referralCount)';
  }
}

/// @nodoc
abstract mixin class _$AmbassadorStatsResponseDtoCopyWith<$Res>
    implements $AmbassadorStatsResponseDtoCopyWith<$Res> {
  factory _$AmbassadorStatsResponseDtoCopyWith(
    _AmbassadorStatsResponseDto value,
    $Res Function(_AmbassadorStatsResponseDto) _then,
  ) = __$AmbassadorStatsResponseDtoCopyWithImpl;
  @override
  @useResult
  $Res call({int referralCount});
}

/// @nodoc
class __$AmbassadorStatsResponseDtoCopyWithImpl<$Res>
    implements _$AmbassadorStatsResponseDtoCopyWith<$Res> {
  __$AmbassadorStatsResponseDtoCopyWithImpl(this._self, this._then);

  final _AmbassadorStatsResponseDto _self;
  final $Res Function(_AmbassadorStatsResponseDto) _then;

  /// Create a copy of AmbassadorStatsResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? referralCount = null}) {
    return _then(
      _AmbassadorStatsResponseDto(
        referralCount:
            null == referralCount
                ? _self.referralCount
                : referralCount // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
mixin _$AmbassadorVerificationResponseDto {
  bool get isAmbassador;
  bool get isReferral;

  /// Create a copy of AmbassadorVerificationResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AmbassadorVerificationResponseDtoCopyWith<AmbassadorVerificationResponseDto> get copyWith =>
      _$AmbassadorVerificationResponseDtoCopyWithImpl<AmbassadorVerificationResponseDto>(
        this as AmbassadorVerificationResponseDto,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AmbassadorVerificationResponseDto &&
            (identical(other.isAmbassador, isAmbassador) || other.isAmbassador == isAmbassador) &&
            (identical(other.isReferral, isReferral) || other.isReferral == isReferral));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isAmbassador, isReferral);

  @override
  String toString() {
    return 'AmbassadorVerificationResponseDto(isAmbassador: $isAmbassador, isReferral: $isReferral)';
  }
}

/// @nodoc
abstract mixin class $AmbassadorVerificationResponseDtoCopyWith<$Res> {
  factory $AmbassadorVerificationResponseDtoCopyWith(
    AmbassadorVerificationResponseDto value,
    $Res Function(AmbassadorVerificationResponseDto) _then,
  ) = _$AmbassadorVerificationResponseDtoCopyWithImpl;
  @useResult
  $Res call({bool isAmbassador, bool isReferral});
}

/// @nodoc
class _$AmbassadorVerificationResponseDtoCopyWithImpl<$Res>
    implements $AmbassadorVerificationResponseDtoCopyWith<$Res> {
  _$AmbassadorVerificationResponseDtoCopyWithImpl(this._self, this._then);

  final AmbassadorVerificationResponseDto _self;
  final $Res Function(AmbassadorVerificationResponseDto) _then;

  /// Create a copy of AmbassadorVerificationResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? isAmbassador = null, Object? isReferral = null}) {
    return _then(
      _self.copyWith(
        isAmbassador:
            null == isAmbassador
                ? _self.isAmbassador
                : isAmbassador // ignore: cast_nullable_to_non_nullable
                    as bool,
        isReferral:
            null == isReferral
                ? _self.isReferral
                : isReferral // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _AmbassadorVerificationResponseDto implements AmbassadorVerificationResponseDto {
  const _AmbassadorVerificationResponseDto({required this.isAmbassador, required this.isReferral});

  @override
  final bool isAmbassador;
  @override
  final bool isReferral;

  /// Create a copy of AmbassadorVerificationResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AmbassadorVerificationResponseDtoCopyWith<_AmbassadorVerificationResponseDto> get copyWith =>
      __$AmbassadorVerificationResponseDtoCopyWithImpl<_AmbassadorVerificationResponseDto>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AmbassadorVerificationResponseDto &&
            (identical(other.isAmbassador, isAmbassador) || other.isAmbassador == isAmbassador) &&
            (identical(other.isReferral, isReferral) || other.isReferral == isReferral));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isAmbassador, isReferral);

  @override
  String toString() {
    return 'AmbassadorVerificationResponseDto(isAmbassador: $isAmbassador, isReferral: $isReferral)';
  }
}

/// @nodoc
abstract mixin class _$AmbassadorVerificationResponseDtoCopyWith<$Res>
    implements $AmbassadorVerificationResponseDtoCopyWith<$Res> {
  factory _$AmbassadorVerificationResponseDtoCopyWith(
    _AmbassadorVerificationResponseDto value,
    $Res Function(_AmbassadorVerificationResponseDto) _then,
  ) = __$AmbassadorVerificationResponseDtoCopyWithImpl;
  @override
  @useResult
  $Res call({bool isAmbassador, bool isReferral});
}

/// @nodoc
class __$AmbassadorVerificationResponseDtoCopyWithImpl<$Res>
    implements _$AmbassadorVerificationResponseDtoCopyWith<$Res> {
  __$AmbassadorVerificationResponseDtoCopyWithImpl(this._self, this._then);

  final _AmbassadorVerificationResponseDto _self;
  final $Res Function(_AmbassadorVerificationResponseDto) _then;

  /// Create a copy of AmbassadorVerificationResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? isAmbassador = null, Object? isReferral = null}) {
    return _then(
      _AmbassadorVerificationResponseDto(
        isAmbassador:
            null == isAmbassador
                ? _self.isAmbassador
                : isAmbassador // ignore: cast_nullable_to_non_nullable
                    as bool,
        isReferral:
            null == isReferral
                ? _self.isReferral
                : isReferral // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}
