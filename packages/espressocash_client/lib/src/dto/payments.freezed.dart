// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CreateDirectPaymentRequestDto {
  String get senderAccount => throw _privateConstructorUsedError;
  String get receiverAccount => throw _privateConstructorUsedError;
  String? get referenceAccount => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  String get mintAddress => throw _privateConstructorUsedError;

  /// Create a copy of CreateDirectPaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateDirectPaymentRequestDtoCopyWith<CreateDirectPaymentRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateDirectPaymentRequestDtoCopyWith<$Res> {
  factory $CreateDirectPaymentRequestDtoCopyWith(
    CreateDirectPaymentRequestDto value,
    $Res Function(CreateDirectPaymentRequestDto) then,
  ) = _$CreateDirectPaymentRequestDtoCopyWithImpl<$Res, CreateDirectPaymentRequestDto>;
  @useResult
  $Res call({
    String senderAccount,
    String receiverAccount,
    String? referenceAccount,
    int amount,
    String mintAddress,
  });
}

/// @nodoc
class _$CreateDirectPaymentRequestDtoCopyWithImpl<$Res, $Val extends CreateDirectPaymentRequestDto>
    implements $CreateDirectPaymentRequestDtoCopyWith<$Res> {
  _$CreateDirectPaymentRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateDirectPaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderAccount = null,
    Object? receiverAccount = null,
    Object? referenceAccount = freezed,
    Object? amount = null,
    Object? mintAddress = null,
  }) {
    return _then(
      _value.copyWith(
            senderAccount:
                null == senderAccount
                    ? _value.senderAccount
                    : senderAccount // ignore: cast_nullable_to_non_nullable
                        as String,
            receiverAccount:
                null == receiverAccount
                    ? _value.receiverAccount
                    : receiverAccount // ignore: cast_nullable_to_non_nullable
                        as String,
            referenceAccount:
                freezed == referenceAccount
                    ? _value.referenceAccount
                    : referenceAccount // ignore: cast_nullable_to_non_nullable
                        as String?,
            amount:
                null == amount
                    ? _value.amount
                    : amount // ignore: cast_nullable_to_non_nullable
                        as int,
            mintAddress:
                null == mintAddress
                    ? _value.mintAddress
                    : mintAddress // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateDirectPaymentRequestDtoImplCopyWith<$Res>
    implements $CreateDirectPaymentRequestDtoCopyWith<$Res> {
  factory _$$CreateDirectPaymentRequestDtoImplCopyWith(
    _$CreateDirectPaymentRequestDtoImpl value,
    $Res Function(_$CreateDirectPaymentRequestDtoImpl) then,
  ) = __$$CreateDirectPaymentRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String senderAccount,
    String receiverAccount,
    String? referenceAccount,
    int amount,
    String mintAddress,
  });
}

/// @nodoc
class __$$CreateDirectPaymentRequestDtoImplCopyWithImpl<$Res>
    extends _$CreateDirectPaymentRequestDtoCopyWithImpl<$Res, _$CreateDirectPaymentRequestDtoImpl>
    implements _$$CreateDirectPaymentRequestDtoImplCopyWith<$Res> {
  __$$CreateDirectPaymentRequestDtoImplCopyWithImpl(
    _$CreateDirectPaymentRequestDtoImpl _value,
    $Res Function(_$CreateDirectPaymentRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateDirectPaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderAccount = null,
    Object? receiverAccount = null,
    Object? referenceAccount = freezed,
    Object? amount = null,
    Object? mintAddress = null,
  }) {
    return _then(
      _$CreateDirectPaymentRequestDtoImpl(
        senderAccount:
            null == senderAccount
                ? _value.senderAccount
                : senderAccount // ignore: cast_nullable_to_non_nullable
                    as String,
        receiverAccount:
            null == receiverAccount
                ? _value.receiverAccount
                : receiverAccount // ignore: cast_nullable_to_non_nullable
                    as String,
        referenceAccount:
            freezed == referenceAccount
                ? _value.referenceAccount
                : referenceAccount // ignore: cast_nullable_to_non_nullable
                    as String?,
        amount:
            null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                    as int,
        mintAddress:
            null == mintAddress
                ? _value.mintAddress
                : mintAddress // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$CreateDirectPaymentRequestDtoImpl implements _CreateDirectPaymentRequestDto {
  const _$CreateDirectPaymentRequestDtoImpl({
    required this.senderAccount,
    required this.receiverAccount,
    required this.referenceAccount,
    required this.amount,
    required this.mintAddress,
  });

  @override
  final String senderAccount;
  @override
  final String receiverAccount;
  @override
  final String? referenceAccount;
  @override
  final int amount;
  @override
  final String mintAddress;

  @override
  String toString() {
    return 'CreateDirectPaymentRequestDto(senderAccount: $senderAccount, receiverAccount: $receiverAccount, referenceAccount: $referenceAccount, amount: $amount, mintAddress: $mintAddress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateDirectPaymentRequestDtoImpl &&
            (identical(other.senderAccount, senderAccount) ||
                other.senderAccount == senderAccount) &&
            (identical(other.receiverAccount, receiverAccount) ||
                other.receiverAccount == receiverAccount) &&
            (identical(other.referenceAccount, referenceAccount) ||
                other.referenceAccount == referenceAccount) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.mintAddress, mintAddress) || other.mintAddress == mintAddress));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    senderAccount,
    receiverAccount,
    referenceAccount,
    amount,
    mintAddress,
  );

  /// Create a copy of CreateDirectPaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateDirectPaymentRequestDtoImplCopyWith<_$CreateDirectPaymentRequestDtoImpl> get copyWith =>
      __$$CreateDirectPaymentRequestDtoImplCopyWithImpl<_$CreateDirectPaymentRequestDtoImpl>(
        this,
        _$identity,
      );
}

abstract class _CreateDirectPaymentRequestDto implements CreateDirectPaymentRequestDto {
  const factory _CreateDirectPaymentRequestDto({
    required final String senderAccount,
    required final String receiverAccount,
    required final String? referenceAccount,
    required final int amount,
    required final String mintAddress,
  }) = _$CreateDirectPaymentRequestDtoImpl;

  @override
  String get senderAccount;
  @override
  String get receiverAccount;
  @override
  String? get referenceAccount;
  @override
  int get amount;
  @override
  String get mintAddress;

  /// Create a copy of CreateDirectPaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateDirectPaymentRequestDtoImplCopyWith<_$CreateDirectPaymentRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CreateDirectPaymentResponseDto {
  int get fee => throw _privateConstructorUsedError;
  String get transaction => throw _privateConstructorUsedError;
  BigInt get slot => throw _privateConstructorUsedError;

  /// Create a copy of CreateDirectPaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateDirectPaymentResponseDtoCopyWith<CreateDirectPaymentResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateDirectPaymentResponseDtoCopyWith<$Res> {
  factory $CreateDirectPaymentResponseDtoCopyWith(
    CreateDirectPaymentResponseDto value,
    $Res Function(CreateDirectPaymentResponseDto) then,
  ) = _$CreateDirectPaymentResponseDtoCopyWithImpl<$Res, CreateDirectPaymentResponseDto>;
  @useResult
  $Res call({int fee, String transaction, BigInt slot});
}

/// @nodoc
class _$CreateDirectPaymentResponseDtoCopyWithImpl<
  $Res,
  $Val extends CreateDirectPaymentResponseDto
>
    implements $CreateDirectPaymentResponseDtoCopyWith<$Res> {
  _$CreateDirectPaymentResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateDirectPaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? fee = null, Object? transaction = null, Object? slot = null}) {
    return _then(
      _value.copyWith(
            fee:
                null == fee
                    ? _value.fee
                    : fee // ignore: cast_nullable_to_non_nullable
                        as int,
            transaction:
                null == transaction
                    ? _value.transaction
                    : transaction // ignore: cast_nullable_to_non_nullable
                        as String,
            slot:
                null == slot
                    ? _value.slot
                    : slot // ignore: cast_nullable_to_non_nullable
                        as BigInt,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateDirectPaymentResponseDtoImplCopyWith<$Res>
    implements $CreateDirectPaymentResponseDtoCopyWith<$Res> {
  factory _$$CreateDirectPaymentResponseDtoImplCopyWith(
    _$CreateDirectPaymentResponseDtoImpl value,
    $Res Function(_$CreateDirectPaymentResponseDtoImpl) then,
  ) = __$$CreateDirectPaymentResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int fee, String transaction, BigInt slot});
}

/// @nodoc
class __$$CreateDirectPaymentResponseDtoImplCopyWithImpl<$Res>
    extends _$CreateDirectPaymentResponseDtoCopyWithImpl<$Res, _$CreateDirectPaymentResponseDtoImpl>
    implements _$$CreateDirectPaymentResponseDtoImplCopyWith<$Res> {
  __$$CreateDirectPaymentResponseDtoImplCopyWithImpl(
    _$CreateDirectPaymentResponseDtoImpl _value,
    $Res Function(_$CreateDirectPaymentResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateDirectPaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? fee = null, Object? transaction = null, Object? slot = null}) {
    return _then(
      _$CreateDirectPaymentResponseDtoImpl(
        fee:
            null == fee
                ? _value.fee
                : fee // ignore: cast_nullable_to_non_nullable
                    as int,
        transaction:
            null == transaction
                ? _value.transaction
                : transaction // ignore: cast_nullable_to_non_nullable
                    as String,
        slot:
            null == slot
                ? _value.slot
                : slot // ignore: cast_nullable_to_non_nullable
                    as BigInt,
      ),
    );
  }
}

/// @nodoc

class _$CreateDirectPaymentResponseDtoImpl implements _CreateDirectPaymentResponseDto {
  const _$CreateDirectPaymentResponseDtoImpl({
    required this.fee,
    required this.transaction,
    required this.slot,
  });

  @override
  final int fee;
  @override
  final String transaction;
  @override
  final BigInt slot;

  @override
  String toString() {
    return 'CreateDirectPaymentResponseDto(fee: $fee, transaction: $transaction, slot: $slot)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateDirectPaymentResponseDtoImpl &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.transaction, transaction) || other.transaction == transaction) &&
            (identical(other.slot, slot) || other.slot == slot));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fee, transaction, slot);

  /// Create a copy of CreateDirectPaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateDirectPaymentResponseDtoImplCopyWith<_$CreateDirectPaymentResponseDtoImpl>
  get copyWith =>
      __$$CreateDirectPaymentResponseDtoImplCopyWithImpl<_$CreateDirectPaymentResponseDtoImpl>(
        this,
        _$identity,
      );
}

