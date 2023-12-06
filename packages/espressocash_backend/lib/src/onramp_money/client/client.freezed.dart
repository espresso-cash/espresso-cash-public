// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GenerateTokenRequestDto _$GenerateTokenRequestDtoFromJson(
    Map<String, dynamic> json) {
  return _GenerateTokenRequestDto.fromJson(json);
}

/// @nodoc
mixin _$GenerateTokenRequestDto {
  String get messageToSign => throw _privateConstructorUsedError;
  String get signedMessage => throw _privateConstructorUsedError;
  String get walletAddress => throw _privateConstructorUsedError;
  String get quantity => throw _privateConstructorUsedError;
  String get appId => throw _privateConstructorUsedError;
  String get coinId => throw _privateConstructorUsedError;
  String get chainId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GenerateTokenRequestDtoCopyWith<GenerateTokenRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenerateTokenRequestDtoCopyWith<$Res> {
  factory $GenerateTokenRequestDtoCopyWith(GenerateTokenRequestDto value,
          $Res Function(GenerateTokenRequestDto) then) =
      _$GenerateTokenRequestDtoCopyWithImpl<$Res, GenerateTokenRequestDto>;
  @useResult
  $Res call(
      {String messageToSign,
      String signedMessage,
      String walletAddress,
      String quantity,
      String appId,
      String coinId,
      String chainId});
}

/// @nodoc
class _$GenerateTokenRequestDtoCopyWithImpl<$Res,
        $Val extends GenerateTokenRequestDto>
    implements $GenerateTokenRequestDtoCopyWith<$Res> {
  _$GenerateTokenRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageToSign = null,
    Object? signedMessage = null,
    Object? walletAddress = null,
    Object? quantity = null,
    Object? appId = null,
    Object? coinId = null,
    Object? chainId = null,
  }) {
    return _then(_value.copyWith(
      messageToSign: null == messageToSign
          ? _value.messageToSign
          : messageToSign // ignore: cast_nullable_to_non_nullable
              as String,
      signedMessage: null == signedMessage
          ? _value.signedMessage
          : signedMessage // ignore: cast_nullable_to_non_nullable
              as String,
      walletAddress: null == walletAddress
          ? _value.walletAddress
          : walletAddress // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String,
      appId: null == appId
          ? _value.appId
          : appId // ignore: cast_nullable_to_non_nullable
              as String,
      coinId: null == coinId
          ? _value.coinId
          : coinId // ignore: cast_nullable_to_non_nullable
              as String,
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GenerateTokenRequestDtoCopyWith<$Res>
    implements $GenerateTokenRequestDtoCopyWith<$Res> {
  factory _$$_GenerateTokenRequestDtoCopyWith(_$_GenerateTokenRequestDto value,
          $Res Function(_$_GenerateTokenRequestDto) then) =
      __$$_GenerateTokenRequestDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String messageToSign,
      String signedMessage,
      String walletAddress,
      String quantity,
      String appId,
      String coinId,
      String chainId});
}

/// @nodoc
class __$$_GenerateTokenRequestDtoCopyWithImpl<$Res>
    extends _$GenerateTokenRequestDtoCopyWithImpl<$Res,
        _$_GenerateTokenRequestDto>
    implements _$$_GenerateTokenRequestDtoCopyWith<$Res> {
  __$$_GenerateTokenRequestDtoCopyWithImpl(_$_GenerateTokenRequestDto _value,
      $Res Function(_$_GenerateTokenRequestDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageToSign = null,
    Object? signedMessage = null,
    Object? walletAddress = null,
    Object? quantity = null,
    Object? appId = null,
    Object? coinId = null,
    Object? chainId = null,
  }) {
    return _then(_$_GenerateTokenRequestDto(
      messageToSign: null == messageToSign
          ? _value.messageToSign
          : messageToSign // ignore: cast_nullable_to_non_nullable
              as String,
      signedMessage: null == signedMessage
          ? _value.signedMessage
          : signedMessage // ignore: cast_nullable_to_non_nullable
              as String,
      walletAddress: null == walletAddress
          ? _value.walletAddress
          : walletAddress // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String,
      appId: null == appId
          ? _value.appId
          : appId // ignore: cast_nullable_to_non_nullable
              as String,
      coinId: null == coinId
          ? _value.coinId
          : coinId // ignore: cast_nullable_to_non_nullable
              as String,
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GenerateTokenRequestDto implements _GenerateTokenRequestDto {
  const _$_GenerateTokenRequestDto(
      {required this.messageToSign,
      required this.signedMessage,
      required this.walletAddress,
      required this.quantity,
      required this.appId,
      required this.coinId,
      required this.chainId});

  factory _$_GenerateTokenRequestDto.fromJson(Map<String, dynamic> json) =>
      _$$_GenerateTokenRequestDtoFromJson(json);

  @override
  final String messageToSign;
  @override
  final String signedMessage;
  @override
  final String walletAddress;
  @override
  final String quantity;
  @override
  final String appId;
  @override
  final String coinId;
  @override
  final String chainId;

  @override
  String toString() {
    return 'GenerateTokenRequestDto(messageToSign: $messageToSign, signedMessage: $signedMessage, walletAddress: $walletAddress, quantity: $quantity, appId: $appId, coinId: $coinId, chainId: $chainId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GenerateTokenRequestDto &&
            (identical(other.messageToSign, messageToSign) ||
                other.messageToSign == messageToSign) &&
            (identical(other.signedMessage, signedMessage) ||
                other.signedMessage == signedMessage) &&
            (identical(other.walletAddress, walletAddress) ||
                other.walletAddress == walletAddress) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.appId, appId) || other.appId == appId) &&
            (identical(other.coinId, coinId) || other.coinId == coinId) &&
            (identical(other.chainId, chainId) || other.chainId == chainId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, messageToSign, signedMessage,
      walletAddress, quantity, appId, coinId, chainId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GenerateTokenRequestDtoCopyWith<_$_GenerateTokenRequestDto>
      get copyWith =>
          __$$_GenerateTokenRequestDtoCopyWithImpl<_$_GenerateTokenRequestDto>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GenerateTokenRequestDtoToJson(
      this,
    );
  }
}

abstract class _GenerateTokenRequestDto implements GenerateTokenRequestDto {
  const factory _GenerateTokenRequestDto(
      {required final String messageToSign,
      required final String signedMessage,
      required final String walletAddress,
      required final String quantity,
      required final String appId,
      required final String coinId,
      required final String chainId}) = _$_GenerateTokenRequestDto;

  factory _GenerateTokenRequestDto.fromJson(Map<String, dynamic> json) =
      _$_GenerateTokenRequestDto.fromJson;

  @override
  String get messageToSign;
  @override
  String get signedMessage;
  @override
  String get walletAddress;
  @override
  String get quantity;
  @override
  String get appId;
  @override
  String get coinId;
  @override
  String get chainId;
  @override
  @JsonKey(ignore: true)
  _$$_GenerateTokenRequestDtoCopyWith<_$_GenerateTokenRequestDto>
      get copyWith => throw _privateConstructorUsedError;
}

GenerateTokenResponseDto _$GenerateTokenResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _GenerateTokenResponseDto.fromJson(json);
}

/// @nodoc
mixin _$GenerateTokenResponseDto {
  String get token => throw _privateConstructorUsedError;
  String get depositAddress => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GenerateTokenResponseDtoCopyWith<GenerateTokenResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenerateTokenResponseDtoCopyWith<$Res> {
  factory $GenerateTokenResponseDtoCopyWith(GenerateTokenResponseDto value,
          $Res Function(GenerateTokenResponseDto) then) =
      _$GenerateTokenResponseDtoCopyWithImpl<$Res, GenerateTokenResponseDto>;
  @useResult
  $Res call({String token, String depositAddress});
}

/// @nodoc
class _$GenerateTokenResponseDtoCopyWithImpl<$Res,
        $Val extends GenerateTokenResponseDto>
    implements $GenerateTokenResponseDtoCopyWith<$Res> {
  _$GenerateTokenResponseDtoCopyWithImpl(this._value, this._then);

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
abstract class _$$_GenerateTokenResponseDtoCopyWith<$Res>
    implements $GenerateTokenResponseDtoCopyWith<$Res> {
  factory _$$_GenerateTokenResponseDtoCopyWith(
          _$_GenerateTokenResponseDto value,
          $Res Function(_$_GenerateTokenResponseDto) then) =
      __$$_GenerateTokenResponseDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String token, String depositAddress});
}

/// @nodoc
class __$$_GenerateTokenResponseDtoCopyWithImpl<$Res>
    extends _$GenerateTokenResponseDtoCopyWithImpl<$Res,
        _$_GenerateTokenResponseDto>
    implements _$$_GenerateTokenResponseDtoCopyWith<$Res> {
  __$$_GenerateTokenResponseDtoCopyWithImpl(_$_GenerateTokenResponseDto _value,
      $Res Function(_$_GenerateTokenResponseDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? depositAddress = null,
  }) {
    return _then(_$_GenerateTokenResponseDto(
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
class _$_GenerateTokenResponseDto implements _GenerateTokenResponseDto {
  const _$_GenerateTokenResponseDto(
      {required this.token, required this.depositAddress});

  factory _$_GenerateTokenResponseDto.fromJson(Map<String, dynamic> json) =>
      _$$_GenerateTokenResponseDtoFromJson(json);

  @override
  final String token;
  @override
  final String depositAddress;

  @override
  String toString() {
    return 'GenerateTokenResponseDto(token: $token, depositAddress: $depositAddress)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GenerateTokenResponseDto &&
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
  _$$_GenerateTokenResponseDtoCopyWith<_$_GenerateTokenResponseDto>
      get copyWith => __$$_GenerateTokenResponseDtoCopyWithImpl<
          _$_GenerateTokenResponseDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GenerateTokenResponseDtoToJson(
      this,
    );
  }
}

abstract class _GenerateTokenResponseDto implements GenerateTokenResponseDto {
  const factory _GenerateTokenResponseDto(
      {required final String token,
      required final String depositAddress}) = _$_GenerateTokenResponseDto;

  factory _GenerateTokenResponseDto.fromJson(Map<String, dynamic> json) =
      _$_GenerateTokenResponseDto.fromJson;

  @override
  String get token;
  @override
  String get depositAddress;
  @override
  @JsonKey(ignore: true)
  _$$_GenerateTokenResponseDtoCopyWith<_$_GenerateTokenResponseDto>
      get copyWith => throw _privateConstructorUsedError;
}

OnRampResponseDto<T> _$OnRampResponseDtoFromJson<T>(
    Map<String, dynamic> json, T Function(Object?) fromJsonT) {
  return _OnRampResponseDto<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$OnRampResponseDto<T> {
  T get data => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OnRampResponseDtoCopyWith<T, OnRampResponseDto<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnRampResponseDtoCopyWith<T, $Res> {
  factory $OnRampResponseDtoCopyWith(OnRampResponseDto<T> value,
          $Res Function(OnRampResponseDto<T>) then) =
      _$OnRampResponseDtoCopyWithImpl<T, $Res, OnRampResponseDto<T>>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class _$OnRampResponseDtoCopyWithImpl<T, $Res,
        $Val extends OnRampResponseDto<T>>
    implements $OnRampResponseDtoCopyWith<T, $Res> {
  _$OnRampResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OnRampResponseDtoCopyWith<T, $Res>
    implements $OnRampResponseDtoCopyWith<T, $Res> {
  factory _$$_OnRampResponseDtoCopyWith(_$_OnRampResponseDto<T> value,
          $Res Function(_$_OnRampResponseDto<T>) then) =
      __$$_OnRampResponseDtoCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$_OnRampResponseDtoCopyWithImpl<T, $Res>
    extends _$OnRampResponseDtoCopyWithImpl<T, $Res, _$_OnRampResponseDto<T>>
    implements _$$_OnRampResponseDtoCopyWith<T, $Res> {
  __$$_OnRampResponseDtoCopyWithImpl(_$_OnRampResponseDto<T> _value,
      $Res Function(_$_OnRampResponseDto<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_OnRampResponseDto<T>(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc
@JsonSerializable(createToJson: false, genericArgumentFactories: true)
class _$_OnRampResponseDto<T> implements _OnRampResponseDto<T> {
  const _$_OnRampResponseDto({required this.data});

  factory _$_OnRampResponseDto.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$_OnRampResponseDtoFromJson(json, fromJsonT);

  @override
  final T data;

  @override
  String toString() {
    return 'OnRampResponseDto<$T>(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OnRampResponseDto<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OnRampResponseDtoCopyWith<T, _$_OnRampResponseDto<T>> get copyWith =>
      __$$_OnRampResponseDtoCopyWithImpl<T, _$_OnRampResponseDto<T>>(
          this, _$identity);
}

abstract class _OnRampResponseDto<T> implements OnRampResponseDto<T> {
  const factory _OnRampResponseDto({required final T data}) =
      _$_OnRampResponseDto<T>;

  factory _OnRampResponseDto.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$_OnRampResponseDto<T>.fromJson;

  @override
  T get data;
  @override
  @JsonKey(ignore: true)
  _$$_OnRampResponseDtoCopyWith<T, _$_OnRampResponseDto<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
