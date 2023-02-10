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
  int get splitKeyPayment => throw _privateConstructorUsedError;

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
  $Res call({DirectPaymentFeeDto directPayment, int splitKeyPayment});

  $DirectPaymentFeeDtoCopyWith<$Res> get directPayment;
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
    Object? splitKeyPayment = null,
  }) {
    return _then(_value.copyWith(
      directPayment: null == directPayment
          ? _value.directPayment
          : directPayment // ignore: cast_nullable_to_non_nullable
              as DirectPaymentFeeDto,
      splitKeyPayment: null == splitKeyPayment
          ? _value.splitKeyPayment
          : splitKeyPayment // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DirectPaymentFeeDtoCopyWith<$Res> get directPayment {
    return $DirectPaymentFeeDtoCopyWith<$Res>(_value.directPayment, (value) {
      return _then(_value.copyWith(directPayment: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_GetFeesResponseDtoCopyWith<$Res>
    implements $GetFeesResponseDtoCopyWith<$Res> {
  factory _$$_GetFeesResponseDtoCopyWith(_$_GetFeesResponseDto value,
          $Res Function(_$_GetFeesResponseDto) then) =
      __$$_GetFeesResponseDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DirectPaymentFeeDto directPayment, int splitKeyPayment});

  @override
  $DirectPaymentFeeDtoCopyWith<$Res> get directPayment;
}

/// @nodoc
class __$$_GetFeesResponseDtoCopyWithImpl<$Res>
    extends _$GetFeesResponseDtoCopyWithImpl<$Res, _$_GetFeesResponseDto>
    implements _$$_GetFeesResponseDtoCopyWith<$Res> {
  __$$_GetFeesResponseDtoCopyWithImpl(
      _$_GetFeesResponseDto _value, $Res Function(_$_GetFeesResponseDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? directPayment = null,
    Object? splitKeyPayment = null,
  }) {
    return _then(_$_GetFeesResponseDto(
      directPayment: null == directPayment
          ? _value.directPayment
          : directPayment // ignore: cast_nullable_to_non_nullable
              as DirectPaymentFeeDto,
      splitKeyPayment: null == splitKeyPayment
          ? _value.splitKeyPayment
          : splitKeyPayment // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GetFeesResponseDto implements _GetFeesResponseDto {
  const _$_GetFeesResponseDto(
      {required this.directPayment, required this.splitKeyPayment});

  factory _$_GetFeesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$$_GetFeesResponseDtoFromJson(json);

  @override
  final DirectPaymentFeeDto directPayment;
  @override
  final int splitKeyPayment;

  @override
  String toString() {
    return 'GetFeesResponseDto(directPayment: $directPayment, splitKeyPayment: $splitKeyPayment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetFeesResponseDto &&
            (identical(other.directPayment, directPayment) ||
                other.directPayment == directPayment) &&
            (identical(other.splitKeyPayment, splitKeyPayment) ||
                other.splitKeyPayment == splitKeyPayment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, directPayment, splitKeyPayment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetFeesResponseDtoCopyWith<_$_GetFeesResponseDto> get copyWith =>
      __$$_GetFeesResponseDtoCopyWithImpl<_$_GetFeesResponseDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GetFeesResponseDtoToJson(
      this,
    );
  }
}

abstract class _GetFeesResponseDto implements GetFeesResponseDto {
  const factory _GetFeesResponseDto(
      {required final DirectPaymentFeeDto directPayment,
      required final int splitKeyPayment}) = _$_GetFeesResponseDto;

  factory _GetFeesResponseDto.fromJson(Map<String, dynamic> json) =
      _$_GetFeesResponseDto.fromJson;

  @override
  DirectPaymentFeeDto get directPayment;
  @override
  int get splitKeyPayment;
  @override
  @JsonKey(ignore: true)
  _$$_GetFeesResponseDtoCopyWith<_$_GetFeesResponseDto> get copyWith =>
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
abstract class _$$_DirectPaymentFeeDtoCopyWith<$Res>
    implements $DirectPaymentFeeDtoCopyWith<$Res> {
  factory _$$_DirectPaymentFeeDtoCopyWith(_$_DirectPaymentFeeDto value,
          $Res Function(_$_DirectPaymentFeeDto) then) =
      __$$_DirectPaymentFeeDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int ataExists, int ataDoesNotExist});
}

/// @nodoc
class __$$_DirectPaymentFeeDtoCopyWithImpl<$Res>
    extends _$DirectPaymentFeeDtoCopyWithImpl<$Res, _$_DirectPaymentFeeDto>
    implements _$$_DirectPaymentFeeDtoCopyWith<$Res> {
  __$$_DirectPaymentFeeDtoCopyWithImpl(_$_DirectPaymentFeeDto _value,
      $Res Function(_$_DirectPaymentFeeDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ataExists = null,
    Object? ataDoesNotExist = null,
  }) {
    return _then(_$_DirectPaymentFeeDto(
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
class _$_DirectPaymentFeeDto implements _DirectPaymentFeeDto {
  const _$_DirectPaymentFeeDto(
      {required this.ataExists, required this.ataDoesNotExist});

  factory _$_DirectPaymentFeeDto.fromJson(Map<String, dynamic> json) =>
      _$$_DirectPaymentFeeDtoFromJson(json);

  @override
  final int ataExists;
  @override
  final int ataDoesNotExist;

  @override
  String toString() {
    return 'DirectPaymentFeeDto(ataExists: $ataExists, ataDoesNotExist: $ataDoesNotExist)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DirectPaymentFeeDto &&
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
  _$$_DirectPaymentFeeDtoCopyWith<_$_DirectPaymentFeeDto> get copyWith =>
      __$$_DirectPaymentFeeDtoCopyWithImpl<_$_DirectPaymentFeeDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DirectPaymentFeeDtoToJson(
      this,
    );
  }
}

abstract class _DirectPaymentFeeDto implements DirectPaymentFeeDto {
  const factory _DirectPaymentFeeDto(
      {required final int ataExists,
      required final int ataDoesNotExist}) = _$_DirectPaymentFeeDto;

  factory _DirectPaymentFeeDto.fromJson(Map<String, dynamic> json) =
      _$_DirectPaymentFeeDto.fromJson;

  @override
  int get ataExists;
  @override
  int get ataDoesNotExist;
  @override
  @JsonKey(ignore: true)
  _$$_DirectPaymentFeeDtoCopyWith<_$_DirectPaymentFeeDto> get copyWith =>
      throw _privateConstructorUsedError;
}
