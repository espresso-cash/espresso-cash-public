// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dln_payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OutgoingQuoteRequestDto {
  int get amount;
  String get receiverAddress;
  String get receiverBlockchain;

  /// Create a copy of OutgoingQuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OutgoingQuoteRequestDtoCopyWith<OutgoingQuoteRequestDto> get copyWith =>
      _$OutgoingQuoteRequestDtoCopyWithImpl<OutgoingQuoteRequestDto>(
        this as OutgoingQuoteRequestDto,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OutgoingQuoteRequestDto &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.receiverAddress, receiverAddress) ||
                other.receiverAddress == receiverAddress) &&
            (identical(other.receiverBlockchain, receiverBlockchain) ||
                other.receiverBlockchain == receiverBlockchain));
  }

  @override
  int get hashCode => Object.hash(runtimeType, amount, receiverAddress, receiverBlockchain);

  @override
  String toString() {
    return 'OutgoingQuoteRequestDto(amount: $amount, receiverAddress: $receiverAddress, receiverBlockchain: $receiverBlockchain)';
  }
}

/// @nodoc
abstract mixin class $OutgoingQuoteRequestDtoCopyWith<$Res> {
  factory $OutgoingQuoteRequestDtoCopyWith(
    OutgoingQuoteRequestDto value,
    $Res Function(OutgoingQuoteRequestDto) _then,
  ) = _$OutgoingQuoteRequestDtoCopyWithImpl;
  @useResult
  $Res call({int amount, String receiverAddress, String receiverBlockchain});
}

/// @nodoc
class _$OutgoingQuoteRequestDtoCopyWithImpl<$Res>
    implements $OutgoingQuoteRequestDtoCopyWith<$Res> {
  _$OutgoingQuoteRequestDtoCopyWithImpl(this._self, this._then);

  final OutgoingQuoteRequestDto _self;
  final $Res Function(OutgoingQuoteRequestDto) _then;

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
      _self.copyWith(
        amount:
            null == amount
                ? _self.amount
                : amount // ignore: cast_nullable_to_non_nullable
                    as int,
        receiverAddress:
            null == receiverAddress
                ? _self.receiverAddress
                : receiverAddress // ignore: cast_nullable_to_non_nullable
                    as String,
        receiverBlockchain:
            null == receiverBlockchain
                ? _self.receiverBlockchain
                : receiverBlockchain // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _OutgoingQuoteRequestDto implements OutgoingQuoteRequestDto {
  const _OutgoingQuoteRequestDto({
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

  /// Create a copy of OutgoingQuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OutgoingQuoteRequestDtoCopyWith<_OutgoingQuoteRequestDto> get copyWith =>
      __$OutgoingQuoteRequestDtoCopyWithImpl<_OutgoingQuoteRequestDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OutgoingQuoteRequestDto &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.receiverAddress, receiverAddress) ||
                other.receiverAddress == receiverAddress) &&
            (identical(other.receiverBlockchain, receiverBlockchain) ||
                other.receiverBlockchain == receiverBlockchain));
  }

  @override
  int get hashCode => Object.hash(runtimeType, amount, receiverAddress, receiverBlockchain);

  @override
  String toString() {
    return 'OutgoingQuoteRequestDto(amount: $amount, receiverAddress: $receiverAddress, receiverBlockchain: $receiverBlockchain)';
  }
}

/// @nodoc
abstract mixin class _$OutgoingQuoteRequestDtoCopyWith<$Res>
    implements $OutgoingQuoteRequestDtoCopyWith<$Res> {
  factory _$OutgoingQuoteRequestDtoCopyWith(
    _OutgoingQuoteRequestDto value,
    $Res Function(_OutgoingQuoteRequestDto) _then,
  ) = __$OutgoingQuoteRequestDtoCopyWithImpl;
  @override
  @useResult
  $Res call({int amount, String receiverAddress, String receiverBlockchain});
}

