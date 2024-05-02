// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'durable_transactions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetFreeNonceResponseDto _$GetFreeNonceResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _GetFreeNonceResponseDto.fromJson(json);
}

/// @nodoc
mixin _$GetFreeNonceResponseDto {
  String get nonce => throw _privateConstructorUsedError;
  String get nonceAccount => throw _privateConstructorUsedError;
  String get authority => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetFreeNonceResponseDtoCopyWith<GetFreeNonceResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetFreeNonceResponseDtoCopyWith<$Res> {
  factory $GetFreeNonceResponseDtoCopyWith(GetFreeNonceResponseDto value,
          $Res Function(GetFreeNonceResponseDto) then) =
      _$GetFreeNonceResponseDtoCopyWithImpl<$Res, GetFreeNonceResponseDto>;
  @useResult
  $Res call({String nonce, String nonceAccount, String authority});
}

/// @nodoc
class _$GetFreeNonceResponseDtoCopyWithImpl<$Res,
        $Val extends GetFreeNonceResponseDto>
    implements $GetFreeNonceResponseDtoCopyWith<$Res> {
  _$GetFreeNonceResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nonce = null,
    Object? nonceAccount = null,
    Object? authority = null,
  }) {
    return _then(_value.copyWith(
      nonce: null == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as String,
      nonceAccount: null == nonceAccount
          ? _value.nonceAccount
          : nonceAccount // ignore: cast_nullable_to_non_nullable
              as String,
      authority: null == authority
          ? _value.authority
          : authority // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetFreeNonceResponseDtoImplCopyWith<$Res>
    implements $GetFreeNonceResponseDtoCopyWith<$Res> {
  factory _$$GetFreeNonceResponseDtoImplCopyWith(
          _$GetFreeNonceResponseDtoImpl value,
          $Res Function(_$GetFreeNonceResponseDtoImpl) then) =
      __$$GetFreeNonceResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String nonce, String nonceAccount, String authority});
}

/// @nodoc
class __$$GetFreeNonceResponseDtoImplCopyWithImpl<$Res>
    extends _$GetFreeNonceResponseDtoCopyWithImpl<$Res,
        _$GetFreeNonceResponseDtoImpl>
    implements _$$GetFreeNonceResponseDtoImplCopyWith<$Res> {
  __$$GetFreeNonceResponseDtoImplCopyWithImpl(
      _$GetFreeNonceResponseDtoImpl _value,
      $Res Function(_$GetFreeNonceResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nonce = null,
    Object? nonceAccount = null,
    Object? authority = null,
  }) {
    return _then(_$GetFreeNonceResponseDtoImpl(
      nonce: null == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as String,
      nonceAccount: null == nonceAccount
          ? _value.nonceAccount
          : nonceAccount // ignore: cast_nullable_to_non_nullable
              as String,
      authority: null == authority
          ? _value.authority
          : authority // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetFreeNonceResponseDtoImpl implements _GetFreeNonceResponseDto {
  const _$GetFreeNonceResponseDtoImpl(
      {required this.nonce,
      required this.nonceAccount,
      required this.authority});

  factory _$GetFreeNonceResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetFreeNonceResponseDtoImplFromJson(json);

  @override
  final String nonce;
  @override
  final String nonceAccount;
  @override
  final String authority;

  @override
  String toString() {
    return 'GetFreeNonceResponseDto(nonce: $nonce, nonceAccount: $nonceAccount, authority: $authority)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetFreeNonceResponseDtoImpl &&
            (identical(other.nonce, nonce) || other.nonce == nonce) &&
            (identical(other.nonceAccount, nonceAccount) ||
                other.nonceAccount == nonceAccount) &&
            (identical(other.authority, authority) ||
                other.authority == authority));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, nonce, nonceAccount, authority);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetFreeNonceResponseDtoImplCopyWith<_$GetFreeNonceResponseDtoImpl>
      get copyWith => __$$GetFreeNonceResponseDtoImplCopyWithImpl<
          _$GetFreeNonceResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetFreeNonceResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _GetFreeNonceResponseDto implements GetFreeNonceResponseDto {
  const factory _GetFreeNonceResponseDto(
      {required final String nonce,
      required final String nonceAccount,
      required final String authority}) = _$GetFreeNonceResponseDtoImpl;

  factory _GetFreeNonceResponseDto.fromJson(Map<String, dynamic> json) =
      _$GetFreeNonceResponseDtoImpl.fromJson;

  @override
  String get nonce;
  @override
  String get nonceAccount;
  @override
  String get authority;
  @override
  @JsonKey(ignore: true)
  _$$GetFreeNonceResponseDtoImplCopyWith<_$GetFreeNonceResponseDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SubmitDurableTxRequestDto _$SubmitDurableTxRequestDtoFromJson(
    Map<String, dynamic> json) {
  return _SubmitDurableTxRequestDto.fromJson(json);
}

/// @nodoc
mixin _$SubmitDurableTxRequestDto {
  String get tx => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubmitDurableTxRequestDtoCopyWith<SubmitDurableTxRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubmitDurableTxRequestDtoCopyWith<$Res> {
  factory $SubmitDurableTxRequestDtoCopyWith(SubmitDurableTxRequestDto value,
          $Res Function(SubmitDurableTxRequestDto) then) =
      _$SubmitDurableTxRequestDtoCopyWithImpl<$Res, SubmitDurableTxRequestDto>;
  @useResult
  $Res call({String tx});
}

/// @nodoc
class _$SubmitDurableTxRequestDtoCopyWithImpl<$Res,
        $Val extends SubmitDurableTxRequestDto>
    implements $SubmitDurableTxRequestDtoCopyWith<$Res> {
  _$SubmitDurableTxRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tx = null,
  }) {
    return _then(_value.copyWith(
      tx: null == tx
          ? _value.tx
          : tx // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubmitDurableTxRequestDtoImplCopyWith<$Res>
    implements $SubmitDurableTxRequestDtoCopyWith<$Res> {
  factory _$$SubmitDurableTxRequestDtoImplCopyWith(
          _$SubmitDurableTxRequestDtoImpl value,
          $Res Function(_$SubmitDurableTxRequestDtoImpl) then) =
      __$$SubmitDurableTxRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String tx});
}

/// @nodoc
class __$$SubmitDurableTxRequestDtoImplCopyWithImpl<$Res>
    extends _$SubmitDurableTxRequestDtoCopyWithImpl<$Res,
        _$SubmitDurableTxRequestDtoImpl>
    implements _$$SubmitDurableTxRequestDtoImplCopyWith<$Res> {
  __$$SubmitDurableTxRequestDtoImplCopyWithImpl(
      _$SubmitDurableTxRequestDtoImpl _value,
      $Res Function(_$SubmitDurableTxRequestDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tx = null,
  }) {
    return _then(_$SubmitDurableTxRequestDtoImpl(
      tx: null == tx
          ? _value.tx
          : tx // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubmitDurableTxRequestDtoImpl implements _SubmitDurableTxRequestDto {
  const _$SubmitDurableTxRequestDtoImpl({required this.tx});

  factory _$SubmitDurableTxRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubmitDurableTxRequestDtoImplFromJson(json);

  @override
  final String tx;

  @override
  String toString() {
    return 'SubmitDurableTxRequestDto(tx: $tx)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitDurableTxRequestDtoImpl &&
            (identical(other.tx, tx) || other.tx == tx));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, tx);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmitDurableTxRequestDtoImplCopyWith<_$SubmitDurableTxRequestDtoImpl>
      get copyWith => __$$SubmitDurableTxRequestDtoImplCopyWithImpl<
          _$SubmitDurableTxRequestDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubmitDurableTxRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _SubmitDurableTxRequestDto implements SubmitDurableTxRequestDto {
  const factory _SubmitDurableTxRequestDto({required final String tx}) =
      _$SubmitDurableTxRequestDtoImpl;

  factory _SubmitDurableTxRequestDto.fromJson(Map<String, dynamic> json) =
      _$SubmitDurableTxRequestDtoImpl.fromJson;

  @override
  String get tx;
  @override
  @JsonKey(ignore: true)
  _$$SubmitDurableTxRequestDtoImplCopyWith<_$SubmitDurableTxRequestDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
