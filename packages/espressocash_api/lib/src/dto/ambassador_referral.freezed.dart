// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ambassador_referral.dart';

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
  String get userAddress => throw _privateConstructorUsedError;

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
  $Res call({String ambassadorAddress, String userAddress});
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
    Object? userAddress = null,
  }) {
    return _then(_value.copyWith(
      ambassadorAddress: null == ambassadorAddress
          ? _value.ambassadorAddress
          : ambassadorAddress // ignore: cast_nullable_to_non_nullable
              as String,
      userAddress: null == userAddress
          ? _value.userAddress
          : userAddress // ignore: cast_nullable_to_non_nullable
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
  $Res call({String ambassadorAddress, String userAddress});
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
    Object? userAddress = null,
  }) {
    return _then(_$AmbassadorReferralRequestDtoImpl(
      ambassadorAddress: null == ambassadorAddress
          ? _value.ambassadorAddress
          : ambassadorAddress // ignore: cast_nullable_to_non_nullable
              as String,
      userAddress: null == userAddress
          ? _value.userAddress
          : userAddress // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AmbassadorReferralRequestDtoImpl
    implements _AmbassadorReferralRequestDto {
  const _$AmbassadorReferralRequestDtoImpl(
      {required this.ambassadorAddress, required this.userAddress});

  factory _$AmbassadorReferralRequestDtoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AmbassadorReferralRequestDtoImplFromJson(json);

  @override
  final String ambassadorAddress;
  @override
  final String userAddress;

  @override
  String toString() {
    return 'AmbassadorReferralRequestDto(ambassadorAddress: $ambassadorAddress, userAddress: $userAddress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AmbassadorReferralRequestDtoImpl &&
            (identical(other.ambassadorAddress, ambassadorAddress) ||
                other.ambassadorAddress == ambassadorAddress) &&
            (identical(other.userAddress, userAddress) ||
                other.userAddress == userAddress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, ambassadorAddress, userAddress);

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
      {required final String ambassadorAddress,
      required final String userAddress}) = _$AmbassadorReferralRequestDtoImpl;

  factory _AmbassadorReferralRequestDto.fromJson(Map<String, dynamic> json) =
      _$AmbassadorReferralRequestDtoImpl.fromJson;

  @override
  String get ambassadorAddress;
  @override
  String get userAddress;

  /// Create a copy of AmbassadorReferralRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AmbassadorReferralRequestDtoImplCopyWith<
          _$AmbassadorReferralRequestDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
