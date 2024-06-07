// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'moneygram.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MoneygramDepositRequestDto _$MoneygramDepositRequestDtoFromJson(
    Map<String, dynamic> json) {
  return _MoneygramDepositRequestDto.fromJson(json);
}

/// @nodoc
mixin _$MoneygramDepositRequestDto {
  String get signedTx => throw _privateConstructorUsedError;
  String get account => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  String get lang => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoneygramDepositRequestDtoCopyWith<MoneygramDepositRequestDto>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoneygramDepositRequestDtoCopyWith<$Res> {
  factory $MoneygramDepositRequestDtoCopyWith(MoneygramDepositRequestDto value,
          $Res Function(MoneygramDepositRequestDto) then) =
      _$MoneygramDepositRequestDtoCopyWithImpl<$Res,
          MoneygramDepositRequestDto>;
  @useResult
  $Res call({String signedTx, String account, String amount, String lang});
}

/// @nodoc
class _$MoneygramDepositRequestDtoCopyWithImpl<$Res,
        $Val extends MoneygramDepositRequestDto>
    implements $MoneygramDepositRequestDtoCopyWith<$Res> {
  _$MoneygramDepositRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signedTx = null,
    Object? account = null,
    Object? amount = null,
    Object? lang = null,
  }) {
    return _then(_value.copyWith(
      signedTx: null == signedTx
          ? _value.signedTx
          : signedTx // ignore: cast_nullable_to_non_nullable
              as String,
      account: null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      lang: null == lang
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MoneygramDepositRequestDtoImplCopyWith<$Res>
    implements $MoneygramDepositRequestDtoCopyWith<$Res> {
  factory _$$MoneygramDepositRequestDtoImplCopyWith(
          _$MoneygramDepositRequestDtoImpl value,
          $Res Function(_$MoneygramDepositRequestDtoImpl) then) =
      __$$MoneygramDepositRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String signedTx, String account, String amount, String lang});
}

/// @nodoc
class __$$MoneygramDepositRequestDtoImplCopyWithImpl<$Res>
    extends _$MoneygramDepositRequestDtoCopyWithImpl<$Res,
        _$MoneygramDepositRequestDtoImpl>
    implements _$$MoneygramDepositRequestDtoImplCopyWith<$Res> {
  __$$MoneygramDepositRequestDtoImplCopyWithImpl(
      _$MoneygramDepositRequestDtoImpl _value,
      $Res Function(_$MoneygramDepositRequestDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signedTx = null,
    Object? account = null,
    Object? amount = null,
    Object? lang = null,
  }) {
    return _then(_$MoneygramDepositRequestDtoImpl(
      signedTx: null == signedTx
          ? _value.signedTx
          : signedTx // ignore: cast_nullable_to_non_nullable
              as String,
      account: null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      lang: null == lang
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MoneygramDepositRequestDtoImpl implements _MoneygramDepositRequestDto {
  const _$MoneygramDepositRequestDtoImpl(
      {required this.signedTx,
      required this.account,
      required this.amount,
      required this.lang});

  factory _$MoneygramDepositRequestDtoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$MoneygramDepositRequestDtoImplFromJson(json);

  @override
  final String signedTx;
  @override
  final String account;
  @override
  final String amount;
  @override
  final String lang;

  @override
  String toString() {
    return 'MoneygramDepositRequestDto(signedTx: $signedTx, account: $account, amount: $amount, lang: $lang)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoneygramDepositRequestDtoImpl &&
            (identical(other.signedTx, signedTx) ||
                other.signedTx == signedTx) &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.lang, lang) || other.lang == lang));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, signedTx, account, amount, lang);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MoneygramDepositRequestDtoImplCopyWith<_$MoneygramDepositRequestDtoImpl>
      get copyWith => __$$MoneygramDepositRequestDtoImplCopyWithImpl<
          _$MoneygramDepositRequestDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MoneygramDepositRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _MoneygramDepositRequestDto
    implements MoneygramDepositRequestDto {
  const factory _MoneygramDepositRequestDto(
      {required final String signedTx,
      required final String account,
      required final String amount,
      required final String lang}) = _$MoneygramDepositRequestDtoImpl;

  factory _MoneygramDepositRequestDto.fromJson(Map<String, dynamic> json) =
      _$MoneygramDepositRequestDtoImpl.fromJson;

  @override
  String get signedTx;
  @override
  String get account;
  @override
  String get amount;
  @override
  String get lang;
  @override
  @JsonKey(ignore: true)
  _$$MoneygramDepositRequestDtoImplCopyWith<_$MoneygramDepositRequestDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MoneygramDepositResponseDto _$MoneygramDepositResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _MoneygramDepositResponseDto.fromJson(json);
}

/// @nodoc
mixin _$MoneygramDepositResponseDto {
  String get id => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoneygramDepositResponseDtoCopyWith<MoneygramDepositResponseDto>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoneygramDepositResponseDtoCopyWith<$Res> {
  factory $MoneygramDepositResponseDtoCopyWith(
          MoneygramDepositResponseDto value,
          $Res Function(MoneygramDepositResponseDto) then) =
      _$MoneygramDepositResponseDtoCopyWithImpl<$Res,
          MoneygramDepositResponseDto>;
  @useResult
  $Res call({String id, String url, String token});
}

/// @nodoc
class _$MoneygramDepositResponseDtoCopyWithImpl<$Res,
        $Val extends MoneygramDepositResponseDto>
    implements $MoneygramDepositResponseDtoCopyWith<$Res> {
  _$MoneygramDepositResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? token = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MoneygramDepositResponseDtoImplCopyWith<$Res>
    implements $MoneygramDepositResponseDtoCopyWith<$Res> {
  factory _$$MoneygramDepositResponseDtoImplCopyWith(
          _$MoneygramDepositResponseDtoImpl value,
          $Res Function(_$MoneygramDepositResponseDtoImpl) then) =
      __$$MoneygramDepositResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String url, String token});
}

/// @nodoc
class __$$MoneygramDepositResponseDtoImplCopyWithImpl<$Res>
    extends _$MoneygramDepositResponseDtoCopyWithImpl<$Res,
        _$MoneygramDepositResponseDtoImpl>
    implements _$$MoneygramDepositResponseDtoImplCopyWith<$Res> {
  __$$MoneygramDepositResponseDtoImplCopyWithImpl(
      _$MoneygramDepositResponseDtoImpl _value,
      $Res Function(_$MoneygramDepositResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? token = null,
  }) {
    return _then(_$MoneygramDepositResponseDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MoneygramDepositResponseDtoImpl
    implements _MoneygramDepositResponseDto {
  const _$MoneygramDepositResponseDtoImpl(
      {required this.id, required this.url, required this.token});

  factory _$MoneygramDepositResponseDtoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$MoneygramDepositResponseDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String url;
  @override
  final String token;

  @override
  String toString() {
    return 'MoneygramDepositResponseDto(id: $id, url: $url, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoneygramDepositResponseDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, url, token);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MoneygramDepositResponseDtoImplCopyWith<_$MoneygramDepositResponseDtoImpl>
      get copyWith => __$$MoneygramDepositResponseDtoImplCopyWithImpl<
          _$MoneygramDepositResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MoneygramDepositResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _MoneygramDepositResponseDto
    implements MoneygramDepositResponseDto {
  const factory _MoneygramDepositResponseDto(
      {required final String id,
      required final String url,
      required final String token}) = _$MoneygramDepositResponseDtoImpl;

  factory _MoneygramDepositResponseDto.fromJson(Map<String, dynamic> json) =
      _$MoneygramDepositResponseDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get url;
  @override
  String get token;
  @override
  @JsonKey(ignore: true)
  _$$MoneygramDepositResponseDtoImplCopyWith<_$MoneygramDepositResponseDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