/// @nodoc
class __$OutgoingQuoteRequestDtoCopyWithImpl<$Res>
    implements _$OutgoingQuoteRequestDtoCopyWith<$Res> {
  __$OutgoingQuoteRequestDtoCopyWithImpl(this._self, this._then);

  final _OutgoingQuoteRequestDto _self;
  final $Res Function(_OutgoingQuoteRequestDto) _then;

  /// Create a copy of OutgoingQuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? amount = null,
    Object? receiverAddress = null,
    Object? receiverBlockchain = null,
  }) {
    return _then(
      _OutgoingQuoteRequestDto(
        amount:
            null == amount
                ? _self.amount
                : amount // ignore: cast_nullable_to_non_nullable
                    as int,
        receiverAddress:
            null == receiverAddress
                ? _self.receiverAddress
                : receiverAddress // ignore: cast_nullable_to_non_nullable
                    as String,
        receiverBlockchain:
            null == receiverBlockchain
                ? _self.receiverBlockchain
                : receiverBlockchain // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
mixin _$OutgoingQuoteResponseDto {
  int get inputAmount;
  int get receiverAmount;
  String get encodedTx;
  int get feeInUsdc;
  BigInt get slot;

  /// Create a copy of OutgoingQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OutgoingQuoteResponseDtoCopyWith<OutgoingQuoteResponseDto> get copyWith =>
      _$OutgoingQuoteResponseDtoCopyWithImpl<OutgoingQuoteResponseDto>(
        this as OutgoingQuoteResponseDto,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OutgoingQuoteResponseDto &&
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

  @override
  String toString() {
    return 'OutgoingQuoteResponseDto(inputAmount: $inputAmount, receiverAmount: $receiverAmount, encodedTx: $encodedTx, feeInUsdc: $feeInUsdc, slot: $slot)';
  }
}

/// @nodoc
abstract mixin class $OutgoingQuoteResponseDtoCopyWith<$Res> {
  factory $OutgoingQuoteResponseDtoCopyWith(
    OutgoingQuoteResponseDto value,
    $Res Function(OutgoingQuoteResponseDto) _then,
  ) = _$OutgoingQuoteResponseDtoCopyWithImpl;
  @useResult
  $Res call({int inputAmount, int receiverAmount, String encodedTx, int feeInUsdc, BigInt slot});
}

/// @nodoc
class _$OutgoingQuoteResponseDtoCopyWithImpl<$Res>
    implements $OutgoingQuoteResponseDtoCopyWith<$Res> {
  _$OutgoingQuoteResponseDtoCopyWithImpl(this._self, this._then);

  final OutgoingQuoteResponseDto _self;
  final $Res Function(OutgoingQuoteResponseDto) _then;

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
      _self.copyWith(
        inputAmount:
            null == inputAmount
                ? _self.inputAmount
                : inputAmount // ignore: cast_nullable_to_non_nullable
                    as int,
        receiverAmount:
            null == receiverAmount
                ? _self.receiverAmount
                : receiverAmount // ignore: cast_nullable_to_non_nullable
                    as int,
        encodedTx:
            null == encodedTx
                ? _self.encodedTx
                : encodedTx // ignore: cast_nullable_to_non_nullable
                    as String,
        feeInUsdc:
            null == feeInUsdc
                ? _self.feeInUsdc
                : feeInUsdc // ignore: cast_nullable_to_non_nullable
                    as int,
        slot:
            null == slot
                ? _self.slot
                : slot // ignore: cast_nullable_to_non_nullable
                    as BigInt,
      ),
    );
  }
}

/// @nodoc

class _OutgoingQuoteResponseDto implements OutgoingQuoteResponseDto {
  const _OutgoingQuoteResponseDto({
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

  /// Create a copy of OutgoingQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OutgoingQuoteResponseDtoCopyWith<_OutgoingQuoteResponseDto> get copyWith =>
      __$OutgoingQuoteResponseDtoCopyWithImpl<_OutgoingQuoteResponseDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OutgoingQuoteResponseDto &&
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

  @override
  String toString() {
    return 'OutgoingQuoteResponseDto(inputAmount: $inputAmount, receiverAmount: $receiverAmount, encodedTx: $encodedTx, feeInUsdc: $feeInUsdc, slot: $slot)';
  }
}

/// @nodoc
abstract mixin class _$OutgoingQuoteResponseDtoCopyWith<$Res>
    implements $OutgoingQuoteResponseDtoCopyWith<$Res> {
  factory _$OutgoingQuoteResponseDtoCopyWith(
    _OutgoingQuoteResponseDto value,
    $Res Function(_OutgoingQuoteResponseDto) _then,
  ) = __$OutgoingQuoteResponseDtoCopyWithImpl;
  @override
  @useResult
  $Res call({int inputAmount, int receiverAmount, String encodedTx, int feeInUsdc, BigInt slot});
}

/// @nodoc
class __$OutgoingQuoteResponseDtoCopyWithImpl<$Res>
    implements _$OutgoingQuoteResponseDtoCopyWith<$Res> {
  __$OutgoingQuoteResponseDtoCopyWithImpl(this._self, this._then);

  final _OutgoingQuoteResponseDto _self;
  final $Res Function(_OutgoingQuoteResponseDto) _then;

  /// Create a copy of OutgoingQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? inputAmount = null,
    Object? receiverAmount = null,
    Object? encodedTx = null,
    Object? feeInUsdc = null,
    Object? slot = null,
  }) {
    return _then(
      _OutgoingQuoteResponseDto(
        inputAmount:
            null == inputAmount
                ? _self.inputAmount
                : inputAmount // ignore: cast_nullable_to_non_nullable
                    as int,
        receiverAmount:
            null == receiverAmount
                ? _self.receiverAmount
                : receiverAmount // ignore: cast_nullable_to_non_nullable
                    as int,
        encodedTx:
            null == encodedTx
                ? _self.encodedTx
                : encodedTx // ignore: cast_nullable_to_non_nullable
                    as String,
        feeInUsdc:
            null == feeInUsdc
                ? _self.feeInUsdc
                : feeInUsdc // ignore: cast_nullable_to_non_nullable
                    as int,
        slot:
            null == slot
                ? _self.slot
                : slot // ignore: cast_nullable_to_non_nullable
                    as BigInt,
      ),
    );
  }
}

/// @nodoc
mixin _$OrderStatusDlnRequestDto {
  String get orderId;

  /// Create a copy of OrderStatusDlnRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OrderStatusDlnRequestDtoCopyWith<OrderStatusDlnRequestDto> get copyWith =>
      _$OrderStatusDlnRequestDtoCopyWithImpl<OrderStatusDlnRequestDto>(
        this as OrderStatusDlnRequestDto,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OrderStatusDlnRequestDto &&
            (identical(other.orderId, orderId) || other.orderId == orderId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orderId);

  @override
  String toString() {
    return 'OrderStatusDlnRequestDto(orderId: $orderId)';
  }
}

/// @nodoc
abstract mixin class $OrderStatusDlnRequestDtoCopyWith<$Res> {
  factory $OrderStatusDlnRequestDtoCopyWith(
    OrderStatusDlnRequestDto value,
    $Res Function(OrderStatusDlnRequestDto) _then,
  ) = _$OrderStatusDlnRequestDtoCopyWithImpl;
  @useResult
  $Res call({String orderId});
}

/// @nodoc
class _$OrderStatusDlnRequestDtoCopyWithImpl<$Res>
    implements $OrderStatusDlnRequestDtoCopyWith<$Res> {
  _$OrderStatusDlnRequestDtoCopyWithImpl(this._self, this._then);

  final OrderStatusDlnRequestDto _self;
  final $Res Function(OrderStatusDlnRequestDto) _then;

  /// Create a copy of OrderStatusDlnRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? orderId = null}) {
    return _then(
      _self.copyWith(
        orderId:
            null == orderId
                ? _self.orderId
                : orderId // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _OrderStatusDlnRequestDto implements OrderStatusDlnRequestDto {
  const _OrderStatusDlnRequestDto({required this.orderId});

  @override
  final String orderId;

  /// Create a copy of OrderStatusDlnRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OrderStatusDlnRequestDtoCopyWith<_OrderStatusDlnRequestDto> get copyWith =>
      __$OrderStatusDlnRequestDtoCopyWithImpl<_OrderStatusDlnRequestDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OrderStatusDlnRequestDto &&
            (identical(other.orderId, orderId) || other.orderId == orderId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orderId);

  @override
  String toString() {
    return 'OrderStatusDlnRequestDto(orderId: $orderId)';
  }
}

/// @nodoc
abstract mixin class _$OrderStatusDlnRequestDtoCopyWith<$Res>
    implements $OrderStatusDlnRequestDtoCopyWith<$Res> {
  factory _$OrderStatusDlnRequestDtoCopyWith(
    _OrderStatusDlnRequestDto value,
    $Res Function(_OrderStatusDlnRequestDto) _then,
  ) = __$OrderStatusDlnRequestDtoCopyWithImpl;
  @override
  @useResult
  $Res call({String orderId});
}

/// @nodoc
class __$OrderStatusDlnRequestDtoCopyWithImpl<$Res>
    implements _$OrderStatusDlnRequestDtoCopyWith<$Res> {
  __$OrderStatusDlnRequestDtoCopyWithImpl(this._self, this._then);

  final _OrderStatusDlnRequestDto _self;
  final $Res Function(_OrderStatusDlnRequestDto) _then;

  /// Create a copy of OrderStatusDlnRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? orderId = null}) {
    return _then(
      _OrderStatusDlnRequestDto(
        orderId:
            null == orderId
                ? _self.orderId
                : orderId // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
mixin _$OrderStatusDlnResponseDto {
  DlnOrderStatus get status;

  /// Create a copy of OrderStatusDlnResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OrderStatusDlnResponseDtoCopyWith<OrderStatusDlnResponseDto> get copyWith =>
      _$OrderStatusDlnResponseDtoCopyWithImpl<OrderStatusDlnResponseDto>(
        this as OrderStatusDlnResponseDto,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OrderStatusDlnResponseDto &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  @override
  String toString() {
    return 'OrderStatusDlnResponseDto(status: $status)';
  }
}

/// @nodoc
abstract mixin class $OrderStatusDlnResponseDtoCopyWith<$Res> {
  factory $OrderStatusDlnResponseDtoCopyWith(
    OrderStatusDlnResponseDto value,
    $Res Function(OrderStatusDlnResponseDto) _then,
  ) = _$OrderStatusDlnResponseDtoCopyWithImpl;
  @useResult
  $Res call({DlnOrderStatus status});
}

/// @nodoc
class _$OrderStatusDlnResponseDtoCopyWithImpl<$Res>
    implements $OrderStatusDlnResponseDtoCopyWith<$Res> {
  _$OrderStatusDlnResponseDtoCopyWithImpl(this._self, this._then);

  final OrderStatusDlnResponseDto _self;
  final $Res Function(OrderStatusDlnResponseDto) _then;

  /// Create a copy of OrderStatusDlnResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null}) {
    return _then(
      _self.copyWith(
        status:
            null == status
                ? _self.status
                : status // ignore: cast_nullable_to_non_nullable
                    as DlnOrderStatus,
      ),
    );
  }
}

/// @nodoc

class _OrderStatusDlnResponseDto implements OrderStatusDlnResponseDto {
  const _OrderStatusDlnResponseDto({required this.status});

  @override
  final DlnOrderStatus status;

  /// Create a copy of OrderStatusDlnResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OrderStatusDlnResponseDtoCopyWith<_OrderStatusDlnResponseDto> get copyWith =>
      __$OrderStatusDlnResponseDtoCopyWithImpl<_OrderStatusDlnResponseDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OrderStatusDlnResponseDto &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  @override
  String toString() {
    return 'OrderStatusDlnResponseDto(status: $status)';
  }
}

/// @nodoc
abstract mixin class _$OrderStatusDlnResponseDtoCopyWith<$Res>
    implements $OrderStatusDlnResponseDtoCopyWith<$Res> {
  factory _$OrderStatusDlnResponseDtoCopyWith(
    _OrderStatusDlnResponseDto value,
    $Res Function(_OrderStatusDlnResponseDto) _then,
  ) = __$OrderStatusDlnResponseDtoCopyWithImpl;
  @override
  @useResult
  $Res call({DlnOrderStatus status});
}

/// @nodoc
class __$OrderStatusDlnResponseDtoCopyWithImpl<$Res>
    implements _$OrderStatusDlnResponseDtoCopyWith<$Res> {
  __$OrderStatusDlnResponseDtoCopyWithImpl(this._self, this._then);

  final _OrderStatusDlnResponseDto _self;
  final $Res Function(_OrderStatusDlnResponseDto) _then;

  /// Create a copy of OrderStatusDlnResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? status = null}) {
    return _then(
      _OrderStatusDlnResponseDto(
        status:
            null == status
                ? _self.status
                : status // ignore: cast_nullable_to_non_nullable
                    as DlnOrderStatus,
      ),
    );
  }
}

/// @nodoc
mixin _$OrderIdDlnRequestDto {
  String get txId;

  /// Create a copy of OrderIdDlnRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OrderIdDlnRequestDtoCopyWith<OrderIdDlnRequestDto> get copyWith =>
      _$OrderIdDlnRequestDtoCopyWithImpl<OrderIdDlnRequestDto>(
        this as OrderIdDlnRequestDto,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OrderIdDlnRequestDto &&
            (identical(other.txId, txId) || other.txId == txId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, txId);

  @override
  String toString() {
    return 'OrderIdDlnRequestDto(txId: $txId)';
  }
}

/// @nodoc
abstract mixin class $OrderIdDlnRequestDtoCopyWith<$Res> {
  factory $OrderIdDlnRequestDtoCopyWith(
    OrderIdDlnRequestDto value,
    $Res Function(OrderIdDlnRequestDto) _then,
  ) = _$OrderIdDlnRequestDtoCopyWithImpl;
  @useResult
  $Res call({String txId});
}

/// @nodoc
class _$OrderIdDlnRequestDtoCopyWithImpl<$Res> implements $OrderIdDlnRequestDtoCopyWith<$Res> {
  _$OrderIdDlnRequestDtoCopyWithImpl(this._self, this._then);

  final OrderIdDlnRequestDto _self;
  final $Res Function(OrderIdDlnRequestDto) _then;

  /// Create a copy of OrderIdDlnRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? txId = null}) {
    return _then(
      _self.copyWith(
        txId:
            null == txId
                ? _self.txId
                : txId // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _OrderIdDlnRequestDto implements OrderIdDlnRequestDto {
  const _OrderIdDlnRequestDto({required this.txId});

  @override
  final String txId;

  /// Create a copy of OrderIdDlnRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OrderIdDlnRequestDtoCopyWith<_OrderIdDlnRequestDto> get copyWith =>
      __$OrderIdDlnRequestDtoCopyWithImpl<_OrderIdDlnRequestDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OrderIdDlnRequestDto &&
            (identical(other.txId, txId) || other.txId == txId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, txId);

  @override
  String toString() {
    return 'OrderIdDlnRequestDto(txId: $txId)';
  }
}

/// @nodoc
abstract mixin class _$OrderIdDlnRequestDtoCopyWith<$Res>
    implements $OrderIdDlnRequestDtoCopyWith<$Res> {
  factory _$OrderIdDlnRequestDtoCopyWith(
    _OrderIdDlnRequestDto value,
    $Res Function(_OrderIdDlnRequestDto) _then,
  ) = __$OrderIdDlnRequestDtoCopyWithImpl;
  @override
  @useResult
  $Res call({String txId});
}

/// @nodoc
class __$OrderIdDlnRequestDtoCopyWithImpl<$Res> implements _$OrderIdDlnRequestDtoCopyWith<$Res> {
  __$OrderIdDlnRequestDtoCopyWithImpl(this._self, this._then);

  final _OrderIdDlnRequestDto _self;
  final $Res Function(_OrderIdDlnRequestDto) _then;

  /// Create a copy of OrderIdDlnRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? txId = null}) {
    return _then(
      _OrderIdDlnRequestDto(
        txId:
            null == txId
                ? _self.txId
                : txId // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
mixin _$OrderIdDlnResponseDto {
  String? get orderId;

  /// Create a copy of OrderIdDlnResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OrderIdDlnResponseDtoCopyWith<OrderIdDlnResponseDto> get copyWith =>
      _$OrderIdDlnResponseDtoCopyWithImpl<OrderIdDlnResponseDto>(
        this as OrderIdDlnResponseDto,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OrderIdDlnResponseDto &&
            (identical(other.orderId, orderId) || other.orderId == orderId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orderId);

  @override
  String toString() {
    return 'OrderIdDlnResponseDto(orderId: $orderId)';
  }
}

/// @nodoc
abstract mixin class $OrderIdDlnResponseDtoCopyWith<$Res> {
  factory $OrderIdDlnResponseDtoCopyWith(
    OrderIdDlnResponseDto value,
    $Res Function(OrderIdDlnResponseDto) _then,
  ) = _$OrderIdDlnResponseDtoCopyWithImpl;
  @useResult
  $Res call({String? orderId});
}

/// @nodoc
class _$OrderIdDlnResponseDtoCopyWithImpl<$Res> implements $OrderIdDlnResponseDtoCopyWith<$Res> {
  _$OrderIdDlnResponseDtoCopyWithImpl(this._self, this._then);

  final OrderIdDlnResponseDto _self;
  final $Res Function(OrderIdDlnResponseDto) _then;

  /// Create a copy of OrderIdDlnResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? orderId = freezed}) {
    return _then(
      _self.copyWith(
        orderId:
            freezed == orderId
                ? _self.orderId
                : orderId // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _OrderIdDlnResponseDto implements OrderIdDlnResponseDto {
  const _OrderIdDlnResponseDto({required this.orderId});

  @override
  final String? orderId;

  /// Create a copy of OrderIdDlnResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OrderIdDlnResponseDtoCopyWith<_OrderIdDlnResponseDto> get copyWith =>
      __$OrderIdDlnResponseDtoCopyWithImpl<_OrderIdDlnResponseDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OrderIdDlnResponseDto &&
            (identical(other.orderId, orderId) || other.orderId == orderId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orderId);

  @override
  String toString() {
    return 'OrderIdDlnResponseDto(orderId: $orderId)';
  }
}

/// @nodoc
abstract mixin class _$OrderIdDlnResponseDtoCopyWith<$Res>
    implements $OrderIdDlnResponseDtoCopyWith<$Res> {
  factory _$OrderIdDlnResponseDtoCopyWith(
    _OrderIdDlnResponseDto value,
    $Res Function(_OrderIdDlnResponseDto) _then,
  ) = __$OrderIdDlnResponseDtoCopyWithImpl;
  @override
  @useResult
  $Res call({String? orderId});
}

/// @nodoc
class __$OrderIdDlnResponseDtoCopyWithImpl<$Res> implements _$OrderIdDlnResponseDtoCopyWith<$Res> {
  __$OrderIdDlnResponseDtoCopyWithImpl(this._self, this._then);

  final _OrderIdDlnResponseDto _self;
  final $Res Function(_OrderIdDlnResponseDto) _then;

  /// Create a copy of OrderIdDlnResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? orderId = freezed}) {
    return _then(
      _OrderIdDlnResponseDto(
        orderId:
            freezed == orderId
                ? _self.orderId
                : orderId // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
mixin _$IncomingQuoteRequestDto {
  int get amount;
  String get senderAddress;
  String get senderBlockchain;
  String get receiverAddress;
  String? get solanaReferenceAddress;

  /// Create a copy of IncomingQuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $IncomingQuoteRequestDtoCopyWith<IncomingQuoteRequestDto> get copyWith =>
      _$IncomingQuoteRequestDtoCopyWithImpl<IncomingQuoteRequestDto>(
        this as IncomingQuoteRequestDto,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is IncomingQuoteRequestDto &&
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

  @override
  String toString() {
    return 'IncomingQuoteRequestDto(amount: $amount, senderAddress: $senderAddress, senderBlockchain: $senderBlockchain, receiverAddress: $receiverAddress, solanaReferenceAddress: $solanaReferenceAddress)';
  }
}

/// @nodoc
abstract mixin class $IncomingQuoteRequestDtoCopyWith<$Res> {
  factory $IncomingQuoteRequestDtoCopyWith(
    IncomingQuoteRequestDto value,
    $Res Function(IncomingQuoteRequestDto) _then,
  ) = _$IncomingQuoteRequestDtoCopyWithImpl;
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
class _$IncomingQuoteRequestDtoCopyWithImpl<$Res>
    implements $IncomingQuoteRequestDtoCopyWith<$Res> {
  _$IncomingQuoteRequestDtoCopyWithImpl(this._self, this._then);

  final IncomingQuoteRequestDto _self;
  final $Res Function(IncomingQuoteRequestDto) _then;

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
      _self.copyWith(
        amount:
            null == amount
                ? _self.amount
                : amount // ignore: cast_nullable_to_non_nullable
                    as int,
        senderAddress:
            null == senderAddress
                ? _self.senderAddress
                : senderAddress // ignore: cast_nullable_to_non_nullable
                    as String,
        senderBlockchain:
            null == senderBlockchain
                ? _self.senderBlockchain
                : senderBlockchain // ignore: cast_nullable_to_non_nullable
                    as String,
        receiverAddress:
            null == receiverAddress
                ? _self.receiverAddress
                : receiverAddress // ignore: cast_nullable_to_non_nullable
                    as String,
        solanaReferenceAddress:
            freezed == solanaReferenceAddress
                ? _self.solanaReferenceAddress
                : solanaReferenceAddress // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _IncomingQuoteRequestDto implements IncomingQuoteRequestDto {
  const _IncomingQuoteRequestDto({
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

  /// Create a copy of IncomingQuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$IncomingQuoteRequestDtoCopyWith<_IncomingQuoteRequestDto> get copyWith =>
      __$IncomingQuoteRequestDtoCopyWithImpl<_IncomingQuoteRequestDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _IncomingQuoteRequestDto &&
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

  @override
  String toString() {
    return 'IncomingQuoteRequestDto(amount: $amount, senderAddress: $senderAddress, senderBlockchain: $senderBlockchain, receiverAddress: $receiverAddress, solanaReferenceAddress: $solanaReferenceAddress)';
  }
}

/// @nodoc
abstract mixin class _$IncomingQuoteRequestDtoCopyWith<$Res>
    implements $IncomingQuoteRequestDtoCopyWith<$Res> {
  factory _$IncomingQuoteRequestDtoCopyWith(
    _IncomingQuoteRequestDto value,
    $Res Function(_IncomingQuoteRequestDto) _then,
  ) = __$IncomingQuoteRequestDtoCopyWithImpl;
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
class __$IncomingQuoteRequestDtoCopyWithImpl<$Res>
    implements _$IncomingQuoteRequestDtoCopyWith<$Res> {
  __$IncomingQuoteRequestDtoCopyWithImpl(this._self, this._then);

  final _IncomingQuoteRequestDto _self;
  final $Res Function(_IncomingQuoteRequestDto) _then;

  /// Create a copy of IncomingQuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? amount = null,
    Object? senderAddress = null,
    Object? senderBlockchain = null,
    Object? receiverAddress = null,
    Object? solanaReferenceAddress = freezed,
  }) {
    return _then(
      _IncomingQuoteRequestDto(
        amount:
            null == amount
                ? _self.amount
                : amount // ignore: cast_nullable_to_non_nullable
                    as int,
        senderAddress:
            null == senderAddress
                ? _self.senderAddress
                : senderAddress // ignore: cast_nullable_to_non_nullable
                    as String,
        senderBlockchain:
            null == senderBlockchain
                ? _self.senderBlockchain
                : senderBlockchain // ignore: cast_nullable_to_non_nullable
                    as String,
        receiverAddress:
            null == receiverAddress
                ? _self.receiverAddress
                : receiverAddress // ignore: cast_nullable_to_non_nullable
                    as String,
        solanaReferenceAddress:
            freezed == solanaReferenceAddress
                ? _self.solanaReferenceAddress
                : solanaReferenceAddress // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
mixin _$IncomingQuoteResponseDto {
  QuoteTx get tx;
  QuoteUsdcInfo get usdcInfo;
  int get inputAmount;
  int get receiverAmount;
  int get feeInUsdc;

  /// Create a copy of IncomingQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $IncomingQuoteResponseDtoCopyWith<IncomingQuoteResponseDto> get copyWith =>
      _$IncomingQuoteResponseDtoCopyWithImpl<IncomingQuoteResponseDto>(
        this as IncomingQuoteResponseDto,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is IncomingQuoteResponseDto &&
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

  @override
  String toString() {
    return 'IncomingQuoteResponseDto(tx: $tx, usdcInfo: $usdcInfo, inputAmount: $inputAmount, receiverAmount: $receiverAmount, feeInUsdc: $feeInUsdc)';
  }
}

/// @nodoc
abstract mixin class $IncomingQuoteResponseDtoCopyWith<$Res> {
  factory $IncomingQuoteResponseDtoCopyWith(
    IncomingQuoteResponseDto value,
    $Res Function(IncomingQuoteResponseDto) _then,
  ) = _$IncomingQuoteResponseDtoCopyWithImpl;
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
class _$IncomingQuoteResponseDtoCopyWithImpl<$Res>
    implements $IncomingQuoteResponseDtoCopyWith<$Res> {
  _$IncomingQuoteResponseDtoCopyWithImpl(this._self, this._then);

  final IncomingQuoteResponseDto _self;
  final $Res Function(IncomingQuoteResponseDto) _then;

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
      _self.copyWith(
        tx:
            null == tx
                ? _self.tx
                : tx // ignore: cast_nullable_to_non_nullable
                    as QuoteTx,
        usdcInfo:
            null == usdcInfo
                ? _self.usdcInfo
                : usdcInfo // ignore: cast_nullable_to_non_nullable
                    as QuoteUsdcInfo,
        inputAmount:
            null == inputAmount
                ? _self.inputAmount
                : inputAmount // ignore: cast_nullable_to_non_nullable
                    as int,
        receiverAmount:
            null == receiverAmount
                ? _self.receiverAmount
                : receiverAmount // ignore: cast_nullable_to_non_nullable
                    as int,
        feeInUsdc:
            null == feeInUsdc
                ? _self.feeInUsdc
                : feeInUsdc // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }

  /// Create a copy of IncomingQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QuoteTxCopyWith<$Res> get tx {
    return $QuoteTxCopyWith<$Res>(_self.tx, (value) {
      return _then(_self.copyWith(tx: value));
    });
  }

  /// Create a copy of IncomingQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QuoteUsdcInfoCopyWith<$Res> get usdcInfo {
    return $QuoteUsdcInfoCopyWith<$Res>(_self.usdcInfo, (value) {
      return _then(_self.copyWith(usdcInfo: value));
    });
  }
}

/// @nodoc

class _IncomingQuoteResponseDto implements IncomingQuoteResponseDto {
  const _IncomingQuoteResponseDto({
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

  /// Create a copy of IncomingQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$IncomingQuoteResponseDtoCopyWith<_IncomingQuoteResponseDto> get copyWith =>
      __$IncomingQuoteResponseDtoCopyWithImpl<_IncomingQuoteResponseDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _IncomingQuoteResponseDto &&
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

  @override
  String toString() {
    return 'IncomingQuoteResponseDto(tx: $tx, usdcInfo: $usdcInfo, inputAmount: $inputAmount, receiverAmount: $receiverAmount, feeInUsdc: $feeInUsdc)';
  }
}

/// @nodoc
abstract mixin class _$IncomingQuoteResponseDtoCopyWith<$Res>
    implements $IncomingQuoteResponseDtoCopyWith<$Res> {
  factory _$IncomingQuoteResponseDtoCopyWith(
    _IncomingQuoteResponseDto value,
    $Res Function(_IncomingQuoteResponseDto) _then,
  ) = __$IncomingQuoteResponseDtoCopyWithImpl;
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
class __$IncomingQuoteResponseDtoCopyWithImpl<$Res>
    implements _$IncomingQuoteResponseDtoCopyWith<$Res> {
  __$IncomingQuoteResponseDtoCopyWithImpl(this._self, this._then);

  final _IncomingQuoteResponseDto _self;
  final $Res Function(_IncomingQuoteResponseDto) _then;

  /// Create a copy of IncomingQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tx = null,
    Object? usdcInfo = null,
    Object? inputAmount = null,
    Object? receiverAmount = null,
    Object? feeInUsdc = null,
  }) {
    return _then(
      _IncomingQuoteResponseDto(
        tx:
            null == tx
                ? _self.tx
                : tx // ignore: cast_nullable_to_non_nullable
                    as QuoteTx,
        usdcInfo:
            null == usdcInfo
                ? _self.usdcInfo
                : usdcInfo // ignore: cast_nullable_to_non_nullable
                    as QuoteUsdcInfo,
        inputAmount:
            null == inputAmount
                ? _self.inputAmount
                : inputAmount // ignore: cast_nullable_to_non_nullable
                    as int,
        receiverAmount:
            null == receiverAmount
                ? _self.receiverAmount
                : receiverAmount // ignore: cast_nullable_to_non_nullable
                    as int,
        feeInUsdc:
            null == feeInUsdc
                ? _self.feeInUsdc
                : feeInUsdc // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }

  /// Create a copy of IncomingQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QuoteTxCopyWith<$Res> get tx {
    return $QuoteTxCopyWith<$Res>(_self.tx, (value) {
      return _then(_self.copyWith(tx: value));
    });
  }

  /// Create a copy of IncomingQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QuoteUsdcInfoCopyWith<$Res> get usdcInfo {
    return $QuoteUsdcInfoCopyWith<$Res>(_self.usdcInfo, (value) {
      return _then(_self.copyWith(usdcInfo: value));
    });
  }
}

/// @nodoc
mixin _$QuoteTx {
  String get to;
  String get data;
  int get value;

  /// Create a copy of QuoteTx
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QuoteTxCopyWith<QuoteTx> get copyWith =>
      _$QuoteTxCopyWithImpl<QuoteTx>(this as QuoteTx, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is QuoteTx &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, to, data, value);

  @override
  String toString() {
    return 'QuoteTx(to: $to, data: $data, value: $value)';
  }
}

/// @nodoc
abstract mixin class $QuoteTxCopyWith<$Res> {
  factory $QuoteTxCopyWith(QuoteTx value, $Res Function(QuoteTx) _then) = _$QuoteTxCopyWithImpl;
  @useResult
  $Res call({String to, String data, int value});
}

/// @nodoc
class _$QuoteTxCopyWithImpl<$Res> implements $QuoteTxCopyWith<$Res> {
  _$QuoteTxCopyWithImpl(this._self, this._then);

  final QuoteTx _self;
  final $Res Function(QuoteTx) _then;

  /// Create a copy of QuoteTx
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? to = null, Object? data = null, Object? value = null}) {
    return _then(
      _self.copyWith(
        to:
            null == to
                ? _self.to
                : to // ignore: cast_nullable_to_non_nullable
                    as String,
        data:
            null == data
                ? _self.data
                : data // ignore: cast_nullable_to_non_nullable
                    as String,
        value:
            null == value
                ? _self.value
                : value // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _QuoteTx implements QuoteTx {
  const _QuoteTx({required this.to, required this.data, required this.value});

  @override
  final String to;
  @override
  final String data;
  @override
  final int value;

  /// Create a copy of QuoteTx
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QuoteTxCopyWith<_QuoteTx> get copyWith => __$QuoteTxCopyWithImpl<_QuoteTx>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QuoteTx &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, to, data, value);

  @override
  String toString() {
    return 'QuoteTx(to: $to, data: $data, value: $value)';
  }
}

/// @nodoc
abstract mixin class _$QuoteTxCopyWith<$Res> implements $QuoteTxCopyWith<$Res> {
  factory _$QuoteTxCopyWith(_QuoteTx value, $Res Function(_QuoteTx) _then) = __$QuoteTxCopyWithImpl;
  @override
  @useResult
  $Res call({String to, String data, int value});
}

/// @nodoc
class __$QuoteTxCopyWithImpl<$Res> implements _$QuoteTxCopyWith<$Res> {
  __$QuoteTxCopyWithImpl(this._self, this._then);

  final _QuoteTx _self;
  final $Res Function(_QuoteTx) _then;

  /// Create a copy of QuoteTx
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? to = null, Object? data = null, Object? value = null}) {
    return _then(
      _QuoteTx(
        to:
            null == to
                ? _self.to
                : to // ignore: cast_nullable_to_non_nullable
                    as String,
        data:
            null == data
                ? _self.data
                : data // ignore: cast_nullable_to_non_nullable
                    as String,
        value:
            null == value
                ? _self.value
                : value // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
mixin _$QuoteUsdcInfo {
  String get usdcAddress;
  int get approvalAmount;

  /// Create a copy of QuoteUsdcInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QuoteUsdcInfoCopyWith<QuoteUsdcInfo> get copyWith =>
      _$QuoteUsdcInfoCopyWithImpl<QuoteUsdcInfo>(this as QuoteUsdcInfo, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is QuoteUsdcInfo &&
            (identical(other.usdcAddress, usdcAddress) || other.usdcAddress == usdcAddress) &&
            (identical(other.approvalAmount, approvalAmount) ||
                other.approvalAmount == approvalAmount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, usdcAddress, approvalAmount);

  @override
  String toString() {
    return 'QuoteUsdcInfo(usdcAddress: $usdcAddress, approvalAmount: $approvalAmount)';
  }
}

/// @nodoc
abstract mixin class $QuoteUsdcInfoCopyWith<$Res> {
  factory $QuoteUsdcInfoCopyWith(QuoteUsdcInfo value, $Res Function(QuoteUsdcInfo) _then) =
      _$QuoteUsdcInfoCopyWithImpl;
  @useResult
  $Res call({String usdcAddress, int approvalAmount});
}

/// @nodoc
class _$QuoteUsdcInfoCopyWithImpl<$Res> implements $QuoteUsdcInfoCopyWith<$Res> {
  _$QuoteUsdcInfoCopyWithImpl(this._self, this._then);

  final QuoteUsdcInfo _self;
  final $Res Function(QuoteUsdcInfo) _then;

  /// Create a copy of QuoteUsdcInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? usdcAddress = null, Object? approvalAmount = null}) {
    return _then(
      _self.copyWith(
        usdcAddress:
            null == usdcAddress
                ? _self.usdcAddress
                : usdcAddress // ignore: cast_nullable_to_non_nullable
                    as String,
        approvalAmount:
            null == approvalAmount
                ? _self.approvalAmount
                : approvalAmount // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _QuoteUsdcInfo implements QuoteUsdcInfo {
  const _QuoteUsdcInfo({required this.usdcAddress, required this.approvalAmount});

  @override
  final String usdcAddress;
  @override
  final int approvalAmount;

  /// Create a copy of QuoteUsdcInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QuoteUsdcInfoCopyWith<_QuoteUsdcInfo> get copyWith =>
      __$QuoteUsdcInfoCopyWithImpl<_QuoteUsdcInfo>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QuoteUsdcInfo &&
            (identical(other.usdcAddress, usdcAddress) || other.usdcAddress == usdcAddress) &&
            (identical(other.approvalAmount, approvalAmount) ||
                other.approvalAmount == approvalAmount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, usdcAddress, approvalAmount);

  @override
  String toString() {
    return 'QuoteUsdcInfo(usdcAddress: $usdcAddress, approvalAmount: $approvalAmount)';
  }
}

/// @nodoc
abstract mixin class _$QuoteUsdcInfoCopyWith<$Res> implements $QuoteUsdcInfoCopyWith<$Res> {
  factory _$QuoteUsdcInfoCopyWith(_QuoteUsdcInfo value, $Res Function(_QuoteUsdcInfo) _then) =
      __$QuoteUsdcInfoCopyWithImpl;
  @override
  @useResult
  $Res call({String usdcAddress, int approvalAmount});
}

/// @nodoc
class __$QuoteUsdcInfoCopyWithImpl<$Res> implements _$QuoteUsdcInfoCopyWith<$Res> {
  __$QuoteUsdcInfoCopyWithImpl(this._self, this._then);

  final _QuoteUsdcInfo _self;
  final $Res Function(_QuoteUsdcInfo) _then;

  /// Create a copy of QuoteUsdcInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? usdcAddress = null, Object? approvalAmount = null}) {
    return _then(
      _QuoteUsdcInfo(
        usdcAddress:
            null == usdcAddress
                ? _self.usdcAddress
                : usdcAddress // ignore: cast_nullable_to_non_nullable
                    as String,
        approvalAmount:
            null == approvalAmount
                ? _self.approvalAmount
                : approvalAmount // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}
