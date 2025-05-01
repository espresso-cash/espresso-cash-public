// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dln_payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OutgoingQuoteRequestDto {
  int get amount => throw _privateConstructorUsedError;
  String get receiverAddress => throw _privateConstructorUsedError;
  String get receiverBlockchain => throw _privateConstructorUsedError;

  /// Create a copy of OutgoingQuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OutgoingQuoteRequestDtoCopyWith<OutgoingQuoteRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutgoingQuoteRequestDtoCopyWith<$Res> {
  factory $OutgoingQuoteRequestDtoCopyWith(
    OutgoingQuoteRequestDto value,
    $Res Function(OutgoingQuoteRequestDto) then,
  ) = _$OutgoingQuoteRequestDtoCopyWithImpl<$Res, OutgoingQuoteRequestDto>;
  @useResult
  $Res call({int amount, String receiverAddress, String receiverBlockchain});
}

/// @nodoc
class _$OutgoingQuoteRequestDtoCopyWithImpl<$Res, $Val extends OutgoingQuoteRequestDto>
    implements $OutgoingQuoteRequestDtoCopyWith<$Res> {
  _$OutgoingQuoteRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OutgoingQuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? receiverAddress = null,
    Object? receiverBlockchain = null,
  }) {
    return _then(
      _value.copyWith(
            amount:
                null == amount
                    ? _value.amount
                    : amount // ignore: cast_nullable_to_non_nullable
                        as int,
            receiverAddress:
                null == receiverAddress
                    ? _value.receiverAddress
                    : receiverAddress // ignore: cast_nullable_to_non_nullable
                        as String,
            receiverBlockchain:
                null == receiverBlockchain
                    ? _value.receiverBlockchain
                    : receiverBlockchain // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OutgoingQuoteRequestDtoImplCopyWith<$Res>
    implements $OutgoingQuoteRequestDtoCopyWith<$Res> {
  factory _$$OutgoingQuoteRequestDtoImplCopyWith(
    _$OutgoingQuoteRequestDtoImpl value,
    $Res Function(_$OutgoingQuoteRequestDtoImpl) then,
  ) = __$$OutgoingQuoteRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int amount, String receiverAddress, String receiverBlockchain});
}

/// @nodoc
class __$$OutgoingQuoteRequestDtoImplCopyWithImpl<$Res>
    extends _$OutgoingQuoteRequestDtoCopyWithImpl<$Res, _$OutgoingQuoteRequestDtoImpl>
    implements _$$OutgoingQuoteRequestDtoImplCopyWith<$Res> {
  __$$OutgoingQuoteRequestDtoImplCopyWithImpl(
    _$OutgoingQuoteRequestDtoImpl _value,
    $Res Function(_$OutgoingQuoteRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutgoingQuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? receiverAddress = null,
    Object? receiverBlockchain = null,
  }) {
    return _then(
      _$OutgoingQuoteRequestDtoImpl(
        amount:
            null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                    as int,
        receiverAddress:
            null == receiverAddress
                ? _value.receiverAddress
                : receiverAddress // ignore: cast_nullable_to_non_nullable
                    as String,
        receiverBlockchain:
            null == receiverBlockchain
                ? _value.receiverBlockchain
                : receiverBlockchain // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$OutgoingQuoteRequestDtoImpl implements _OutgoingQuoteRequestDto {
  const _$OutgoingQuoteRequestDtoImpl({
    required this.amount,
    required this.receiverAddress,
    required this.receiverBlockchain,
  });

  @override
  final int amount;
  @override
  final String receiverAddress;
  @override
  final String receiverBlockchain;

  @override
  String toString() {
    return 'OutgoingQuoteRequestDto(amount: $amount, receiverAddress: $receiverAddress, receiverBlockchain: $receiverBlockchain)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutgoingQuoteRequestDtoImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.receiverAddress, receiverAddress) ||
                other.receiverAddress == receiverAddress) &&
            (identical(other.receiverBlockchain, receiverBlockchain) ||
                other.receiverBlockchain == receiverBlockchain));
  }

  @override
  int get hashCode => Object.hash(runtimeType, amount, receiverAddress, receiverBlockchain);

  /// Create a copy of OutgoingQuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OutgoingQuoteRequestDtoImplCopyWith<_$OutgoingQuoteRequestDtoImpl> get copyWith =>
      __$$OutgoingQuoteRequestDtoImplCopyWithImpl<_$OutgoingQuoteRequestDtoImpl>(this, _$identity);
}

abstract class _OutgoingQuoteRequestDto implements OutgoingQuoteRequestDto {
  const factory _OutgoingQuoteRequestDto({
    required final int amount,
    required final String receiverAddress,
    required final String receiverBlockchain,
  }) = _$OutgoingQuoteRequestDtoImpl;

  @override
  int get amount;
  @override
  String get receiverAddress;
  @override
  String get receiverBlockchain;

  /// Create a copy of OutgoingQuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OutgoingQuoteRequestDtoImplCopyWith<_$OutgoingQuoteRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$OutgoingQuoteResponseDto {
  int get inputAmount => throw _privateConstructorUsedError;
  int get receiverAmount => throw _privateConstructorUsedError;
  String get encodedTx => throw _privateConstructorUsedError;
  int get feeInUsdc => throw _privateConstructorUsedError;
  BigInt get slot => throw _privateConstructorUsedError;

  /// Create a copy of OutgoingQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OutgoingQuoteResponseDtoCopyWith<OutgoingQuoteResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutgoingQuoteResponseDtoCopyWith<$Res> {
  factory $OutgoingQuoteResponseDtoCopyWith(
    OutgoingQuoteResponseDto value,
    $Res Function(OutgoingQuoteResponseDto) then,
  ) = _$OutgoingQuoteResponseDtoCopyWithImpl<$Res, OutgoingQuoteResponseDto>;
  @useResult
  $Res call({int inputAmount, int receiverAmount, String encodedTx, int feeInUsdc, BigInt slot});
}

/// @nodoc
class _$OutgoingQuoteResponseDtoCopyWithImpl<$Res, $Val extends OutgoingQuoteResponseDto>
    implements $OutgoingQuoteResponseDtoCopyWith<$Res> {
  _$OutgoingQuoteResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OutgoingQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputAmount = null,
    Object? receiverAmount = null,
    Object? encodedTx = null,
    Object? feeInUsdc = null,
    Object? slot = null,
  }) {
    return _then(
      _value.copyWith(
            inputAmount:
                null == inputAmount
                    ? _value.inputAmount
                    : inputAmount // ignore: cast_nullable_to_non_nullable
                        as int,
            receiverAmount:
                null == receiverAmount
                    ? _value.receiverAmount
                    : receiverAmount // ignore: cast_nullable_to_non_nullable
                        as int,
            encodedTx:
                null == encodedTx
                    ? _value.encodedTx
                    : encodedTx // ignore: cast_nullable_to_non_nullable
                        as String,
            feeInUsdc:
                null == feeInUsdc
                    ? _value.feeInUsdc
                    : feeInUsdc // ignore: cast_nullable_to_non_nullable
                        as int,
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
abstract class _$$OutgoingQuoteResponseDtoImplCopyWith<$Res>
    implements $OutgoingQuoteResponseDtoCopyWith<$Res> {
  factory _$$OutgoingQuoteResponseDtoImplCopyWith(
    _$OutgoingQuoteResponseDtoImpl value,
    $Res Function(_$OutgoingQuoteResponseDtoImpl) then,
  ) = __$$OutgoingQuoteResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int inputAmount, int receiverAmount, String encodedTx, int feeInUsdc, BigInt slot});
}

/// @nodoc
class __$$OutgoingQuoteResponseDtoImplCopyWithImpl<$Res>
    extends _$OutgoingQuoteResponseDtoCopyWithImpl<$Res, _$OutgoingQuoteResponseDtoImpl>
    implements _$$OutgoingQuoteResponseDtoImplCopyWith<$Res> {
  __$$OutgoingQuoteResponseDtoImplCopyWithImpl(
    _$OutgoingQuoteResponseDtoImpl _value,
    $Res Function(_$OutgoingQuoteResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutgoingQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputAmount = null,
    Object? receiverAmount = null,
    Object? encodedTx = null,
    Object? feeInUsdc = null,
    Object? slot = null,
  }) {
    return _then(
      _$OutgoingQuoteResponseDtoImpl(
        inputAmount:
            null == inputAmount
                ? _value.inputAmount
                : inputAmount // ignore: cast_nullable_to_non_nullable
                    as int,
        receiverAmount:
            null == receiverAmount
                ? _value.receiverAmount
                : receiverAmount // ignore: cast_nullable_to_non_nullable
                    as int,
        encodedTx:
            null == encodedTx
                ? _value.encodedTx
                : encodedTx // ignore: cast_nullable_to_non_nullable
                    as String,
        feeInUsdc:
            null == feeInUsdc
                ? _value.feeInUsdc
                : feeInUsdc // ignore: cast_nullable_to_non_nullable
                    as int,
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

class _$OutgoingQuoteResponseDtoImpl implements _OutgoingQuoteResponseDto {
  const _$OutgoingQuoteResponseDtoImpl({
    required this.inputAmount,
    required this.receiverAmount,
    required this.encodedTx,
    required this.feeInUsdc,
    required this.slot,
  });

  @override
  final int inputAmount;
  @override
  final int receiverAmount;
  @override
  final String encodedTx;
  @override
  final int feeInUsdc;
  @override
  final BigInt slot;

  @override
  String toString() {
    return 'OutgoingQuoteResponseDto(inputAmount: $inputAmount, receiverAmount: $receiverAmount, encodedTx: $encodedTx, feeInUsdc: $feeInUsdc, slot: $slot)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutgoingQuoteResponseDtoImpl &&
            (identical(other.inputAmount, inputAmount) || other.inputAmount == inputAmount) &&
            (identical(other.receiverAmount, receiverAmount) ||
                other.receiverAmount == receiverAmount) &&
            (identical(other.encodedTx, encodedTx) || other.encodedTx == encodedTx) &&
            (identical(other.feeInUsdc, feeInUsdc) || other.feeInUsdc == feeInUsdc) &&
            (identical(other.slot, slot) || other.slot == slot));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, inputAmount, receiverAmount, encodedTx, feeInUsdc, slot);

  /// Create a copy of OutgoingQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OutgoingQuoteResponseDtoImplCopyWith<_$OutgoingQuoteResponseDtoImpl> get copyWith =>
      __$$OutgoingQuoteResponseDtoImplCopyWithImpl<_$OutgoingQuoteResponseDtoImpl>(
        this,
        _$identity,
      );
}

abstract class _OutgoingQuoteResponseDto implements OutgoingQuoteResponseDto {
  const factory _OutgoingQuoteResponseDto({
    required final int inputAmount,
    required final int receiverAmount,
    required final String encodedTx,
    required final int feeInUsdc,
    required final BigInt slot,
  }) = _$OutgoingQuoteResponseDtoImpl;

  @override
  int get inputAmount;
  @override
  int get receiverAmount;
  @override
  String get encodedTx;
  @override
  int get feeInUsdc;
  @override
  BigInt get slot;

  /// Create a copy of OutgoingQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OutgoingQuoteResponseDtoImplCopyWith<_$OutgoingQuoteResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$OrderStatusDlnRequestDto {
  String get orderId => throw _privateConstructorUsedError;

  /// Create a copy of OrderStatusDlnRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderStatusDlnRequestDtoCopyWith<OrderStatusDlnRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderStatusDlnRequestDtoCopyWith<$Res> {
  factory $OrderStatusDlnRequestDtoCopyWith(
    OrderStatusDlnRequestDto value,
    $Res Function(OrderStatusDlnRequestDto) then,
  ) = _$OrderStatusDlnRequestDtoCopyWithImpl<$Res, OrderStatusDlnRequestDto>;
  @useResult
  $Res call({String orderId});
}

/// @nodoc
class _$OrderStatusDlnRequestDtoCopyWithImpl<$Res, $Val extends OrderStatusDlnRequestDto>
    implements $OrderStatusDlnRequestDtoCopyWith<$Res> {
  _$OrderStatusDlnRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderStatusDlnRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? orderId = null}) {
    return _then(
      _value.copyWith(
            orderId:
                null == orderId
                    ? _value.orderId
                    : orderId // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderStatusDlnRequestDtoImplCopyWith<$Res>
    implements $OrderStatusDlnRequestDtoCopyWith<$Res> {
  factory _$$OrderStatusDlnRequestDtoImplCopyWith(
    _$OrderStatusDlnRequestDtoImpl value,
    $Res Function(_$OrderStatusDlnRequestDtoImpl) then,
  ) = __$$OrderStatusDlnRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String orderId});
}

/// @nodoc
class __$$OrderStatusDlnRequestDtoImplCopyWithImpl<$Res>
    extends _$OrderStatusDlnRequestDtoCopyWithImpl<$Res, _$OrderStatusDlnRequestDtoImpl>
    implements _$$OrderStatusDlnRequestDtoImplCopyWith<$Res> {
  __$$OrderStatusDlnRequestDtoImplCopyWithImpl(
    _$OrderStatusDlnRequestDtoImpl _value,
    $Res Function(_$OrderStatusDlnRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderStatusDlnRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? orderId = null}) {
    return _then(
      _$OrderStatusDlnRequestDtoImpl(
        orderId:
            null == orderId
                ? _value.orderId
                : orderId // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$OrderStatusDlnRequestDtoImpl implements _OrderStatusDlnRequestDto {
  const _$OrderStatusDlnRequestDtoImpl({required this.orderId});

  @override
  final String orderId;

  @override
  String toString() {
    return 'OrderStatusDlnRequestDto(orderId: $orderId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderStatusDlnRequestDtoImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orderId);

  /// Create a copy of OrderStatusDlnRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderStatusDlnRequestDtoImplCopyWith<_$OrderStatusDlnRequestDtoImpl> get copyWith =>
      __$$OrderStatusDlnRequestDtoImplCopyWithImpl<_$OrderStatusDlnRequestDtoImpl>(
        this,
        _$identity,
      );
}

abstract class _OrderStatusDlnRequestDto implements OrderStatusDlnRequestDto {
  const factory _OrderStatusDlnRequestDto({required final String orderId}) =
      _$OrderStatusDlnRequestDtoImpl;

  @override
  String get orderId;

  /// Create a copy of OrderStatusDlnRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderStatusDlnRequestDtoImplCopyWith<_$OrderStatusDlnRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$OrderStatusDlnResponseDto {
  DlnOrderStatus get status => throw _privateConstructorUsedError;

  /// Create a copy of OrderStatusDlnResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderStatusDlnResponseDtoCopyWith<OrderStatusDlnResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderStatusDlnResponseDtoCopyWith<$Res> {
  factory $OrderStatusDlnResponseDtoCopyWith(
    OrderStatusDlnResponseDto value,
    $Res Function(OrderStatusDlnResponseDto) then,
  ) = _$OrderStatusDlnResponseDtoCopyWithImpl<$Res, OrderStatusDlnResponseDto>;
  @useResult
  $Res call({DlnOrderStatus status});
}

/// @nodoc
class _$OrderStatusDlnResponseDtoCopyWithImpl<$Res, $Val extends OrderStatusDlnResponseDto>
    implements $OrderStatusDlnResponseDtoCopyWith<$Res> {
  _$OrderStatusDlnResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderStatusDlnResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null}) {
    return _then(
      _value.copyWith(
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as DlnOrderStatus,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderStatusDlnResponseDtoImplCopyWith<$Res>
    implements $OrderStatusDlnResponseDtoCopyWith<$Res> {
  factory _$$OrderStatusDlnResponseDtoImplCopyWith(
    _$OrderStatusDlnResponseDtoImpl value,
    $Res Function(_$OrderStatusDlnResponseDtoImpl) then,
  ) = __$$OrderStatusDlnResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DlnOrderStatus status});
}

/// @nodoc
class __$$OrderStatusDlnResponseDtoImplCopyWithImpl<$Res>
    extends _$OrderStatusDlnResponseDtoCopyWithImpl<$Res, _$OrderStatusDlnResponseDtoImpl>
    implements _$$OrderStatusDlnResponseDtoImplCopyWith<$Res> {
  __$$OrderStatusDlnResponseDtoImplCopyWithImpl(
    _$OrderStatusDlnResponseDtoImpl _value,
    $Res Function(_$OrderStatusDlnResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderStatusDlnResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null}) {
    return _then(
      _$OrderStatusDlnResponseDtoImpl(
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as DlnOrderStatus,
      ),
    );
  }
}

/// @nodoc

class _$OrderStatusDlnResponseDtoImpl implements _OrderStatusDlnResponseDto {
  const _$OrderStatusDlnResponseDtoImpl({required this.status});

  @override
  final DlnOrderStatus status;

  @override
  String toString() {
    return 'OrderStatusDlnResponseDto(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderStatusDlnResponseDtoImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  /// Create a copy of OrderStatusDlnResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderStatusDlnResponseDtoImplCopyWith<_$OrderStatusDlnResponseDtoImpl> get copyWith =>
      __$$OrderStatusDlnResponseDtoImplCopyWithImpl<_$OrderStatusDlnResponseDtoImpl>(
        this,
        _$identity,
      );
}

abstract class _OrderStatusDlnResponseDto implements OrderStatusDlnResponseDto {
  const factory _OrderStatusDlnResponseDto({required final DlnOrderStatus status}) =
      _$OrderStatusDlnResponseDtoImpl;

  @override
  DlnOrderStatus get status;

  /// Create a copy of OrderStatusDlnResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderStatusDlnResponseDtoImplCopyWith<_$OrderStatusDlnResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$OrderIdDlnRequestDto {
  String get txId => throw _privateConstructorUsedError;

  /// Create a copy of OrderIdDlnRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderIdDlnRequestDtoCopyWith<OrderIdDlnRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderIdDlnRequestDtoCopyWith<$Res> {
  factory $OrderIdDlnRequestDtoCopyWith(
    OrderIdDlnRequestDto value,
    $Res Function(OrderIdDlnRequestDto) then,
  ) = _$OrderIdDlnRequestDtoCopyWithImpl<$Res, OrderIdDlnRequestDto>;
  @useResult
  $Res call({String txId});
}

/// @nodoc
class _$OrderIdDlnRequestDtoCopyWithImpl<$Res, $Val extends OrderIdDlnRequestDto>
    implements $OrderIdDlnRequestDtoCopyWith<$Res> {
  _$OrderIdDlnRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderIdDlnRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? txId = null}) {
    return _then(
      _value.copyWith(
            txId:
                null == txId
                    ? _value.txId
                    : txId // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderIdDlnRequestDtoImplCopyWith<$Res>
    implements $OrderIdDlnRequestDtoCopyWith<$Res> {
  factory _$$OrderIdDlnRequestDtoImplCopyWith(
    _$OrderIdDlnRequestDtoImpl value,
    $Res Function(_$OrderIdDlnRequestDtoImpl) then,
  ) = __$$OrderIdDlnRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String txId});
}

/// @nodoc
class __$$OrderIdDlnRequestDtoImplCopyWithImpl<$Res>
    extends _$OrderIdDlnRequestDtoCopyWithImpl<$Res, _$OrderIdDlnRequestDtoImpl>
    implements _$$OrderIdDlnRequestDtoImplCopyWith<$Res> {
  __$$OrderIdDlnRequestDtoImplCopyWithImpl(
    _$OrderIdDlnRequestDtoImpl _value,
    $Res Function(_$OrderIdDlnRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderIdDlnRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? txId = null}) {
    return _then(
      _$OrderIdDlnRequestDtoImpl(
        txId:
            null == txId
                ? _value.txId
                : txId // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$OrderIdDlnRequestDtoImpl implements _OrderIdDlnRequestDto {
  const _$OrderIdDlnRequestDtoImpl({required this.txId});

  @override
  final String txId;

  @override
  String toString() {
    return 'OrderIdDlnRequestDto(txId: $txId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderIdDlnRequestDtoImpl &&
            (identical(other.txId, txId) || other.txId == txId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, txId);

  /// Create a copy of OrderIdDlnRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderIdDlnRequestDtoImplCopyWith<_$OrderIdDlnRequestDtoImpl> get copyWith =>
      __$$OrderIdDlnRequestDtoImplCopyWithImpl<_$OrderIdDlnRequestDtoImpl>(this, _$identity);
}

abstract class _OrderIdDlnRequestDto implements OrderIdDlnRequestDto {
  const factory _OrderIdDlnRequestDto({required final String txId}) = _$OrderIdDlnRequestDtoImpl;

  @override
  String get txId;

  /// Create a copy of OrderIdDlnRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderIdDlnRequestDtoImplCopyWith<_$OrderIdDlnRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$OrderIdDlnResponseDto {
  String? get orderId => throw _privateConstructorUsedError;

  /// Create a copy of OrderIdDlnResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderIdDlnResponseDtoCopyWith<OrderIdDlnResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderIdDlnResponseDtoCopyWith<$Res> {
  factory $OrderIdDlnResponseDtoCopyWith(
    OrderIdDlnResponseDto value,
    $Res Function(OrderIdDlnResponseDto) then,
  ) = _$OrderIdDlnResponseDtoCopyWithImpl<$Res, OrderIdDlnResponseDto>;
  @useResult
  $Res call({String? orderId});
}

/// @nodoc
class _$OrderIdDlnResponseDtoCopyWithImpl<$Res, $Val extends OrderIdDlnResponseDto>
    implements $OrderIdDlnResponseDtoCopyWith<$Res> {
  _$OrderIdDlnResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderIdDlnResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? orderId = freezed}) {
    return _then(
      _value.copyWith(
            orderId:
                freezed == orderId
                    ? _value.orderId
                    : orderId // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderIdDlnResponseDtoImplCopyWith<$Res>
    implements $OrderIdDlnResponseDtoCopyWith<$Res> {
  factory _$$OrderIdDlnResponseDtoImplCopyWith(
    _$OrderIdDlnResponseDtoImpl value,
    $Res Function(_$OrderIdDlnResponseDtoImpl) then,
  ) = __$$OrderIdDlnResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? orderId});
}

/// @nodoc
class __$$OrderIdDlnResponseDtoImplCopyWithImpl<$Res>
    extends _$OrderIdDlnResponseDtoCopyWithImpl<$Res, _$OrderIdDlnResponseDtoImpl>
    implements _$$OrderIdDlnResponseDtoImplCopyWith<$Res> {
  __$$OrderIdDlnResponseDtoImplCopyWithImpl(
    _$OrderIdDlnResponseDtoImpl _value,
    $Res Function(_$OrderIdDlnResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderIdDlnResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? orderId = freezed}) {
    return _then(
      _$OrderIdDlnResponseDtoImpl(
        orderId:
            freezed == orderId
                ? _value.orderId
                : orderId // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$OrderIdDlnResponseDtoImpl implements _OrderIdDlnResponseDto {
  const _$OrderIdDlnResponseDtoImpl({required this.orderId});

  @override
  final String? orderId;

  @override
  String toString() {
    return 'OrderIdDlnResponseDto(orderId: $orderId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderIdDlnResponseDtoImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orderId);

  /// Create a copy of OrderIdDlnResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderIdDlnResponseDtoImplCopyWith<_$OrderIdDlnResponseDtoImpl> get copyWith =>
      __$$OrderIdDlnResponseDtoImplCopyWithImpl<_$OrderIdDlnResponseDtoImpl>(this, _$identity);
}

abstract class _OrderIdDlnResponseDto implements OrderIdDlnResponseDto {
  const factory _OrderIdDlnResponseDto({required final String? orderId}) =
      _$OrderIdDlnResponseDtoImpl;

  @override
  String? get orderId;

  /// Create a copy of OrderIdDlnResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderIdDlnResponseDtoImplCopyWith<_$OrderIdDlnResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$IncomingQuoteRequestDto {
  int get amount => throw _privateConstructorUsedError;
  String get senderAddress => throw _privateConstructorUsedError;
  String get senderBlockchain => throw _privateConstructorUsedError;
  String get receiverAddress => throw _privateConstructorUsedError;
  String? get solanaReferenceAddress => throw _privateConstructorUsedError;

  /// Create a copy of IncomingQuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IncomingQuoteRequestDtoCopyWith<IncomingQuoteRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IncomingQuoteRequestDtoCopyWith<$Res> {
  factory $IncomingQuoteRequestDtoCopyWith(
    IncomingQuoteRequestDto value,
    $Res Function(IncomingQuoteRequestDto) then,
  ) = _$IncomingQuoteRequestDtoCopyWithImpl<$Res, IncomingQuoteRequestDto>;
  @useResult
  $Res call({
    int amount,
    String senderAddress,
    String senderBlockchain,
    String receiverAddress,
    String? solanaReferenceAddress,
  });
}

/// @nodoc
class _$IncomingQuoteRequestDtoCopyWithImpl<$Res, $Val extends IncomingQuoteRequestDto>
    implements $IncomingQuoteRequestDtoCopyWith<$Res> {
  _$IncomingQuoteRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IncomingQuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? senderAddress = null,
    Object? senderBlockchain = null,
    Object? receiverAddress = null,
    Object? solanaReferenceAddress = freezed,
  }) {
    return _then(
      _value.copyWith(
            amount:
                null == amount
                    ? _value.amount
                    : amount // ignore: cast_nullable_to_non_nullable
                        as int,
            senderAddress:
                null == senderAddress
                    ? _value.senderAddress
                    : senderAddress // ignore: cast_nullable_to_non_nullable
                        as String,
            senderBlockchain:
                null == senderBlockchain
                    ? _value.senderBlockchain
                    : senderBlockchain // ignore: cast_nullable_to_non_nullable
                        as String,
            receiverAddress:
                null == receiverAddress
                    ? _value.receiverAddress
                    : receiverAddress // ignore: cast_nullable_to_non_nullable
                        as String,
            solanaReferenceAddress:
                freezed == solanaReferenceAddress
                    ? _value.solanaReferenceAddress
                    : solanaReferenceAddress // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$IncomingQuoteRequestDtoImplCopyWith<$Res>
    implements $IncomingQuoteRequestDtoCopyWith<$Res> {
  factory _$$IncomingQuoteRequestDtoImplCopyWith(
    _$IncomingQuoteRequestDtoImpl value,
    $Res Function(_$IncomingQuoteRequestDtoImpl) then,
  ) = __$$IncomingQuoteRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int amount,
    String senderAddress,
    String senderBlockchain,
    String receiverAddress,
    String? solanaReferenceAddress,
  });
}

/// @nodoc
class __$$IncomingQuoteRequestDtoImplCopyWithImpl<$Res>
    extends _$IncomingQuoteRequestDtoCopyWithImpl<$Res, _$IncomingQuoteRequestDtoImpl>
    implements _$$IncomingQuoteRequestDtoImplCopyWith<$Res> {
  __$$IncomingQuoteRequestDtoImplCopyWithImpl(
    _$IncomingQuoteRequestDtoImpl _value,
    $Res Function(_$IncomingQuoteRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IncomingQuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? senderAddress = null,
    Object? senderBlockchain = null,
    Object? receiverAddress = null,
    Object? solanaReferenceAddress = freezed,
  }) {
    return _then(
      _$IncomingQuoteRequestDtoImpl(
        amount:
            null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                    as int,
        senderAddress:
            null == senderAddress
                ? _value.senderAddress
                : senderAddress // ignore: cast_nullable_to_non_nullable
                    as String,
        senderBlockchain:
            null == senderBlockchain
                ? _value.senderBlockchain
                : senderBlockchain // ignore: cast_nullable_to_non_nullable
                    as String,
        receiverAddress:
            null == receiverAddress
                ? _value.receiverAddress
                : receiverAddress // ignore: cast_nullable_to_non_nullable
                    as String,
        solanaReferenceAddress:
            freezed == solanaReferenceAddress
                ? _value.solanaReferenceAddress
                : solanaReferenceAddress // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$IncomingQuoteRequestDtoImpl implements _IncomingQuoteRequestDto {
  const _$IncomingQuoteRequestDtoImpl({
    required this.amount,
    required this.senderAddress,
    required this.senderBlockchain,
    required this.receiverAddress,
    required this.solanaReferenceAddress,
  });

  @override
  final int amount;
  @override
  final String senderAddress;
  @override
  final String senderBlockchain;
  @override
  final String receiverAddress;
  @override
  final String? solanaReferenceAddress;

  @override
  String toString() {
    return 'IncomingQuoteRequestDto(amount: $amount, senderAddress: $senderAddress, senderBlockchain: $senderBlockchain, receiverAddress: $receiverAddress, solanaReferenceAddress: $solanaReferenceAddress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IncomingQuoteRequestDtoImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.senderAddress, senderAddress) ||
                other.senderAddress == senderAddress) &&
            (identical(other.senderBlockchain, senderBlockchain) ||
                other.senderBlockchain == senderBlockchain) &&
            (identical(other.receiverAddress, receiverAddress) ||
                other.receiverAddress == receiverAddress) &&
            (identical(other.solanaReferenceAddress, solanaReferenceAddress) ||
                other.solanaReferenceAddress == solanaReferenceAddress));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    amount,
    senderAddress,
    senderBlockchain,
    receiverAddress,
    solanaReferenceAddress,
  );

  /// Create a copy of IncomingQuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IncomingQuoteRequestDtoImplCopyWith<_$IncomingQuoteRequestDtoImpl> get copyWith =>
      __$$IncomingQuoteRequestDtoImplCopyWithImpl<_$IncomingQuoteRequestDtoImpl>(this, _$identity);
}

abstract class _IncomingQuoteRequestDto implements IncomingQuoteRequestDto {
  const factory _IncomingQuoteRequestDto({
    required final int amount,
    required final String senderAddress,
    required final String senderBlockchain,
    required final String receiverAddress,
    required final String? solanaReferenceAddress,
  }) = _$IncomingQuoteRequestDtoImpl;

  @override
  int get amount;
  @override
  String get senderAddress;
  @override
  String get senderBlockchain;
  @override
  String get receiverAddress;
  @override
  String? get solanaReferenceAddress;

  /// Create a copy of IncomingQuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IncomingQuoteRequestDtoImplCopyWith<_$IncomingQuoteRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$IncomingQuoteResponseDto {
  QuoteTx get tx => throw _privateConstructorUsedError;
  QuoteUsdcInfo get usdcInfo => throw _privateConstructorUsedError;
  int get inputAmount => throw _privateConstructorUsedError;
  int get receiverAmount => throw _privateConstructorUsedError;
  int get feeInUsdc => throw _privateConstructorUsedError;

  /// Create a copy of IncomingQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IncomingQuoteResponseDtoCopyWith<IncomingQuoteResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IncomingQuoteResponseDtoCopyWith<$Res> {
  factory $IncomingQuoteResponseDtoCopyWith(
    IncomingQuoteResponseDto value,
    $Res Function(IncomingQuoteResponseDto) then,
  ) = _$IncomingQuoteResponseDtoCopyWithImpl<$Res, IncomingQuoteResponseDto>;
  @useResult
  $Res call({
    QuoteTx tx,
    QuoteUsdcInfo usdcInfo,
    int inputAmount,
    int receiverAmount,
    int feeInUsdc,
  });

  $QuoteTxCopyWith<$Res> get tx;
  $QuoteUsdcInfoCopyWith<$Res> get usdcInfo;
}

/// @nodoc
class _$IncomingQuoteResponseDtoCopyWithImpl<$Res, $Val extends IncomingQuoteResponseDto>
    implements $IncomingQuoteResponseDtoCopyWith<$Res> {
  _$IncomingQuoteResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IncomingQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tx = null,
    Object? usdcInfo = null,
    Object? inputAmount = null,
    Object? receiverAmount = null,
    Object? feeInUsdc = null,
  }) {
    return _then(
      _value.copyWith(
            tx:
                null == tx
                    ? _value.tx
                    : tx // ignore: cast_nullable_to_non_nullable
                        as QuoteTx,
            usdcInfo:
                null == usdcInfo
                    ? _value.usdcInfo
                    : usdcInfo // ignore: cast_nullable_to_non_nullable
                        as QuoteUsdcInfo,
            inputAmount:
                null == inputAmount
                    ? _value.inputAmount
                    : inputAmount // ignore: cast_nullable_to_non_nullable
                        as int,
            receiverAmount:
                null == receiverAmount
                    ? _value.receiverAmount
                    : receiverAmount // ignore: cast_nullable_to_non_nullable
                        as int,
            feeInUsdc:
                null == feeInUsdc
                    ? _value.feeInUsdc
                    : feeInUsdc // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }

  /// Create a copy of IncomingQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QuoteTxCopyWith<$Res> get tx {
    return $QuoteTxCopyWith<$Res>(_value.tx, (value) {
      return _then(_value.copyWith(tx: value) as $Val);
    });
  }

  /// Create a copy of IncomingQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QuoteUsdcInfoCopyWith<$Res> get usdcInfo {
    return $QuoteUsdcInfoCopyWith<$Res>(_value.usdcInfo, (value) {
      return _then(_value.copyWith(usdcInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$IncomingQuoteResponseDtoImplCopyWith<$Res>
    implements $IncomingQuoteResponseDtoCopyWith<$Res> {
  factory _$$IncomingQuoteResponseDtoImplCopyWith(
    _$IncomingQuoteResponseDtoImpl value,
    $Res Function(_$IncomingQuoteResponseDtoImpl) then,
  ) = __$$IncomingQuoteResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    QuoteTx tx,
    QuoteUsdcInfo usdcInfo,
    int inputAmount,
    int receiverAmount,
    int feeInUsdc,
  });

  @override
  $QuoteTxCopyWith<$Res> get tx;
  @override
  $QuoteUsdcInfoCopyWith<$Res> get usdcInfo;
}

/// @nodoc
class __$$IncomingQuoteResponseDtoImplCopyWithImpl<$Res>
    extends _$IncomingQuoteResponseDtoCopyWithImpl<$Res, _$IncomingQuoteResponseDtoImpl>
    implements _$$IncomingQuoteResponseDtoImplCopyWith<$Res> {
  __$$IncomingQuoteResponseDtoImplCopyWithImpl(
    _$IncomingQuoteResponseDtoImpl _value,
    $Res Function(_$IncomingQuoteResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IncomingQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tx = null,
    Object? usdcInfo = null,
    Object? inputAmount = null,
    Object? receiverAmount = null,
    Object? feeInUsdc = null,
  }) {
    return _then(
      _$IncomingQuoteResponseDtoImpl(
        tx:
            null == tx
                ? _value.tx
                : tx // ignore: cast_nullable_to_non_nullable
                    as QuoteTx,
        usdcInfo:
            null == usdcInfo
                ? _value.usdcInfo
                : usdcInfo // ignore: cast_nullable_to_non_nullable
                    as QuoteUsdcInfo,
        inputAmount:
            null == inputAmount
                ? _value.inputAmount
                : inputAmount // ignore: cast_nullable_to_non_nullable
                    as int,
        receiverAmount:
            null == receiverAmount
                ? _value.receiverAmount
                : receiverAmount // ignore: cast_nullable_to_non_nullable
                    as int,
        feeInUsdc:
            null == feeInUsdc
                ? _value.feeInUsdc
                : feeInUsdc // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _$IncomingQuoteResponseDtoImpl implements _IncomingQuoteResponseDto {
  const _$IncomingQuoteResponseDtoImpl({
    required this.tx,
    required this.usdcInfo,
    required this.inputAmount,
    required this.receiverAmount,
    required this.feeInUsdc,
  });

  @override
  final QuoteTx tx;
  @override
  final QuoteUsdcInfo usdcInfo;
  @override
  final int inputAmount;
  @override
  final int receiverAmount;
  @override
  final int feeInUsdc;

  @override
  String toString() {
    return 'IncomingQuoteResponseDto(tx: $tx, usdcInfo: $usdcInfo, inputAmount: $inputAmount, receiverAmount: $receiverAmount, feeInUsdc: $feeInUsdc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IncomingQuoteResponseDtoImpl &&
            (identical(other.tx, tx) || other.tx == tx) &&
            (identical(other.usdcInfo, usdcInfo) || other.usdcInfo == usdcInfo) &&
            (identical(other.inputAmount, inputAmount) || other.inputAmount == inputAmount) &&
            (identical(other.receiverAmount, receiverAmount) ||
                other.receiverAmount == receiverAmount) &&
            (identical(other.feeInUsdc, feeInUsdc) || other.feeInUsdc == feeInUsdc));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, tx, usdcInfo, inputAmount, receiverAmount, feeInUsdc);

  /// Create a copy of IncomingQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IncomingQuoteResponseDtoImplCopyWith<_$IncomingQuoteResponseDtoImpl> get copyWith =>
      __$$IncomingQuoteResponseDtoImplCopyWithImpl<_$IncomingQuoteResponseDtoImpl>(
        this,
        _$identity,
      );
}

abstract class _IncomingQuoteResponseDto implements IncomingQuoteResponseDto {
  const factory _IncomingQuoteResponseDto({
    required final QuoteTx tx,
    required final QuoteUsdcInfo usdcInfo,
    required final int inputAmount,
    required final int receiverAmount,
    required final int feeInUsdc,
  }) = _$IncomingQuoteResponseDtoImpl;

  @override
  QuoteTx get tx;
  @override
  QuoteUsdcInfo get usdcInfo;
  @override
  int get inputAmount;
  @override
  int get receiverAmount;
  @override
  int get feeInUsdc;

  /// Create a copy of IncomingQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IncomingQuoteResponseDtoImplCopyWith<_$IncomingQuoteResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$QuoteTx {
  String get to => throw _privateConstructorUsedError;
  String get data => throw _privateConstructorUsedError;
  int get value => throw _privateConstructorUsedError;

  /// Create a copy of QuoteTx
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuoteTxCopyWith<QuoteTx> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuoteTxCopyWith<$Res> {
  factory $QuoteTxCopyWith(QuoteTx value, $Res Function(QuoteTx) then) =
      _$QuoteTxCopyWithImpl<$Res, QuoteTx>;
  @useResult
  $Res call({String to, String data, int value});
}

/// @nodoc
class _$QuoteTxCopyWithImpl<$Res, $Val extends QuoteTx> implements $QuoteTxCopyWith<$Res> {
  _$QuoteTxCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuoteTx
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? to = null, Object? data = null, Object? value = null}) {
    return _then(
      _value.copyWith(
            to:
                null == to
                    ? _value.to
                    : to // ignore: cast_nullable_to_non_nullable
                        as String,
            data:
                null == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as String,
            value:
                null == value
                    ? _value.value
                    : value // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuoteTxImplCopyWith<$Res> implements $QuoteTxCopyWith<$Res> {
  factory _$$QuoteTxImplCopyWith(_$QuoteTxImpl value, $Res Function(_$QuoteTxImpl) then) =
      __$$QuoteTxImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String to, String data, int value});
}

/// @nodoc
class __$$QuoteTxImplCopyWithImpl<$Res> extends _$QuoteTxCopyWithImpl<$Res, _$QuoteTxImpl>
    implements _$$QuoteTxImplCopyWith<$Res> {
  __$$QuoteTxImplCopyWithImpl(_$QuoteTxImpl _value, $Res Function(_$QuoteTxImpl) _then)
    : super(_value, _then);

  /// Create a copy of QuoteTx
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? to = null, Object? data = null, Object? value = null}) {
    return _then(
      _$QuoteTxImpl(
        to:
            null == to
                ? _value.to
                : to // ignore: cast_nullable_to_non_nullable
                    as String,
        data:
            null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                    as String,
        value:
            null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _$QuoteTxImpl implements _QuoteTx {
  const _$QuoteTxImpl({required this.to, required this.data, required this.value});

  @override
  final String to;
  @override
  final String data;
  @override
  final int value;

  @override
  String toString() {
    return 'QuoteTx(to: $to, data: $data, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuoteTxImpl &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, to, data, value);

  /// Create a copy of QuoteTx
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuoteTxImplCopyWith<_$QuoteTxImpl> get copyWith =>
      __$$QuoteTxImplCopyWithImpl<_$QuoteTxImpl>(this, _$identity);
}

abstract class _QuoteTx implements QuoteTx {
  const factory _QuoteTx({
    required final String to,
    required final String data,
    required final int value,
  }) = _$QuoteTxImpl;

  @override
  String get to;
  @override
  String get data;
  @override
  int get value;

  /// Create a copy of QuoteTx
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuoteTxImplCopyWith<_$QuoteTxImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$QuoteUsdcInfo {
  String get usdcAddress => throw _privateConstructorUsedError;
  int get approvalAmount => throw _privateConstructorUsedError;

  /// Create a copy of QuoteUsdcInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuoteUsdcInfoCopyWith<QuoteUsdcInfo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuoteUsdcInfoCopyWith<$Res> {
  factory $QuoteUsdcInfoCopyWith(QuoteUsdcInfo value, $Res Function(QuoteUsdcInfo) then) =
      _$QuoteUsdcInfoCopyWithImpl<$Res, QuoteUsdcInfo>;
  @useResult
  $Res call({String usdcAddress, int approvalAmount});
}

/// @nodoc
class _$QuoteUsdcInfoCopyWithImpl<$Res, $Val extends QuoteUsdcInfo>
    implements $QuoteUsdcInfoCopyWith<$Res> {
  _$QuoteUsdcInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuoteUsdcInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? usdcAddress = null, Object? approvalAmount = null}) {
    return _then(
      _value.copyWith(
            usdcAddress:
                null == usdcAddress
                    ? _value.usdcAddress
                    : usdcAddress // ignore: cast_nullable_to_non_nullable
                        as String,
            approvalAmount:
                null == approvalAmount
                    ? _value.approvalAmount
                    : approvalAmount // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuoteUsdcInfoImplCopyWith<$Res> implements $QuoteUsdcInfoCopyWith<$Res> {
  factory _$$QuoteUsdcInfoImplCopyWith(
    _$QuoteUsdcInfoImpl value,
    $Res Function(_$QuoteUsdcInfoImpl) then,
  ) = __$$QuoteUsdcInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String usdcAddress, int approvalAmount});
}

/// @nodoc
class __$$QuoteUsdcInfoImplCopyWithImpl<$Res>
    extends _$QuoteUsdcInfoCopyWithImpl<$Res, _$QuoteUsdcInfoImpl>
    implements _$$QuoteUsdcInfoImplCopyWith<$Res> {
  __$$QuoteUsdcInfoImplCopyWithImpl(
    _$QuoteUsdcInfoImpl _value,
    $Res Function(_$QuoteUsdcInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuoteUsdcInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? usdcAddress = null, Object? approvalAmount = null}) {
    return _then(
      _$QuoteUsdcInfoImpl(
        usdcAddress:
            null == usdcAddress
                ? _value.usdcAddress
                : usdcAddress // ignore: cast_nullable_to_non_nullable
                    as String,
        approvalAmount:
            null == approvalAmount
                ? _value.approvalAmount
                : approvalAmount // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _$QuoteUsdcInfoImpl implements _QuoteUsdcInfo {
  const _$QuoteUsdcInfoImpl({required this.usdcAddress, required this.approvalAmount});

  @override
  final String usdcAddress;
  @override
  final int approvalAmount;

  @override
  String toString() {
    return 'QuoteUsdcInfo(usdcAddress: $usdcAddress, approvalAmount: $approvalAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuoteUsdcInfoImpl &&
            (identical(other.usdcAddress, usdcAddress) || other.usdcAddress == usdcAddress) &&
            (identical(other.approvalAmount, approvalAmount) ||
                other.approvalAmount == approvalAmount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, usdcAddress, approvalAmount);

  /// Create a copy of QuoteUsdcInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuoteUsdcInfoImplCopyWith<_$QuoteUsdcInfoImpl> get copyWith =>
      __$$QuoteUsdcInfoImplCopyWithImpl<_$QuoteUsdcInfoImpl>(this, _$identity);
}

abstract class _QuoteUsdcInfo implements QuoteUsdcInfo {
  const factory _QuoteUsdcInfo({
    required final String usdcAddress,
    required final int approvalAmount,
  }) = _$QuoteUsdcInfoImpl;

  @override
  String get usdcAddress;
  @override
  int get approvalAmount;

  /// Create a copy of QuoteUsdcInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuoteUsdcInfoImplCopyWith<_$QuoteUsdcInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
