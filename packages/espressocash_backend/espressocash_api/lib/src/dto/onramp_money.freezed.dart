// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onramp_money.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GenerateOnRampTokenResponseDto _$GenerateOnRampTokenResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _GenerateOnRampTokenResponseDto.fromJson(json);
}

/// @nodoc
mixin _$GenerateOnRampTokenResponseDto {
  String get token => throw _privateConstructorUsedError;
  String get depositAddress => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GenerateOnRampTokenResponseDtoCopyWith<GenerateOnRampTokenResponseDto>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenerateOnRampTokenResponseDtoCopyWith<$Res> {
  factory $GenerateOnRampTokenResponseDtoCopyWith(
          GenerateOnRampTokenResponseDto value,
          $Res Function(GenerateOnRampTokenResponseDto) then) =
      _$GenerateOnRampTokenResponseDtoCopyWithImpl<$Res,
          GenerateOnRampTokenResponseDto>;
  @useResult
  $Res call({String token, String depositAddress});
}

/// @nodoc
class _$GenerateOnRampTokenResponseDtoCopyWithImpl<$Res,
        $Val extends GenerateOnRampTokenResponseDto>
    implements $GenerateOnRampTokenResponseDtoCopyWith<$Res> {
  _$GenerateOnRampTokenResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? depositAddress = null,
  }) {
    return _then(_value.copyWith(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      depositAddress: null == depositAddress
          ? _value.depositAddress
          : depositAddress // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GenerateOnRampTokenResponseDtoCopyWith<$Res>
    implements $GenerateOnRampTokenResponseDtoCopyWith<$Res> {
  factory _$$_GenerateOnRampTokenResponseDtoCopyWith(
          _$_GenerateOnRampTokenResponseDto value,
          $Res Function(_$_GenerateOnRampTokenResponseDto) then) =
      __$$_GenerateOnRampTokenResponseDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String token, String depositAddress});
}

/// @nodoc
class __$$_GenerateOnRampTokenResponseDtoCopyWithImpl<$Res>
    extends _$GenerateOnRampTokenResponseDtoCopyWithImpl<$Res,
        _$_GenerateOnRampTokenResponseDto>
    implements _$$_GenerateOnRampTokenResponseDtoCopyWith<$Res> {
  __$$_GenerateOnRampTokenResponseDtoCopyWithImpl(
      _$_GenerateOnRampTokenResponseDto _value,
      $Res Function(_$_GenerateOnRampTokenResponseDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? depositAddress = null,
  }) {
    return _then(_$_GenerateOnRampTokenResponseDto(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      depositAddress: null == depositAddress
          ? _value.depositAddress
          : depositAddress // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GenerateOnRampTokenResponseDto
    implements _GenerateOnRampTokenResponseDto {
  const _$_GenerateOnRampTokenResponseDto(
      {required this.token, required this.depositAddress});

  factory _$_GenerateOnRampTokenResponseDto.fromJson(
          Map<String, dynamic> json) =>
      _$$_GenerateOnRampTokenResponseDtoFromJson(json);

  @override
  final String token;
  @override
  final String depositAddress;

  @override
  String toString() {
    return 'GenerateOnRampTokenResponseDto(token: $token, depositAddress: $depositAddress)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GenerateOnRampTokenResponseDto &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.depositAddress, depositAddress) ||
                other.depositAddress == depositAddress));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, token, depositAddress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GenerateOnRampTokenResponseDtoCopyWith<_$_GenerateOnRampTokenResponseDto>
      get copyWith => __$$_GenerateOnRampTokenResponseDtoCopyWithImpl<
          _$_GenerateOnRampTokenResponseDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GenerateOnRampTokenResponseDtoToJson(
      this,
    );
  }
}

abstract class _GenerateOnRampTokenResponseDto
    implements GenerateOnRampTokenResponseDto {
  const factory _GenerateOnRampTokenResponseDto(
          {required final String token, required final String depositAddress}) =
      _$_GenerateOnRampTokenResponseDto;

  factory _GenerateOnRampTokenResponseDto.fromJson(Map<String, dynamic> json) =
      _$_GenerateOnRampTokenResponseDto.fromJson;

  @override
  String get token;
  @override
  String get depositAddress;
  @override
  @JsonKey(ignore: true)
  _$$_GenerateOnRampTokenResponseDtoCopyWith<_$_GenerateOnRampTokenResponseDto>
      get copyWith => throw _privateConstructorUsedError;
}

GenerateOnRampTokenRequestDto _$GenerateOnRampTokenRequestDtoFromJson(
    Map<String, dynamic> json) {
  return _GenerateOnRampTokenRequestDto.fromJson(json);
}

/// @nodoc
mixin _$GenerateOnRampTokenRequestDto {
  String get message => throw _privateConstructorUsedError;
  String get signedMessage => throw _privateConstructorUsedError;
  String get walletAddress => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String get quantity => throw _privateConstructorUsedError;
  String get appId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GenerateOnRampTokenRequestDtoCopyWith<GenerateOnRampTokenRequestDto>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenerateOnRampTokenRequestDtoCopyWith<$Res> {
  factory $GenerateOnRampTokenRequestDtoCopyWith(
          GenerateOnRampTokenRequestDto value,
          $Res Function(GenerateOnRampTokenRequestDto) then) =
      _$GenerateOnRampTokenRequestDtoCopyWithImpl<$Res,
          GenerateOnRampTokenRequestDto>;
  @useResult
  $Res call(
      {String message,
      String signedMessage,
      String walletAddress,
      DateTime timestamp,
      String quantity,
      String appId});
}

/// @nodoc
class _$GenerateOnRampTokenRequestDtoCopyWithImpl<$Res,
        $Val extends GenerateOnRampTokenRequestDto>
    implements $GenerateOnRampTokenRequestDtoCopyWith<$Res> {
  _$GenerateOnRampTokenRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? signedMessage = null,
    Object? walletAddress = null,
    Object? timestamp = null,
    Object? quantity = null,
    Object? appId = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      signedMessage: null == signedMessage
          ? _value.signedMessage
          : signedMessage // ignore: cast_nullable_to_non_nullable
              as String,
      walletAddress: null == walletAddress
          ? _value.walletAddress
          : walletAddress // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String,
      appId: null == appId
          ? _value.appId
          : appId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GenerateOnRampTokenRequestDtoCopyWith<$Res>
    implements $GenerateOnRampTokenRequestDtoCopyWith<$Res> {
  factory _$$_GenerateOnRampTokenRequestDtoCopyWith(
          _$_GenerateOnRampTokenRequestDto value,
          $Res Function(_$_GenerateOnRampTokenRequestDto) then) =
      __$$_GenerateOnRampTokenRequestDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String message,
      String signedMessage,
      String walletAddress,
      DateTime timestamp,
      String quantity,
      String appId});
}

/// @nodoc
class __$$_GenerateOnRampTokenRequestDtoCopyWithImpl<$Res>
    extends _$GenerateOnRampTokenRequestDtoCopyWithImpl<$Res,
        _$_GenerateOnRampTokenRequestDto>
    implements _$$_GenerateOnRampTokenRequestDtoCopyWith<$Res> {
  __$$_GenerateOnRampTokenRequestDtoCopyWithImpl(
      _$_GenerateOnRampTokenRequestDto _value,
      $Res Function(_$_GenerateOnRampTokenRequestDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? signedMessage = null,
    Object? walletAddress = null,
    Object? timestamp = null,
    Object? quantity = null,
    Object? appId = null,
  }) {
    return _then(_$_GenerateOnRampTokenRequestDto(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      signedMessage: null == signedMessage
          ? _value.signedMessage
          : signedMessage // ignore: cast_nullable_to_non_nullable
              as String,
      walletAddress: null == walletAddress
          ? _value.walletAddress
          : walletAddress // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String,
      appId: null == appId
          ? _value.appId
          : appId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GenerateOnRampTokenRequestDto
    implements _GenerateOnRampTokenRequestDto {
  const _$_GenerateOnRampTokenRequestDto(
      {required this.message,
      required this.signedMessage,
      required this.walletAddress,
      required this.timestamp,
      required this.quantity,
      required this.appId});

  factory _$_GenerateOnRampTokenRequestDto.fromJson(
          Map<String, dynamic> json) =>
      _$$_GenerateOnRampTokenRequestDtoFromJson(json);

  @override
  final String message;
  @override
  final String signedMessage;
  @override
  final String walletAddress;
  @override
  final DateTime timestamp;
  @override
  final String quantity;
  @override
  final String appId;

  @override
  String toString() {
    return 'GenerateOnRampTokenRequestDto(message: $message, signedMessage: $signedMessage, walletAddress: $walletAddress, timestamp: $timestamp, quantity: $quantity, appId: $appId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GenerateOnRampTokenRequestDto &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.signedMessage, signedMessage) ||
                other.signedMessage == signedMessage) &&
            (identical(other.walletAddress, walletAddress) ||
                other.walletAddress == walletAddress) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.appId, appId) || other.appId == appId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message, signedMessage,
      walletAddress, timestamp, quantity, appId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GenerateOnRampTokenRequestDtoCopyWith<_$_GenerateOnRampTokenRequestDto>
      get copyWith => __$$_GenerateOnRampTokenRequestDtoCopyWithImpl<
          _$_GenerateOnRampTokenRequestDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GenerateOnRampTokenRequestDtoToJson(
      this,
    );
  }
}

abstract class _GenerateOnRampTokenRequestDto
    implements GenerateOnRampTokenRequestDto {
  const factory _GenerateOnRampTokenRequestDto(
      {required final String message,
      required final String signedMessage,
      required final String walletAddress,
      required final DateTime timestamp,
      required final String quantity,
      required final String appId}) = _$_GenerateOnRampTokenRequestDto;

  factory _GenerateOnRampTokenRequestDto.fromJson(Map<String, dynamic> json) =
      _$_GenerateOnRampTokenRequestDto.fromJson;

  @override
  String get message;
  @override
  String get signedMessage;
  @override
  String get walletAddress;
  @override
  DateTime get timestamp;
  @override
  String get quantity;
  @override
  String get appId;
  @override
  @JsonKey(ignore: true)
  _$$_GenerateOnRampTokenRequestDtoCopyWith<_$_GenerateOnRampTokenRequestDto>
      get copyWith => throw _privateConstructorUsedError;
}
