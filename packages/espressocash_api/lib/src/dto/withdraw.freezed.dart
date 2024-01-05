// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'withdraw.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WithdrawPaymentRequestDto _$WithdrawPaymentRequestDtoFromJson(
    Map<String, dynamic> json) {
  return _WithdrawPaymentRequestDto.fromJson(json);
}

/// @nodoc
mixin _$WithdrawPaymentRequestDto {
  String get senderAccount => throw _privateConstructorUsedError;
  String get receiverAccount => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  int? get feeAmount => throw _privateConstructorUsedError;
  Cluster get cluster => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WithdrawPaymentRequestDtoCopyWith<WithdrawPaymentRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WithdrawPaymentRequestDtoCopyWith<$Res> {
  factory $WithdrawPaymentRequestDtoCopyWith(WithdrawPaymentRequestDto value,
          $Res Function(WithdrawPaymentRequestDto) then) =
      _$WithdrawPaymentRequestDtoCopyWithImpl<$Res, WithdrawPaymentRequestDto>;
  @useResult
  $Res call(
      {String senderAccount,
      String receiverAccount,
      int amount,
      int? feeAmount,
      Cluster cluster});
}

/// @nodoc
class _$WithdrawPaymentRequestDtoCopyWithImpl<$Res,
        $Val extends WithdrawPaymentRequestDto>
    implements $WithdrawPaymentRequestDtoCopyWith<$Res> {
  _$WithdrawPaymentRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderAccount = null,
    Object? receiverAccount = null,
    Object? amount = null,
    Object? feeAmount = freezed,
    Object? cluster = null,
  }) {
    return _then(_value.copyWith(
      senderAccount: null == senderAccount
          ? _value.senderAccount
          : senderAccount // ignore: cast_nullable_to_non_nullable
              as String,
      receiverAccount: null == receiverAccount
          ? _value.receiverAccount
          : receiverAccount // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      feeAmount: freezed == feeAmount
          ? _value.feeAmount
          : feeAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      cluster: null == cluster
          ? _value.cluster
          : cluster // ignore: cast_nullable_to_non_nullable
              as Cluster,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WithdrawPaymentRequestDtoImplCopyWith<$Res>
    implements $WithdrawPaymentRequestDtoCopyWith<$Res> {
  factory _$$WithdrawPaymentRequestDtoImplCopyWith(
          _$WithdrawPaymentRequestDtoImpl value,
          $Res Function(_$WithdrawPaymentRequestDtoImpl) then) =
      __$$WithdrawPaymentRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String senderAccount,
      String receiverAccount,
      int amount,
      int? feeAmount,
      Cluster cluster});
}

/// @nodoc
class __$$WithdrawPaymentRequestDtoImplCopyWithImpl<$Res>
    extends _$WithdrawPaymentRequestDtoCopyWithImpl<$Res,
        _$WithdrawPaymentRequestDtoImpl>
    implements _$$WithdrawPaymentRequestDtoImplCopyWith<$Res> {
  __$$WithdrawPaymentRequestDtoImplCopyWithImpl(
      _$WithdrawPaymentRequestDtoImpl _value,
      $Res Function(_$WithdrawPaymentRequestDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderAccount = null,
    Object? receiverAccount = null,
    Object? amount = null,
    Object? feeAmount = freezed,
    Object? cluster = null,
  }) {
    return _then(_$WithdrawPaymentRequestDtoImpl(
      senderAccount: null == senderAccount
          ? _value.senderAccount
          : senderAccount // ignore: cast_nullable_to_non_nullable
              as String,
      receiverAccount: null == receiverAccount
          ? _value.receiverAccount
          : receiverAccount // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      feeAmount: freezed == feeAmount
          ? _value.feeAmount
          : feeAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      cluster: null == cluster
          ? _value.cluster
          : cluster // ignore: cast_nullable_to_non_nullable
              as Cluster,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WithdrawPaymentRequestDtoImpl implements _WithdrawPaymentRequestDto {
  const _$WithdrawPaymentRequestDtoImpl(
      {required this.senderAccount,
      required this.receiverAccount,
      required this.amount,
      required this.feeAmount,
      required this.cluster});

  factory _$WithdrawPaymentRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$WithdrawPaymentRequestDtoImplFromJson(json);

  @override
  final String senderAccount;
  @override
  final String receiverAccount;
  @override
  final int amount;
  @override
  final int? feeAmount;
  @override
  final Cluster cluster;

  @override
  String toString() {
    return 'WithdrawPaymentRequestDto(senderAccount: $senderAccount, receiverAccount: $receiverAccount, amount: $amount, feeAmount: $feeAmount, cluster: $cluster)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WithdrawPaymentRequestDtoImpl &&
            (identical(other.senderAccount, senderAccount) ||
                other.senderAccount == senderAccount) &&
            (identical(other.receiverAccount, receiverAccount) ||
                other.receiverAccount == receiverAccount) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.feeAmount, feeAmount) ||
                other.feeAmount == feeAmount) &&
            (identical(other.cluster, cluster) || other.cluster == cluster));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, senderAccount, receiverAccount, amount, feeAmount, cluster);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WithdrawPaymentRequestDtoImplCopyWith<_$WithdrawPaymentRequestDtoImpl>
      get copyWith => __$$WithdrawPaymentRequestDtoImplCopyWithImpl<
          _$WithdrawPaymentRequestDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WithdrawPaymentRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _WithdrawPaymentRequestDto implements WithdrawPaymentRequestDto {
  const factory _WithdrawPaymentRequestDto(
      {required final String senderAccount,
      required final String receiverAccount,
      required final int amount,
      required final int? feeAmount,
      required final Cluster cluster}) = _$WithdrawPaymentRequestDtoImpl;

  factory _WithdrawPaymentRequestDto.fromJson(Map<String, dynamic> json) =
      _$WithdrawPaymentRequestDtoImpl.fromJson;

  @override
  String get senderAccount;
  @override
  String get receiverAccount;
  @override
  int get amount;
  @override
  int? get feeAmount;
  @override
  Cluster get cluster;
  @override
  @JsonKey(ignore: true)
  _$$WithdrawPaymentRequestDtoImplCopyWith<_$WithdrawPaymentRequestDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

WithdrawPaymentResponseDto _$WithdrawPaymentResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _WithdrawPaymentResponseDto.fromJson(json);
}

/// @nodoc
mixin _$WithdrawPaymentResponseDto {
  String get transaction => throw _privateConstructorUsedError;
  BigInt get slot => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WithdrawPaymentResponseDtoCopyWith<WithdrawPaymentResponseDto>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WithdrawPaymentResponseDtoCopyWith<$Res> {
  factory $WithdrawPaymentResponseDtoCopyWith(WithdrawPaymentResponseDto value,
          $Res Function(WithdrawPaymentResponseDto) then) =
      _$WithdrawPaymentResponseDtoCopyWithImpl<$Res,
          WithdrawPaymentResponseDto>;
  @useResult
  $Res call({String transaction, BigInt slot});
}

/// @nodoc
class _$WithdrawPaymentResponseDtoCopyWithImpl<$Res,
        $Val extends WithdrawPaymentResponseDto>
    implements $WithdrawPaymentResponseDtoCopyWith<$Res> {
  _$WithdrawPaymentResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transaction = null,
    Object? slot = null,
  }) {
    return _then(_value.copyWith(
      transaction: null == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as String,
      slot: null == slot
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WithdrawPaymentResponseDtoImplCopyWith<$Res>
    implements $WithdrawPaymentResponseDtoCopyWith<$Res> {
  factory _$$WithdrawPaymentResponseDtoImplCopyWith(
          _$WithdrawPaymentResponseDtoImpl value,
          $Res Function(_$WithdrawPaymentResponseDtoImpl) then) =
      __$$WithdrawPaymentResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String transaction, BigInt slot});
}

/// @nodoc
class __$$WithdrawPaymentResponseDtoImplCopyWithImpl<$Res>
    extends _$WithdrawPaymentResponseDtoCopyWithImpl<$Res,
        _$WithdrawPaymentResponseDtoImpl>
    implements _$$WithdrawPaymentResponseDtoImplCopyWith<$Res> {
  __$$WithdrawPaymentResponseDtoImplCopyWithImpl(
      _$WithdrawPaymentResponseDtoImpl _value,
      $Res Function(_$WithdrawPaymentResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transaction = null,
    Object? slot = null,
  }) {
    return _then(_$WithdrawPaymentResponseDtoImpl(
      transaction: null == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as String,
      slot: null == slot
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WithdrawPaymentResponseDtoImpl implements _WithdrawPaymentResponseDto {
  const _$WithdrawPaymentResponseDtoImpl(
      {required this.transaction, required this.slot});

  factory _$WithdrawPaymentResponseDtoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$WithdrawPaymentResponseDtoImplFromJson(json);

  @override
  final String transaction;
  @override
  final BigInt slot;

  @override
  String toString() {
    return 'WithdrawPaymentResponseDto(transaction: $transaction, slot: $slot)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WithdrawPaymentResponseDtoImpl &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction) &&
            (identical(other.slot, slot) || other.slot == slot));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, transaction, slot);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WithdrawPaymentResponseDtoImplCopyWith<_$WithdrawPaymentResponseDtoImpl>
      get copyWith => __$$WithdrawPaymentResponseDtoImplCopyWithImpl<
          _$WithdrawPaymentResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WithdrawPaymentResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _WithdrawPaymentResponseDto
    implements WithdrawPaymentResponseDto {
  const factory _WithdrawPaymentResponseDto(
      {required final String transaction,
      required final BigInt slot}) = _$WithdrawPaymentResponseDtoImpl;

  factory _WithdrawPaymentResponseDto.fromJson(Map<String, dynamic> json) =
      _$WithdrawPaymentResponseDtoImpl.fromJson;

  @override
  String get transaction;
  @override
  BigInt get slot;
  @override
  @JsonKey(ignore: true)
  _$$WithdrawPaymentResponseDtoImplCopyWith<_$WithdrawPaymentResponseDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
