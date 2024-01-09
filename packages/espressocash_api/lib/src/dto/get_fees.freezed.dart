// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_fees.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetFeesResponseDto _$GetFeesResponseDtoFromJson(Map<String, dynamic> json) {
  return _GetFeesResponseDto.fromJson(json);
}

/// @nodoc
mixin _$GetFeesResponseDto {
  DirectPaymentFeeDto get directPayment => throw _privateConstructorUsedError;
  int get escrowPayment => throw _privateConstructorUsedError;
  int get escrowPaymentAtaFee => throw _privateConstructorUsedError;
  int get splitKeyPayment => throw _privateConstructorUsedError;
  WithdrawFeeDto get withdrawalFee => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetFeesResponseDtoCopyWith<GetFeesResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetFeesResponseDtoCopyWith<$Res> {
  factory $GetFeesResponseDtoCopyWith(
          GetFeesResponseDto value, $Res Function(GetFeesResponseDto) then) =
      _$GetFeesResponseDtoCopyWithImpl<$Res, GetFeesResponseDto>;
  @useResult
  $Res call(
      {DirectPaymentFeeDto directPayment,
      int escrowPayment,
      int escrowPaymentAtaFee,
      int splitKeyPayment,
      WithdrawFeeDto withdrawalFee});

  $DirectPaymentFeeDtoCopyWith<$Res> get directPayment;
  $WithdrawFeeDtoCopyWith<$Res> get withdrawalFee;
}

/// @nodoc
class _$GetFeesResponseDtoCopyWithImpl<$Res, $Val extends GetFeesResponseDto>
    implements $GetFeesResponseDtoCopyWith<$Res> {
  _$GetFeesResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? directPayment = null,
    Object? escrowPayment = null,
    Object? escrowPaymentAtaFee = null,
    Object? splitKeyPayment = null,
    Object? withdrawalFee = null,
  }) {
    return _then(_value.copyWith(
      directPayment: null == directPayment
          ? _value.directPayment
          : directPayment // ignore: cast_nullable_to_non_nullable
              as DirectPaymentFeeDto,
      escrowPayment: null == escrowPayment
          ? _value.escrowPayment
          : escrowPayment // ignore: cast_nullable_to_non_nullable
              as int,
      escrowPaymentAtaFee: null == escrowPaymentAtaFee
          ? _value.escrowPaymentAtaFee
          : escrowPaymentAtaFee // ignore: cast_nullable_to_non_nullable
              as int,
      splitKeyPayment: null == splitKeyPayment
          ? _value.splitKeyPayment
          : splitKeyPayment // ignore: cast_nullable_to_non_nullable
              as int,
      withdrawalFee: null == withdrawalFee
          ? _value.withdrawalFee
          : withdrawalFee // ignore: cast_nullable_to_non_nullable
              as WithdrawFeeDto,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DirectPaymentFeeDtoCopyWith<$Res> get directPayment {
    return $DirectPaymentFeeDtoCopyWith<$Res>(_value.directPayment, (value) {
      return _then(_value.copyWith(directPayment: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $WithdrawFeeDtoCopyWith<$Res> get withdrawalFee {
    return $WithdrawFeeDtoCopyWith<$Res>(_value.withdrawalFee, (value) {
      return _then(_value.copyWith(withdrawalFee: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetFeesResponseDtoImplCopyWith<$Res>
    implements $GetFeesResponseDtoCopyWith<$Res> {
  factory _$$GetFeesResponseDtoImplCopyWith(_$GetFeesResponseDtoImpl value,
          $Res Function(_$GetFeesResponseDtoImpl) then) =
      __$$GetFeesResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DirectPaymentFeeDto directPayment,
      int escrowPayment,
      int escrowPaymentAtaFee,
      int splitKeyPayment,
      WithdrawFeeDto withdrawalFee});

  @override
  $DirectPaymentFeeDtoCopyWith<$Res> get directPayment;
  @override
  $WithdrawFeeDtoCopyWith<$Res> get withdrawalFee;
}

/// @nodoc
class __$$GetFeesResponseDtoImplCopyWithImpl<$Res>
    extends _$GetFeesResponseDtoCopyWithImpl<$Res, _$GetFeesResponseDtoImpl>
    implements _$$GetFeesResponseDtoImplCopyWith<$Res> {
  __$$GetFeesResponseDtoImplCopyWithImpl(_$GetFeesResponseDtoImpl _value,
      $Res Function(_$GetFeesResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? directPayment = null,
    Object? escrowPayment = null,
    Object? escrowPaymentAtaFee = null,
    Object? splitKeyPayment = null,
    Object? withdrawalFee = null,
  }) {
    return _then(_$GetFeesResponseDtoImpl(
      directPayment: null == directPayment
          ? _value.directPayment
          : directPayment // ignore: cast_nullable_to_non_nullable
              as DirectPaymentFeeDto,
      escrowPayment: null == escrowPayment
          ? _value.escrowPayment
          : escrowPayment // ignore: cast_nullable_to_non_nullable
              as int,
      escrowPaymentAtaFee: null == escrowPaymentAtaFee
          ? _value.escrowPaymentAtaFee
          : escrowPaymentAtaFee // ignore: cast_nullable_to_non_nullable
              as int,
      splitKeyPayment: null == splitKeyPayment
          ? _value.splitKeyPayment
          : splitKeyPayment // ignore: cast_nullable_to_non_nullable
              as int,
      withdrawalFee: null == withdrawalFee
          ? _value.withdrawalFee
          : withdrawalFee // ignore: cast_nullable_to_non_nullable
              as WithdrawFeeDto,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetFeesResponseDtoImpl implements _GetFeesResponseDto {
  const _$GetFeesResponseDtoImpl(
      {required this.directPayment,
      required this.escrowPayment,
      required this.escrowPaymentAtaFee,
      required this.splitKeyPayment,
      required this.withdrawalFee});

  factory _$GetFeesResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetFeesResponseDtoImplFromJson(json);

  @override
  final DirectPaymentFeeDto directPayment;
  @override
  final int escrowPayment;
  @override
  final int escrowPaymentAtaFee;
  @override
  final int splitKeyPayment;
  @override
  final WithdrawFeeDto withdrawalFee;

  @override
  String toString() {
    return 'GetFeesResponseDto(directPayment: $directPayment, escrowPayment: $escrowPayment, escrowPaymentAtaFee: $escrowPaymentAtaFee, splitKeyPayment: $splitKeyPayment, withdrawalFee: $withdrawalFee)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetFeesResponseDtoImpl &&
            (identical(other.directPayment, directPayment) ||
                other.directPayment == directPayment) &&
            (identical(other.escrowPayment, escrowPayment) ||
                other.escrowPayment == escrowPayment) &&
            (identical(other.escrowPaymentAtaFee, escrowPaymentAtaFee) ||
                other.escrowPaymentAtaFee == escrowPaymentAtaFee) &&
            (identical(other.splitKeyPayment, splitKeyPayment) ||
                other.splitKeyPayment == splitKeyPayment) &&
            (identical(other.withdrawalFee, withdrawalFee) ||
                other.withdrawalFee == withdrawalFee));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, directPayment, escrowPayment,
      escrowPaymentAtaFee, splitKeyPayment, withdrawalFee);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetFeesResponseDtoImplCopyWith<_$GetFeesResponseDtoImpl> get copyWith =>
      __$$GetFeesResponseDtoImplCopyWithImpl<_$GetFeesResponseDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetFeesResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _GetFeesResponseDto implements GetFeesResponseDto {
  const factory _GetFeesResponseDto(
      {required final DirectPaymentFeeDto directPayment,
      required final int escrowPayment,
      required final int escrowPaymentAtaFee,
      required final int splitKeyPayment,
      required final WithdrawFeeDto withdrawalFee}) = _$GetFeesResponseDtoImpl;

  factory _GetFeesResponseDto.fromJson(Map<String, dynamic> json) =
      _$GetFeesResponseDtoImpl.fromJson;

  @override
  DirectPaymentFeeDto get directPayment;
  @override
  int get escrowPayment;
  @override
  int get escrowPaymentAtaFee;
  @override
  int get splitKeyPayment;
  @override
  WithdrawFeeDto get withdrawalFee;
  @override
  @JsonKey(ignore: true)
  _$$GetFeesResponseDtoImplCopyWith<_$GetFeesResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DirectPaymentFeeDto _$DirectPaymentFeeDtoFromJson(Map<String, dynamic> json) {
  return _DirectPaymentFeeDto.fromJson(json);
}

/// @nodoc
mixin _$DirectPaymentFeeDto {
  int get ataExists => throw _privateConstructorUsedError;
  int get ataDoesNotExist => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DirectPaymentFeeDtoCopyWith<DirectPaymentFeeDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DirectPaymentFeeDtoCopyWith<$Res> {
  factory $DirectPaymentFeeDtoCopyWith(
          DirectPaymentFeeDto value, $Res Function(DirectPaymentFeeDto) then) =
      _$DirectPaymentFeeDtoCopyWithImpl<$Res, DirectPaymentFeeDto>;
  @useResult
  $Res call({int ataExists, int ataDoesNotExist});
}

/// @nodoc
class _$DirectPaymentFeeDtoCopyWithImpl<$Res, $Val extends DirectPaymentFeeDto>
    implements $DirectPaymentFeeDtoCopyWith<$Res> {
  _$DirectPaymentFeeDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ataExists = null,
    Object? ataDoesNotExist = null,
  }) {
    return _then(_value.copyWith(
      ataExists: null == ataExists
          ? _value.ataExists
          : ataExists // ignore: cast_nullable_to_non_nullable
              as int,
      ataDoesNotExist: null == ataDoesNotExist
          ? _value.ataDoesNotExist
          : ataDoesNotExist // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DirectPaymentFeeDtoImplCopyWith<$Res>
    implements $DirectPaymentFeeDtoCopyWith<$Res> {
  factory _$$DirectPaymentFeeDtoImplCopyWith(_$DirectPaymentFeeDtoImpl value,
          $Res Function(_$DirectPaymentFeeDtoImpl) then) =
      __$$DirectPaymentFeeDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int ataExists, int ataDoesNotExist});
}

/// @nodoc
class __$$DirectPaymentFeeDtoImplCopyWithImpl<$Res>
    extends _$DirectPaymentFeeDtoCopyWithImpl<$Res, _$DirectPaymentFeeDtoImpl>
    implements _$$DirectPaymentFeeDtoImplCopyWith<$Res> {
  __$$DirectPaymentFeeDtoImplCopyWithImpl(_$DirectPaymentFeeDtoImpl _value,
      $Res Function(_$DirectPaymentFeeDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ataExists = null,
    Object? ataDoesNotExist = null,
  }) {
    return _then(_$DirectPaymentFeeDtoImpl(
      ataExists: null == ataExists
          ? _value.ataExists
          : ataExists // ignore: cast_nullable_to_non_nullable
              as int,
      ataDoesNotExist: null == ataDoesNotExist
          ? _value.ataDoesNotExist
          : ataDoesNotExist // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DirectPaymentFeeDtoImpl implements _DirectPaymentFeeDto {
  const _$DirectPaymentFeeDtoImpl(
      {required this.ataExists, required this.ataDoesNotExist});

  factory _$DirectPaymentFeeDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DirectPaymentFeeDtoImplFromJson(json);

  @override
  final int ataExists;
  @override
  final int ataDoesNotExist;

  @override
  String toString() {
    return 'DirectPaymentFeeDto(ataExists: $ataExists, ataDoesNotExist: $ataDoesNotExist)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DirectPaymentFeeDtoImpl &&
            (identical(other.ataExists, ataExists) ||
                other.ataExists == ataExists) &&
            (identical(other.ataDoesNotExist, ataDoesNotExist) ||
                other.ataDoesNotExist == ataDoesNotExist));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, ataExists, ataDoesNotExist);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DirectPaymentFeeDtoImplCopyWith<_$DirectPaymentFeeDtoImpl> get copyWith =>
      __$$DirectPaymentFeeDtoImplCopyWithImpl<_$DirectPaymentFeeDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DirectPaymentFeeDtoImplToJson(
      this,
    );
  }
}

abstract class _DirectPaymentFeeDto implements DirectPaymentFeeDto {
  const factory _DirectPaymentFeeDto(
      {required final int ataExists,
      required final int ataDoesNotExist}) = _$DirectPaymentFeeDtoImpl;

  factory _DirectPaymentFeeDto.fromJson(Map<String, dynamic> json) =
      _$DirectPaymentFeeDtoImpl.fromJson;

  @override
  int get ataExists;
  @override
  int get ataDoesNotExist;
  @override
  @JsonKey(ignore: true)
  _$$DirectPaymentFeeDtoImplCopyWith<_$DirectPaymentFeeDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WithdrawFeeDto _$WithdrawFeeDtoFromJson(Map<String, dynamic> json) {
  return _WithdrawFeeDto.fromJson(json);
}

/// @nodoc
mixin _$WithdrawFeeDto {
  int get scalexFee => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WithdrawFeeDtoCopyWith<WithdrawFeeDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WithdrawFeeDtoCopyWith<$Res> {
  factory $WithdrawFeeDtoCopyWith(
          WithdrawFeeDto value, $Res Function(WithdrawFeeDto) then) =
      _$WithdrawFeeDtoCopyWithImpl<$Res, WithdrawFeeDto>;
  @useResult
  $Res call({int scalexFee});
}

/// @nodoc
class _$WithdrawFeeDtoCopyWithImpl<$Res, $Val extends WithdrawFeeDto>
    implements $WithdrawFeeDtoCopyWith<$Res> {
  _$WithdrawFeeDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scalexFee = null,
  }) {
    return _then(_value.copyWith(
      scalexFee: null == scalexFee
          ? _value.scalexFee
          : scalexFee // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WithdrawFeeDtoImplCopyWith<$Res>
    implements $WithdrawFeeDtoCopyWith<$Res> {
  factory _$$WithdrawFeeDtoImplCopyWith(_$WithdrawFeeDtoImpl value,
          $Res Function(_$WithdrawFeeDtoImpl) then) =
      __$$WithdrawFeeDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int scalexFee});
}

/// @nodoc
class __$$WithdrawFeeDtoImplCopyWithImpl<$Res>
    extends _$WithdrawFeeDtoCopyWithImpl<$Res, _$WithdrawFeeDtoImpl>
    implements _$$WithdrawFeeDtoImplCopyWith<$Res> {
  __$$WithdrawFeeDtoImplCopyWithImpl(
      _$WithdrawFeeDtoImpl _value, $Res Function(_$WithdrawFeeDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scalexFee = null,
  }) {
    return _then(_$WithdrawFeeDtoImpl(
      scalexFee: null == scalexFee
          ? _value.scalexFee
          : scalexFee // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WithdrawFeeDtoImpl implements _WithdrawFeeDto {
  const _$WithdrawFeeDtoImpl({required this.scalexFee});

  factory _$WithdrawFeeDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$WithdrawFeeDtoImplFromJson(json);

  @override
  final int scalexFee;

  @override
  String toString() {
    return 'WithdrawFeeDto(scalexFee: $scalexFee)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WithdrawFeeDtoImpl &&
            (identical(other.scalexFee, scalexFee) ||
                other.scalexFee == scalexFee));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, scalexFee);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WithdrawFeeDtoImplCopyWith<_$WithdrawFeeDtoImpl> get copyWith =>
      __$$WithdrawFeeDtoImplCopyWithImpl<_$WithdrawFeeDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WithdrawFeeDtoImplToJson(
      this,
    );
  }
}

abstract class _WithdrawFeeDto implements WithdrawFeeDto {
  const factory _WithdrawFeeDto({required final int scalexFee}) =
      _$WithdrawFeeDtoImpl;

  factory _WithdrawFeeDto.fromJson(Map<String, dynamic> json) =
      _$WithdrawFeeDtoImpl.fromJson;

  @override
  int get scalexFee;
  @override
  @JsonKey(ignore: true)
  _$$WithdrawFeeDtoImplCopyWith<_$WithdrawFeeDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
