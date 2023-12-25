// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_funds.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AddFundsResponseDto _$AddFundsResponseDtoFromJson(Map<String, dynamic> json) {
  return _AddFundsResponseDto.fromJson(json);
}

/// @nodoc
mixin _$AddFundsResponseDto {
  String get signedUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddFundsResponseDtoCopyWith<AddFundsResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddFundsResponseDtoCopyWith<$Res> {
  factory $AddFundsResponseDtoCopyWith(
          AddFundsResponseDto value, $Res Function(AddFundsResponseDto) then) =
      _$AddFundsResponseDtoCopyWithImpl<$Res, AddFundsResponseDto>;
  @useResult
  $Res call({String signedUrl});
}

/// @nodoc
class _$AddFundsResponseDtoCopyWithImpl<$Res, $Val extends AddFundsResponseDto>
    implements $AddFundsResponseDtoCopyWith<$Res> {
  _$AddFundsResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signedUrl = null,
  }) {
    return _then(_value.copyWith(
      signedUrl: null == signedUrl
          ? _value.signedUrl
          : signedUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddFundsResponseDtoImplCopyWith<$Res>
    implements $AddFundsResponseDtoCopyWith<$Res> {
  factory _$$AddFundsResponseDtoImplCopyWith(_$AddFundsResponseDtoImpl value,
          $Res Function(_$AddFundsResponseDtoImpl) then) =
      __$$AddFundsResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String signedUrl});
}

/// @nodoc
class __$$AddFundsResponseDtoImplCopyWithImpl<$Res>
    extends _$AddFundsResponseDtoCopyWithImpl<$Res, _$AddFundsResponseDtoImpl>
    implements _$$AddFundsResponseDtoImplCopyWith<$Res> {
  __$$AddFundsResponseDtoImplCopyWithImpl(_$AddFundsResponseDtoImpl _value,
      $Res Function(_$AddFundsResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signedUrl = null,
  }) {
    return _then(_$AddFundsResponseDtoImpl(
      signedUrl: null == signedUrl
          ? _value.signedUrl
          : signedUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddFundsResponseDtoImpl implements _AddFundsResponseDto {
  const _$AddFundsResponseDtoImpl({required this.signedUrl});

  factory _$AddFundsResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddFundsResponseDtoImplFromJson(json);

  @override
  final String signedUrl;

  @override
  String toString() {
    return 'AddFundsResponseDto(signedUrl: $signedUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddFundsResponseDtoImpl &&
            (identical(other.signedUrl, signedUrl) ||
                other.signedUrl == signedUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, signedUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddFundsResponseDtoImplCopyWith<_$AddFundsResponseDtoImpl> get copyWith =>
      __$$AddFundsResponseDtoImplCopyWithImpl<_$AddFundsResponseDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddFundsResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _AddFundsResponseDto implements AddFundsResponseDto {
  const factory _AddFundsResponseDto({required final String signedUrl}) =
      _$AddFundsResponseDtoImpl;

  factory _AddFundsResponseDto.fromJson(Map<String, dynamic> json) =
      _$AddFundsResponseDtoImpl.fromJson;

  @override
  String get signedUrl;
  @override
  @JsonKey(ignore: true)
  _$$AddFundsResponseDtoImplCopyWith<_$AddFundsResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AddFundsRequestDto _$AddFundsRequestDtoFromJson(Map<String, dynamic> json) {
  return _AddFundsRequestDto.fromJson(json);
}

/// @nodoc
mixin _$AddFundsRequestDto {
  String get receiverAddress => throw _privateConstructorUsedError;
  String get tokenSymbol => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddFundsRequestDtoCopyWith<AddFundsRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddFundsRequestDtoCopyWith<$Res> {
  factory $AddFundsRequestDtoCopyWith(
          AddFundsRequestDto value, $Res Function(AddFundsRequestDto) then) =
      _$AddFundsRequestDtoCopyWithImpl<$Res, AddFundsRequestDto>;
  @useResult
  $Res call({String receiverAddress, String tokenSymbol});
}

/// @nodoc
class _$AddFundsRequestDtoCopyWithImpl<$Res, $Val extends AddFundsRequestDto>
    implements $AddFundsRequestDtoCopyWith<$Res> {
  _$AddFundsRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? receiverAddress = null,
    Object? tokenSymbol = null,
  }) {
    return _then(_value.copyWith(
      receiverAddress: null == receiverAddress
          ? _value.receiverAddress
          : receiverAddress // ignore: cast_nullable_to_non_nullable
              as String,
      tokenSymbol: null == tokenSymbol
          ? _value.tokenSymbol
          : tokenSymbol // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddFundsRequestDtoImplCopyWith<$Res>
    implements $AddFundsRequestDtoCopyWith<$Res> {
  factory _$$AddFundsRequestDtoImplCopyWith(_$AddFundsRequestDtoImpl value,
          $Res Function(_$AddFundsRequestDtoImpl) then) =
      __$$AddFundsRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String receiverAddress, String tokenSymbol});
}

/// @nodoc
class __$$AddFundsRequestDtoImplCopyWithImpl<$Res>
    extends _$AddFundsRequestDtoCopyWithImpl<$Res, _$AddFundsRequestDtoImpl>
    implements _$$AddFundsRequestDtoImplCopyWith<$Res> {
  __$$AddFundsRequestDtoImplCopyWithImpl(_$AddFundsRequestDtoImpl _value,
      $Res Function(_$AddFundsRequestDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? receiverAddress = null,
    Object? tokenSymbol = null,
  }) {
    return _then(_$AddFundsRequestDtoImpl(
      receiverAddress: null == receiverAddress
          ? _value.receiverAddress
          : receiverAddress // ignore: cast_nullable_to_non_nullable
              as String,
      tokenSymbol: null == tokenSymbol
          ? _value.tokenSymbol
          : tokenSymbol // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddFundsRequestDtoImpl implements _AddFundsRequestDto {
  const _$AddFundsRequestDtoImpl(
      {required this.receiverAddress, required this.tokenSymbol});

  factory _$AddFundsRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddFundsRequestDtoImplFromJson(json);

  @override
  final String receiverAddress;
  @override
  final String tokenSymbol;

  @override
  String toString() {
    return 'AddFundsRequestDto(receiverAddress: $receiverAddress, tokenSymbol: $tokenSymbol)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddFundsRequestDtoImpl &&
            (identical(other.receiverAddress, receiverAddress) ||
                other.receiverAddress == receiverAddress) &&
            (identical(other.tokenSymbol, tokenSymbol) ||
                other.tokenSymbol == tokenSymbol));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, receiverAddress, tokenSymbol);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddFundsRequestDtoImplCopyWith<_$AddFundsRequestDtoImpl> get copyWith =>
      __$$AddFundsRequestDtoImplCopyWithImpl<_$AddFundsRequestDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddFundsRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _AddFundsRequestDto implements AddFundsRequestDto {
  const factory _AddFundsRequestDto(
      {required final String receiverAddress,
      required final String tokenSymbol}) = _$AddFundsRequestDtoImpl;

  factory _AddFundsRequestDto.fromJson(Map<String, dynamic> json) =
      _$AddFundsRequestDtoImpl.fromJson;

  @override
  String get receiverAddress;
  @override
  String get tokenSymbol;
  @override
  @JsonKey(ignore: true)
  _$$AddFundsRequestDtoImplCopyWith<_$AddFundsRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