abstract class _CreateDirectPaymentResponseDto implements CreateDirectPaymentResponseDto {
  const factory _CreateDirectPaymentResponseDto({
    required final int fee,
    required final String transaction,
    required final BigInt slot,
  }) = _$CreateDirectPaymentResponseDtoImpl;

  @override
  int get fee;
  @override
  String get transaction;
  @override
  BigInt get slot;

  /// Create a copy of CreateDirectPaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateDirectPaymentResponseDtoImplCopyWith<_$CreateDirectPaymentResponseDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CreatePaymentRequestDto {
  String get senderAccount => throw _privateConstructorUsedError;
  String get escrowAccount => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;

  /// Create a copy of CreatePaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreatePaymentRequestDtoCopyWith<CreatePaymentRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatePaymentRequestDtoCopyWith<$Res> {
  factory $CreatePaymentRequestDtoCopyWith(
    CreatePaymentRequestDto value,
    $Res Function(CreatePaymentRequestDto) then,
  ) = _$CreatePaymentRequestDtoCopyWithImpl<$Res, CreatePaymentRequestDto>;
  @useResult
  $Res call({String senderAccount, String escrowAccount, int amount});
}

/// @nodoc
class _$CreatePaymentRequestDtoCopyWithImpl<$Res, $Val extends CreatePaymentRequestDto>
    implements $CreatePaymentRequestDtoCopyWith<$Res> {
  _$CreatePaymentRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreatePaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? senderAccount = null, Object? escrowAccount = null, Object? amount = null}) {
    return _then(
      _value.copyWith(
            senderAccount:
                null == senderAccount
                    ? _value.senderAccount
                    : senderAccount // ignore: cast_nullable_to_non_nullable
                        as String,
            escrowAccount:
                null == escrowAccount
                    ? _value.escrowAccount
                    : escrowAccount // ignore: cast_nullable_to_non_nullable
                        as String,
            amount:
                null == amount
                    ? _value.amount
                    : amount // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreatePaymentRequestDtoImplCopyWith<$Res>
    implements $CreatePaymentRequestDtoCopyWith<$Res> {
  factory _$$CreatePaymentRequestDtoImplCopyWith(
    _$CreatePaymentRequestDtoImpl value,
    $Res Function(_$CreatePaymentRequestDtoImpl) then,
  ) = __$$CreatePaymentRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String senderAccount, String escrowAccount, int amount});
}

/// @nodoc
class __$$CreatePaymentRequestDtoImplCopyWithImpl<$Res>
    extends _$CreatePaymentRequestDtoCopyWithImpl<$Res, _$CreatePaymentRequestDtoImpl>
    implements _$$CreatePaymentRequestDtoImplCopyWith<$Res> {
  __$$CreatePaymentRequestDtoImplCopyWithImpl(
    _$CreatePaymentRequestDtoImpl _value,
    $Res Function(_$CreatePaymentRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreatePaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? senderAccount = null, Object? escrowAccount = null, Object? amount = null}) {
    return _then(
      _$CreatePaymentRequestDtoImpl(
        senderAccount:
            null == senderAccount
                ? _value.senderAccount
                : senderAccount // ignore: cast_nullable_to_non_nullable
                    as String,
        escrowAccount:
            null == escrowAccount
                ? _value.escrowAccount
                : escrowAccount // ignore: cast_nullable_to_non_nullable
                    as String,
        amount:
            null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _$CreatePaymentRequestDtoImpl implements _CreatePaymentRequestDto {
  const _$CreatePaymentRequestDtoImpl({
    required this.senderAccount,
    required this.escrowAccount,
    required this.amount,
  });

  @override
  final String senderAccount;
  @override
  final String escrowAccount;
  @override
  final int amount;

  @override
  String toString() {
    return 'CreatePaymentRequestDto(senderAccount: $senderAccount, escrowAccount: $escrowAccount, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatePaymentRequestDtoImpl &&
            (identical(other.senderAccount, senderAccount) ||
                other.senderAccount == senderAccount) &&
            (identical(other.escrowAccount, escrowAccount) ||
                other.escrowAccount == escrowAccount) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, senderAccount, escrowAccount, amount);

  /// Create a copy of CreatePaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatePaymentRequestDtoImplCopyWith<_$CreatePaymentRequestDtoImpl> get copyWith =>
      __$$CreatePaymentRequestDtoImplCopyWithImpl<_$CreatePaymentRequestDtoImpl>(this, _$identity);
}

abstract class _CreatePaymentRequestDto implements CreatePaymentRequestDto {
  const factory _CreatePaymentRequestDto({
    required final String senderAccount,
    required final String escrowAccount,
    required final int amount,
  }) = _$CreatePaymentRequestDtoImpl;

  @override
  String get senderAccount;
  @override
  String get escrowAccount;
  @override
  int get amount;

  /// Create a copy of CreatePaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreatePaymentRequestDtoImplCopyWith<_$CreatePaymentRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CreatePaymentResponseDto {
  String get transaction => throw _privateConstructorUsedError;
  BigInt get slot => throw _privateConstructorUsedError;

  /// Create a copy of CreatePaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreatePaymentResponseDtoCopyWith<CreatePaymentResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatePaymentResponseDtoCopyWith<$Res> {
  factory $CreatePaymentResponseDtoCopyWith(
    CreatePaymentResponseDto value,
    $Res Function(CreatePaymentResponseDto) then,
  ) = _$CreatePaymentResponseDtoCopyWithImpl<$Res, CreatePaymentResponseDto>;
  @useResult
  $Res call({String transaction, BigInt slot});
}

/// @nodoc
class _$CreatePaymentResponseDtoCopyWithImpl<$Res, $Val extends CreatePaymentResponseDto>
    implements $CreatePaymentResponseDtoCopyWith<$Res> {
  _$CreatePaymentResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreatePaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? transaction = null, Object? slot = null}) {
    return _then(
      _value.copyWith(
            transaction:
                null == transaction
                    ? _value.transaction
                    : transaction // ignore: cast_nullable_to_non_nullable
                        as String,
            slot:
                null == slot
                    ? _value.slot
                    : slot // ignore: cast_nullable_to_non_nullable
                        as BigInt,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreatePaymentResponseDtoImplCopyWith<$Res>
    implements $CreatePaymentResponseDtoCopyWith<$Res> {
  factory _$$CreatePaymentResponseDtoImplCopyWith(
    _$CreatePaymentResponseDtoImpl value,
    $Res Function(_$CreatePaymentResponseDtoImpl) then,
  ) = __$$CreatePaymentResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String transaction, BigInt slot});
}

/// @nodoc
class __$$CreatePaymentResponseDtoImplCopyWithImpl<$Res>
    extends _$CreatePaymentResponseDtoCopyWithImpl<$Res, _$CreatePaymentResponseDtoImpl>
    implements _$$CreatePaymentResponseDtoImplCopyWith<$Res> {
  __$$CreatePaymentResponseDtoImplCopyWithImpl(
    _$CreatePaymentResponseDtoImpl _value,
    $Res Function(_$CreatePaymentResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreatePaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? transaction = null, Object? slot = null}) {
    return _then(
      _$CreatePaymentResponseDtoImpl(
        transaction:
            null == transaction
                ? _value.transaction
                : transaction // ignore: cast_nullable_to_non_nullable
                    as String,
        slot:
            null == slot
                ? _value.slot
                : slot // ignore: cast_nullable_to_non_nullable
                    as BigInt,
      ),
    );
  }
}

/// @nodoc

class _$CreatePaymentResponseDtoImpl implements _CreatePaymentResponseDto {
  const _$CreatePaymentResponseDtoImpl({required this.transaction, required this.slot});

  @override
  final String transaction;
  @override
  final BigInt slot;

  @override
  String toString() {
    return 'CreatePaymentResponseDto(transaction: $transaction, slot: $slot)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatePaymentResponseDtoImpl &&
            (identical(other.transaction, transaction) || other.transaction == transaction) &&
            (identical(other.slot, slot) || other.slot == slot));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transaction, slot);

  /// Create a copy of CreatePaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatePaymentResponseDtoImplCopyWith<_$CreatePaymentResponseDtoImpl> get copyWith =>
      __$$CreatePaymentResponseDtoImplCopyWithImpl<_$CreatePaymentResponseDtoImpl>(
        this,
        _$identity,
      );
}

abstract class _CreatePaymentResponseDto implements CreatePaymentResponseDto {
  const factory _CreatePaymentResponseDto({
    required final String transaction,
    required final BigInt slot,
  }) = _$CreatePaymentResponseDtoImpl;

  @override
  String get transaction;
  @override
  BigInt get slot;

  /// Create a copy of CreatePaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreatePaymentResponseDtoImplCopyWith<_$CreatePaymentResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ReceivePaymentRequestDto {
  String get receiverAccount => throw _privateConstructorUsedError;
  String get escrowAccount => throw _privateConstructorUsedError;

  /// Create a copy of ReceivePaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReceivePaymentRequestDtoCopyWith<ReceivePaymentRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceivePaymentRequestDtoCopyWith<$Res> {
  factory $ReceivePaymentRequestDtoCopyWith(
    ReceivePaymentRequestDto value,
    $Res Function(ReceivePaymentRequestDto) then,
  ) = _$ReceivePaymentRequestDtoCopyWithImpl<$Res, ReceivePaymentRequestDto>;
  @useResult
  $Res call({String receiverAccount, String escrowAccount});
}

/// @nodoc
class _$ReceivePaymentRequestDtoCopyWithImpl<$Res, $Val extends ReceivePaymentRequestDto>
    implements $ReceivePaymentRequestDtoCopyWith<$Res> {
  _$ReceivePaymentRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReceivePaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? receiverAccount = null, Object? escrowAccount = null}) {
    return _then(
      _value.copyWith(
            receiverAccount:
                null == receiverAccount
                    ? _value.receiverAccount
                    : receiverAccount // ignore: cast_nullable_to_non_nullable
                        as String,
            escrowAccount:
                null == escrowAccount
                    ? _value.escrowAccount
                    : escrowAccount // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReceivePaymentRequestDtoImplCopyWith<$Res>
    implements $ReceivePaymentRequestDtoCopyWith<$Res> {
  factory _$$ReceivePaymentRequestDtoImplCopyWith(
    _$ReceivePaymentRequestDtoImpl value,
    $Res Function(_$ReceivePaymentRequestDtoImpl) then,
  ) = __$$ReceivePaymentRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String receiverAccount, String escrowAccount});
}

/// @nodoc
class __$$ReceivePaymentRequestDtoImplCopyWithImpl<$Res>
    extends _$ReceivePaymentRequestDtoCopyWithImpl<$Res, _$ReceivePaymentRequestDtoImpl>
    implements _$$ReceivePaymentRequestDtoImplCopyWith<$Res> {
  __$$ReceivePaymentRequestDtoImplCopyWithImpl(
    _$ReceivePaymentRequestDtoImpl _value,
    $Res Function(_$ReceivePaymentRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReceivePaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? receiverAccount = null, Object? escrowAccount = null}) {
    return _then(
      _$ReceivePaymentRequestDtoImpl(
        receiverAccount:
            null == receiverAccount
                ? _value.receiverAccount
                : receiverAccount // ignore: cast_nullable_to_non_nullable
                    as String,
        escrowAccount:
            null == escrowAccount
                ? _value.escrowAccount
                : escrowAccount // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$ReceivePaymentRequestDtoImpl implements _ReceivePaymentRequestDto {
  const _$ReceivePaymentRequestDtoImpl({
    required this.receiverAccount,
    required this.escrowAccount,
  });

  @override
  final String receiverAccount;
  @override
  final String escrowAccount;

  @override
  String toString() {
    return 'ReceivePaymentRequestDto(receiverAccount: $receiverAccount, escrowAccount: $escrowAccount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReceivePaymentRequestDtoImpl &&
            (identical(other.receiverAccount, receiverAccount) ||
                other.receiverAccount == receiverAccount) &&
            (identical(other.escrowAccount, escrowAccount) ||
                other.escrowAccount == escrowAccount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, receiverAccount, escrowAccount);

  /// Create a copy of ReceivePaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReceivePaymentRequestDtoImplCopyWith<_$ReceivePaymentRequestDtoImpl> get copyWith =>
      __$$ReceivePaymentRequestDtoImplCopyWithImpl<_$ReceivePaymentRequestDtoImpl>(
        this,
        _$identity,
      );
}

abstract class _ReceivePaymentRequestDto implements ReceivePaymentRequestDto {
  const factory _ReceivePaymentRequestDto({
    required final String receiverAccount,
    required final String escrowAccount,
  }) = _$ReceivePaymentRequestDtoImpl;

  @override
  String get receiverAccount;
  @override
  String get escrowAccount;

  /// Create a copy of ReceivePaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReceivePaymentRequestDtoImplCopyWith<_$ReceivePaymentRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ReceivePaymentResponseDto {
  String get transaction => throw _privateConstructorUsedError;
  BigInt get slot => throw _privateConstructorUsedError;

  /// Create a copy of ReceivePaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReceivePaymentResponseDtoCopyWith<ReceivePaymentResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceivePaymentResponseDtoCopyWith<$Res> {
  factory $ReceivePaymentResponseDtoCopyWith(
    ReceivePaymentResponseDto value,
    $Res Function(ReceivePaymentResponseDto) then,
  ) = _$ReceivePaymentResponseDtoCopyWithImpl<$Res, ReceivePaymentResponseDto>;
  @useResult
  $Res call({String transaction, BigInt slot});
}

/// @nodoc
class _$ReceivePaymentResponseDtoCopyWithImpl<$Res, $Val extends ReceivePaymentResponseDto>
    implements $ReceivePaymentResponseDtoCopyWith<$Res> {
  _$ReceivePaymentResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReceivePaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? transaction = null, Object? slot = null}) {
    return _then(
      _value.copyWith(
            transaction:
                null == transaction
                    ? _value.transaction
                    : transaction // ignore: cast_nullable_to_non_nullable
                        as String,
            slot:
                null == slot
                    ? _value.slot
                    : slot // ignore: cast_nullable_to_non_nullable
                        as BigInt,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReceivePaymentResponseDtoImplCopyWith<$Res>
    implements $ReceivePaymentResponseDtoCopyWith<$Res> {
  factory _$$ReceivePaymentResponseDtoImplCopyWith(
    _$ReceivePaymentResponseDtoImpl value,
    $Res Function(_$ReceivePaymentResponseDtoImpl) then,
  ) = __$$ReceivePaymentResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String transaction, BigInt slot});
}

/// @nodoc
class __$$ReceivePaymentResponseDtoImplCopyWithImpl<$Res>
    extends _$ReceivePaymentResponseDtoCopyWithImpl<$Res, _$ReceivePaymentResponseDtoImpl>
    implements _$$ReceivePaymentResponseDtoImplCopyWith<$Res> {
  __$$ReceivePaymentResponseDtoImplCopyWithImpl(
    _$ReceivePaymentResponseDtoImpl _value,
    $Res Function(_$ReceivePaymentResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReceivePaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? transaction = null, Object? slot = null}) {
    return _then(
      _$ReceivePaymentResponseDtoImpl(
        transaction:
            null == transaction
                ? _value.transaction
                : transaction // ignore: cast_nullable_to_non_nullable
                    as String,
        slot:
            null == slot
                ? _value.slot
                : slot // ignore: cast_nullable_to_non_nullable
                    as BigInt,
      ),
    );
  }
}

/// @nodoc

class _$ReceivePaymentResponseDtoImpl implements _ReceivePaymentResponseDto {
  const _$ReceivePaymentResponseDtoImpl({required this.transaction, required this.slot});

  @override
  final String transaction;
  @override
  final BigInt slot;

  @override
  String toString() {
    return 'ReceivePaymentResponseDto(transaction: $transaction, slot: $slot)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReceivePaymentResponseDtoImpl &&
            (identical(other.transaction, transaction) || other.transaction == transaction) &&
            (identical(other.slot, slot) || other.slot == slot));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transaction, slot);

  /// Create a copy of ReceivePaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReceivePaymentResponseDtoImplCopyWith<_$ReceivePaymentResponseDtoImpl> get copyWith =>
      __$$ReceivePaymentResponseDtoImplCopyWithImpl<_$ReceivePaymentResponseDtoImpl>(
        this,
        _$identity,
      );
}

abstract class _ReceivePaymentResponseDto implements ReceivePaymentResponseDto {
  const factory _ReceivePaymentResponseDto({
    required final String transaction,
    required final BigInt slot,
  }) = _$ReceivePaymentResponseDtoImpl;

  @override
  String get transaction;
  @override
  BigInt get slot;

  /// Create a copy of ReceivePaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReceivePaymentResponseDtoImplCopyWith<_$ReceivePaymentResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CancelPaymentRequestDto {
  String get senderAccount => throw _privateConstructorUsedError;
  String get escrowAccount => throw _privateConstructorUsedError;

  /// Create a copy of CancelPaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CancelPaymentRequestDtoCopyWith<CancelPaymentRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CancelPaymentRequestDtoCopyWith<$Res> {
  factory $CancelPaymentRequestDtoCopyWith(
    CancelPaymentRequestDto value,
    $Res Function(CancelPaymentRequestDto) then,
  ) = _$CancelPaymentRequestDtoCopyWithImpl<$Res, CancelPaymentRequestDto>;
  @useResult
  $Res call({String senderAccount, String escrowAccount});
}

/// @nodoc
class _$CancelPaymentRequestDtoCopyWithImpl<$Res, $Val extends CancelPaymentRequestDto>
    implements $CancelPaymentRequestDtoCopyWith<$Res> {
  _$CancelPaymentRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CancelPaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? senderAccount = null, Object? escrowAccount = null}) {
    return _then(
      _value.copyWith(
            senderAccount:
                null == senderAccount
                    ? _value.senderAccount
                    : senderAccount // ignore: cast_nullable_to_non_nullable
                        as String,
            escrowAccount:
                null == escrowAccount
                    ? _value.escrowAccount
                    : escrowAccount // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CancelPaymentRequestDtoImplCopyWith<$Res>
    implements $CancelPaymentRequestDtoCopyWith<$Res> {
  factory _$$CancelPaymentRequestDtoImplCopyWith(
    _$CancelPaymentRequestDtoImpl value,
    $Res Function(_$CancelPaymentRequestDtoImpl) then,
  ) = __$$CancelPaymentRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String senderAccount, String escrowAccount});
}

/// @nodoc
class __$$CancelPaymentRequestDtoImplCopyWithImpl<$Res>
    extends _$CancelPaymentRequestDtoCopyWithImpl<$Res, _$CancelPaymentRequestDtoImpl>
    implements _$$CancelPaymentRequestDtoImplCopyWith<$Res> {
  __$$CancelPaymentRequestDtoImplCopyWithImpl(
    _$CancelPaymentRequestDtoImpl _value,
    $Res Function(_$CancelPaymentRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CancelPaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? senderAccount = null, Object? escrowAccount = null}) {
    return _then(
      _$CancelPaymentRequestDtoImpl(
        senderAccount:
            null == senderAccount
                ? _value.senderAccount
                : senderAccount // ignore: cast_nullable_to_non_nullable
                    as String,
        escrowAccount:
            null == escrowAccount
                ? _value.escrowAccount
                : escrowAccount // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$CancelPaymentRequestDtoImpl implements _CancelPaymentRequestDto {
  const _$CancelPaymentRequestDtoImpl({required this.senderAccount, required this.escrowAccount});

  @override
  final String senderAccount;
  @override
  final String escrowAccount;

  @override
  String toString() {
    return 'CancelPaymentRequestDto(senderAccount: $senderAccount, escrowAccount: $escrowAccount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CancelPaymentRequestDtoImpl &&
            (identical(other.senderAccount, senderAccount) ||
                other.senderAccount == senderAccount) &&
            (identical(other.escrowAccount, escrowAccount) ||
                other.escrowAccount == escrowAccount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, senderAccount, escrowAccount);

  /// Create a copy of CancelPaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CancelPaymentRequestDtoImplCopyWith<_$CancelPaymentRequestDtoImpl> get copyWith =>
      __$$CancelPaymentRequestDtoImplCopyWithImpl<_$CancelPaymentRequestDtoImpl>(this, _$identity);
}

abstract class _CancelPaymentRequestDto implements CancelPaymentRequestDto {
  const factory _CancelPaymentRequestDto({
    required final String senderAccount,
    required final String escrowAccount,
  }) = _$CancelPaymentRequestDtoImpl;

  @override
  String get senderAccount;
  @override
  String get escrowAccount;

  /// Create a copy of CancelPaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CancelPaymentRequestDtoImplCopyWith<_$CancelPaymentRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CancelPaymentResponseDto {
  String get transaction => throw _privateConstructorUsedError;
  BigInt get slot => throw _privateConstructorUsedError;

  /// Create a copy of CancelPaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CancelPaymentResponseDtoCopyWith<CancelPaymentResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CancelPaymentResponseDtoCopyWith<$Res> {
  factory $CancelPaymentResponseDtoCopyWith(
    CancelPaymentResponseDto value,
    $Res Function(CancelPaymentResponseDto) then,
  ) = _$CancelPaymentResponseDtoCopyWithImpl<$Res, CancelPaymentResponseDto>;
  @useResult
  $Res call({String transaction, BigInt slot});
}

/// @nodoc
class _$CancelPaymentResponseDtoCopyWithImpl<$Res, $Val extends CancelPaymentResponseDto>
    implements $CancelPaymentResponseDtoCopyWith<$Res> {
  _$CancelPaymentResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CancelPaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? transaction = null, Object? slot = null}) {
    return _then(
      _value.copyWith(
            transaction:
                null == transaction
                    ? _value.transaction
                    : transaction // ignore: cast_nullable_to_non_nullable
                        as String,
            slot:
                null == slot
                    ? _value.slot
                    : slot // ignore: cast_nullable_to_non_nullable
                        as BigInt,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CancelPaymentResponseDtoImplCopyWith<$Res>
    implements $CancelPaymentResponseDtoCopyWith<$Res> {
  factory _$$CancelPaymentResponseDtoImplCopyWith(
    _$CancelPaymentResponseDtoImpl value,
    $Res Function(_$CancelPaymentResponseDtoImpl) then,
  ) = __$$CancelPaymentResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String transaction, BigInt slot});
}

/// @nodoc
class __$$CancelPaymentResponseDtoImplCopyWithImpl<$Res>
    extends _$CancelPaymentResponseDtoCopyWithImpl<$Res, _$CancelPaymentResponseDtoImpl>
    implements _$$CancelPaymentResponseDtoImplCopyWith<$Res> {
  __$$CancelPaymentResponseDtoImplCopyWithImpl(
    _$CancelPaymentResponseDtoImpl _value,
    $Res Function(_$CancelPaymentResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CancelPaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? transaction = null, Object? slot = null}) {
    return _then(
      _$CancelPaymentResponseDtoImpl(
        transaction:
            null == transaction
                ? _value.transaction
                : transaction // ignore: cast_nullable_to_non_nullable
                    as String,
        slot:
            null == slot
                ? _value.slot
                : slot // ignore: cast_nullable_to_non_nullable
                    as BigInt,
      ),
    );
  }
}

/// @nodoc

class _$CancelPaymentResponseDtoImpl implements _CancelPaymentResponseDto {
  const _$CancelPaymentResponseDtoImpl({required this.transaction, required this.slot});

  @override
  final String transaction;
  @override
  final BigInt slot;

  @override
  String toString() {
    return 'CancelPaymentResponseDto(transaction: $transaction, slot: $slot)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CancelPaymentResponseDtoImpl &&
            (identical(other.transaction, transaction) || other.transaction == transaction) &&
            (identical(other.slot, slot) || other.slot == slot));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transaction, slot);

  /// Create a copy of CancelPaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CancelPaymentResponseDtoImplCopyWith<_$CancelPaymentResponseDtoImpl> get copyWith =>
      __$$CancelPaymentResponseDtoImplCopyWithImpl<_$CancelPaymentResponseDtoImpl>(
        this,
        _$identity,
      );
}

abstract class _CancelPaymentResponseDto implements CancelPaymentResponseDto {
  const factory _CancelPaymentResponseDto({
    required final String transaction,
    required final BigInt slot,
  }) = _$CancelPaymentResponseDtoImpl;

  @override
  String get transaction;
  @override
  BigInt get slot;

  /// Create a copy of CancelPaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CancelPaymentResponseDtoImplCopyWith<_$CancelPaymentResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
