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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PaymentQuoteRequestDto _$PaymentQuoteRequestDtoFromJson(
    Map<String, dynamic> json) {
  return _PaymentQuoteRequestDto.fromJson(json);
}

/// @nodoc
mixin _$PaymentQuoteRequestDto {
  String get amount => throw _privateConstructorUsedError;
  String get receiverAddress => throw _privateConstructorUsedError;
  String get receiverBlockchain => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentQuoteRequestDtoCopyWith<PaymentQuoteRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentQuoteRequestDtoCopyWith<$Res> {
  factory $PaymentQuoteRequestDtoCopyWith(PaymentQuoteRequestDto value,
          $Res Function(PaymentQuoteRequestDto) then) =
      _$PaymentQuoteRequestDtoCopyWithImpl<$Res, PaymentQuoteRequestDto>;
  @useResult
  $Res call({String amount, String receiverAddress, String receiverBlockchain});
}

/// @nodoc
class _$PaymentQuoteRequestDtoCopyWithImpl<$Res,
        $Val extends PaymentQuoteRequestDto>
    implements $PaymentQuoteRequestDtoCopyWith<$Res> {
  _$PaymentQuoteRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? receiverAddress = null,
    Object? receiverBlockchain = null,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      receiverAddress: null == receiverAddress
          ? _value.receiverAddress
          : receiverAddress // ignore: cast_nullable_to_non_nullable
              as String,
      receiverBlockchain: null == receiverBlockchain
          ? _value.receiverBlockchain
          : receiverBlockchain // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentQuoteRequestDtoImplCopyWith<$Res>
    implements $PaymentQuoteRequestDtoCopyWith<$Res> {
  factory _$$PaymentQuoteRequestDtoImplCopyWith(
          _$PaymentQuoteRequestDtoImpl value,
          $Res Function(_$PaymentQuoteRequestDtoImpl) then) =
      __$$PaymentQuoteRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String amount, String receiverAddress, String receiverBlockchain});
}

/// @nodoc
class __$$PaymentQuoteRequestDtoImplCopyWithImpl<$Res>
    extends _$PaymentQuoteRequestDtoCopyWithImpl<$Res,
        _$PaymentQuoteRequestDtoImpl>
    implements _$$PaymentQuoteRequestDtoImplCopyWith<$Res> {
  __$$PaymentQuoteRequestDtoImplCopyWithImpl(
      _$PaymentQuoteRequestDtoImpl _value,
      $Res Function(_$PaymentQuoteRequestDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? receiverAddress = null,
    Object? receiverBlockchain = null,
  }) {
    return _then(_$PaymentQuoteRequestDtoImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      receiverAddress: null == receiverAddress
          ? _value.receiverAddress
          : receiverAddress // ignore: cast_nullable_to_non_nullable
              as String,
      receiverBlockchain: null == receiverBlockchain
          ? _value.receiverBlockchain
          : receiverBlockchain // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentQuoteRequestDtoImpl implements _PaymentQuoteRequestDto {
  const _$PaymentQuoteRequestDtoImpl(
      {required this.amount,
      required this.receiverAddress,
      required this.receiverBlockchain});

  factory _$PaymentQuoteRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentQuoteRequestDtoImplFromJson(json);

  @override
  final String amount;
  @override
  final String receiverAddress;
  @override
  final String receiverBlockchain;

  @override
  String toString() {
    return 'PaymentQuoteRequestDto(amount: $amount, receiverAddress: $receiverAddress, receiverBlockchain: $receiverBlockchain)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentQuoteRequestDtoImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.receiverAddress, receiverAddress) ||
                other.receiverAddress == receiverAddress) &&
            (identical(other.receiverBlockchain, receiverBlockchain) ||
                other.receiverBlockchain == receiverBlockchain));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, amount, receiverAddress, receiverBlockchain);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentQuoteRequestDtoImplCopyWith<_$PaymentQuoteRequestDtoImpl>
      get copyWith => __$$PaymentQuoteRequestDtoImplCopyWithImpl<
          _$PaymentQuoteRequestDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentQuoteRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _PaymentQuoteRequestDto implements PaymentQuoteRequestDto {
  const factory _PaymentQuoteRequestDto(
      {required final String amount,
      required final String receiverAddress,
      required final String receiverBlockchain}) = _$PaymentQuoteRequestDtoImpl;

  factory _PaymentQuoteRequestDto.fromJson(Map<String, dynamic> json) =
      _$PaymentQuoteRequestDtoImpl.fromJson;

  @override
  String get amount;
  @override
  String get receiverAddress;
  @override
  String get receiverBlockchain;
  @override
  @JsonKey(ignore: true)
  _$$PaymentQuoteRequestDtoImplCopyWith<_$PaymentQuoteRequestDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PaymentQuoteResponseDto _$PaymentQuoteResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _PaymentQuoteResponseDto.fromJson(json);
}

/// @nodoc
mixin _$PaymentQuoteResponseDto {
  String get inputAmount => throw _privateConstructorUsedError;
  String get receiverAmount => throw _privateConstructorUsedError;
  String get encodedTx => throw _privateConstructorUsedError;
  int get feeInUsdc => throw _privateConstructorUsedError;
  BigInt get slot => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentQuoteResponseDtoCopyWith<PaymentQuoteResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentQuoteResponseDtoCopyWith<$Res> {
  factory $PaymentQuoteResponseDtoCopyWith(PaymentQuoteResponseDto value,
          $Res Function(PaymentQuoteResponseDto) then) =
      _$PaymentQuoteResponseDtoCopyWithImpl<$Res, PaymentQuoteResponseDto>;
  @useResult
  $Res call(
      {String inputAmount,
      String receiverAmount,
      String encodedTx,
      int feeInUsdc,
      BigInt slot});
}

/// @nodoc
class _$PaymentQuoteResponseDtoCopyWithImpl<$Res,
        $Val extends PaymentQuoteResponseDto>
    implements $PaymentQuoteResponseDtoCopyWith<$Res> {
  _$PaymentQuoteResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputAmount = null,
    Object? receiverAmount = null,
    Object? encodedTx = null,
    Object? feeInUsdc = null,
    Object? slot = null,
  }) {
    return _then(_value.copyWith(
      inputAmount: null == inputAmount
          ? _value.inputAmount
          : inputAmount // ignore: cast_nullable_to_non_nullable
              as String,
      receiverAmount: null == receiverAmount
          ? _value.receiverAmount
          : receiverAmount // ignore: cast_nullable_to_non_nullable
              as String,
      encodedTx: null == encodedTx
          ? _value.encodedTx
          : encodedTx // ignore: cast_nullable_to_non_nullable
              as String,
      feeInUsdc: null == feeInUsdc
          ? _value.feeInUsdc
          : feeInUsdc // ignore: cast_nullable_to_non_nullable
              as int,
      slot: null == slot
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentQuoteResponseDtoImplCopyWith<$Res>
    implements $PaymentQuoteResponseDtoCopyWith<$Res> {
  factory _$$PaymentQuoteResponseDtoImplCopyWith(
          _$PaymentQuoteResponseDtoImpl value,
          $Res Function(_$PaymentQuoteResponseDtoImpl) then) =
      __$$PaymentQuoteResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String inputAmount,
      String receiverAmount,
      String encodedTx,
      int feeInUsdc,
      BigInt slot});
}

/// @nodoc
class __$$PaymentQuoteResponseDtoImplCopyWithImpl<$Res>
    extends _$PaymentQuoteResponseDtoCopyWithImpl<$Res,
        _$PaymentQuoteResponseDtoImpl>
    implements _$$PaymentQuoteResponseDtoImplCopyWith<$Res> {
  __$$PaymentQuoteResponseDtoImplCopyWithImpl(
      _$PaymentQuoteResponseDtoImpl _value,
      $Res Function(_$PaymentQuoteResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputAmount = null,
    Object? receiverAmount = null,
    Object? encodedTx = null,
    Object? feeInUsdc = null,
    Object? slot = null,
  }) {
    return _then(_$PaymentQuoteResponseDtoImpl(
      inputAmount: null == inputAmount
          ? _value.inputAmount
          : inputAmount // ignore: cast_nullable_to_non_nullable
              as String,
      receiverAmount: null == receiverAmount
          ? _value.receiverAmount
          : receiverAmount // ignore: cast_nullable_to_non_nullable
              as String,
      encodedTx: null == encodedTx
          ? _value.encodedTx
          : encodedTx // ignore: cast_nullable_to_non_nullable
              as String,
      feeInUsdc: null == feeInUsdc
          ? _value.feeInUsdc
          : feeInUsdc // ignore: cast_nullable_to_non_nullable
              as int,
      slot: null == slot
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentQuoteResponseDtoImpl implements _PaymentQuoteResponseDto {
  const _$PaymentQuoteResponseDtoImpl(
      {required this.inputAmount,
      required this.receiverAmount,
      required this.encodedTx,
      required this.feeInUsdc,
      required this.slot});

  factory _$PaymentQuoteResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentQuoteResponseDtoImplFromJson(json);

  @override
  final String inputAmount;
  @override
  final String receiverAmount;
  @override
  final String encodedTx;
  @override
  final int feeInUsdc;
  @override
  final BigInt slot;

  @override
  String toString() {
    return 'PaymentQuoteResponseDto(inputAmount: $inputAmount, receiverAmount: $receiverAmount, encodedTx: $encodedTx, feeInUsdc: $feeInUsdc, slot: $slot)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentQuoteResponseDtoImpl &&
            (identical(other.inputAmount, inputAmount) ||
                other.inputAmount == inputAmount) &&
            (identical(other.receiverAmount, receiverAmount) ||
                other.receiverAmount == receiverAmount) &&
            (identical(other.encodedTx, encodedTx) ||
                other.encodedTx == encodedTx) &&
            (identical(other.feeInUsdc, feeInUsdc) ||
                other.feeInUsdc == feeInUsdc) &&
            (identical(other.slot, slot) || other.slot == slot));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, inputAmount, receiverAmount, encodedTx, feeInUsdc, slot);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentQuoteResponseDtoImplCopyWith<_$PaymentQuoteResponseDtoImpl>
      get copyWith => __$$PaymentQuoteResponseDtoImplCopyWithImpl<
          _$PaymentQuoteResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentQuoteResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _PaymentQuoteResponseDto implements PaymentQuoteResponseDto {
  const factory _PaymentQuoteResponseDto(
      {required final String inputAmount,
      required final String receiverAmount,
      required final String encodedTx,
      required final int feeInUsdc,
      required final BigInt slot}) = _$PaymentQuoteResponseDtoImpl;

  factory _PaymentQuoteResponseDto.fromJson(Map<String, dynamic> json) =
      _$PaymentQuoteResponseDtoImpl.fromJson;

  @override
  String get inputAmount;
  @override
  String get receiverAmount;
  @override
  String get encodedTx;
  @override
  int get feeInUsdc;
  @override
  BigInt get slot;
  @override
  @JsonKey(ignore: true)
  _$$PaymentQuoteResponseDtoImplCopyWith<_$PaymentQuoteResponseDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

OrderStatusDlnRequestDto _$OrderStatusDlnRequestDtoFromJson(
    Map<String, dynamic> json) {
  return _OrderStatusDlnRequestDto.fromJson(json);
}

/// @nodoc
mixin _$OrderStatusDlnRequestDto {
  String get orderId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderStatusDlnRequestDtoCopyWith<OrderStatusDlnRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderStatusDlnRequestDtoCopyWith<$Res> {
  factory $OrderStatusDlnRequestDtoCopyWith(OrderStatusDlnRequestDto value,
          $Res Function(OrderStatusDlnRequestDto) then) =
      _$OrderStatusDlnRequestDtoCopyWithImpl<$Res, OrderStatusDlnRequestDto>;
  @useResult
  $Res call({String orderId});
}

/// @nodoc
class _$OrderStatusDlnRequestDtoCopyWithImpl<$Res,
        $Val extends OrderStatusDlnRequestDto>
    implements $OrderStatusDlnRequestDtoCopyWith<$Res> {
  _$OrderStatusDlnRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
  }) {
    return _then(_value.copyWith(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderStatusDlnRequestDtoImplCopyWith<$Res>
    implements $OrderStatusDlnRequestDtoCopyWith<$Res> {
  factory _$$OrderStatusDlnRequestDtoImplCopyWith(
          _$OrderStatusDlnRequestDtoImpl value,
          $Res Function(_$OrderStatusDlnRequestDtoImpl) then) =
      __$$OrderStatusDlnRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String orderId});
}

/// @nodoc
class __$$OrderStatusDlnRequestDtoImplCopyWithImpl<$Res>
    extends _$OrderStatusDlnRequestDtoCopyWithImpl<$Res,
        _$OrderStatusDlnRequestDtoImpl>
    implements _$$OrderStatusDlnRequestDtoImplCopyWith<$Res> {
  __$$OrderStatusDlnRequestDtoImplCopyWithImpl(
      _$OrderStatusDlnRequestDtoImpl _value,
      $Res Function(_$OrderStatusDlnRequestDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
  }) {
    return _then(_$OrderStatusDlnRequestDtoImpl(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderStatusDlnRequestDtoImpl implements _OrderStatusDlnRequestDto {
  const _$OrderStatusDlnRequestDtoImpl({required this.orderId});

  factory _$OrderStatusDlnRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderStatusDlnRequestDtoImplFromJson(json);

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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, orderId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderStatusDlnRequestDtoImplCopyWith<_$OrderStatusDlnRequestDtoImpl>
      get copyWith => __$$OrderStatusDlnRequestDtoImplCopyWithImpl<
          _$OrderStatusDlnRequestDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderStatusDlnRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _OrderStatusDlnRequestDto implements OrderStatusDlnRequestDto {
  const factory _OrderStatusDlnRequestDto({required final String orderId}) =
      _$OrderStatusDlnRequestDtoImpl;

  factory _OrderStatusDlnRequestDto.fromJson(Map<String, dynamic> json) =
      _$OrderStatusDlnRequestDtoImpl.fromJson;

  @override
  String get orderId;
  @override
  @JsonKey(ignore: true)
  _$$OrderStatusDlnRequestDtoImplCopyWith<_$OrderStatusDlnRequestDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

OrderStatusDlnResponseDto _$OrderStatusDlnResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _OrderStatusDlnResponseDto.fromJson(json);
}

/// @nodoc
mixin _$OrderStatusDlnResponseDto {
  DlnOrderStatus get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderStatusDlnResponseDtoCopyWith<OrderStatusDlnResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderStatusDlnResponseDtoCopyWith<$Res> {
  factory $OrderStatusDlnResponseDtoCopyWith(OrderStatusDlnResponseDto value,
          $Res Function(OrderStatusDlnResponseDto) then) =
      _$OrderStatusDlnResponseDtoCopyWithImpl<$Res, OrderStatusDlnResponseDto>;
  @useResult
  $Res call({DlnOrderStatus status});
}

/// @nodoc
class _$OrderStatusDlnResponseDtoCopyWithImpl<$Res,
        $Val extends OrderStatusDlnResponseDto>
    implements $OrderStatusDlnResponseDtoCopyWith<$Res> {
  _$OrderStatusDlnResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as DlnOrderStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderStatusDlnResponseDtoImplCopyWith<$Res>
    implements $OrderStatusDlnResponseDtoCopyWith<$Res> {
  factory _$$OrderStatusDlnResponseDtoImplCopyWith(
          _$OrderStatusDlnResponseDtoImpl value,
          $Res Function(_$OrderStatusDlnResponseDtoImpl) then) =
      __$$OrderStatusDlnResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DlnOrderStatus status});
}

/// @nodoc
class __$$OrderStatusDlnResponseDtoImplCopyWithImpl<$Res>
    extends _$OrderStatusDlnResponseDtoCopyWithImpl<$Res,
        _$OrderStatusDlnResponseDtoImpl>
    implements _$$OrderStatusDlnResponseDtoImplCopyWith<$Res> {
  __$$OrderStatusDlnResponseDtoImplCopyWithImpl(
      _$OrderStatusDlnResponseDtoImpl _value,
      $Res Function(_$OrderStatusDlnResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_$OrderStatusDlnResponseDtoImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as DlnOrderStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderStatusDlnResponseDtoImpl implements _OrderStatusDlnResponseDto {
  const _$OrderStatusDlnResponseDtoImpl({required this.status});

  factory _$OrderStatusDlnResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderStatusDlnResponseDtoImplFromJson(json);

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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderStatusDlnResponseDtoImplCopyWith<_$OrderStatusDlnResponseDtoImpl>
      get copyWith => __$$OrderStatusDlnResponseDtoImplCopyWithImpl<
          _$OrderStatusDlnResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderStatusDlnResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _OrderStatusDlnResponseDto implements OrderStatusDlnResponseDto {
  const factory _OrderStatusDlnResponseDto(
      {required final DlnOrderStatus status}) = _$OrderStatusDlnResponseDtoImpl;

  factory _OrderStatusDlnResponseDto.fromJson(Map<String, dynamic> json) =
      _$OrderStatusDlnResponseDtoImpl.fromJson;

  @override
  DlnOrderStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$OrderStatusDlnResponseDtoImplCopyWith<_$OrderStatusDlnResponseDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

OrderIdDlnRequestDto _$OrderIdDlnRequestDtoFromJson(Map<String, dynamic> json) {
  return _OrderIdDlnRequestDto.fromJson(json);
}

/// @nodoc
mixin _$OrderIdDlnRequestDto {
  String get txId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderIdDlnRequestDtoCopyWith<OrderIdDlnRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderIdDlnRequestDtoCopyWith<$Res> {
  factory $OrderIdDlnRequestDtoCopyWith(OrderIdDlnRequestDto value,
          $Res Function(OrderIdDlnRequestDto) then) =
      _$OrderIdDlnRequestDtoCopyWithImpl<$Res, OrderIdDlnRequestDto>;
  @useResult
  $Res call({String txId});
}

/// @nodoc
class _$OrderIdDlnRequestDtoCopyWithImpl<$Res,
        $Val extends OrderIdDlnRequestDto>
    implements $OrderIdDlnRequestDtoCopyWith<$Res> {
  _$OrderIdDlnRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? txId = null,
  }) {
    return _then(_value.copyWith(
      txId: null == txId
          ? _value.txId
          : txId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderIdDlnRequestDtoImplCopyWith<$Res>
    implements $OrderIdDlnRequestDtoCopyWith<$Res> {
  factory _$$OrderIdDlnRequestDtoImplCopyWith(_$OrderIdDlnRequestDtoImpl value,
          $Res Function(_$OrderIdDlnRequestDtoImpl) then) =
      __$$OrderIdDlnRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String txId});
}

/// @nodoc
class __$$OrderIdDlnRequestDtoImplCopyWithImpl<$Res>
    extends _$OrderIdDlnRequestDtoCopyWithImpl<$Res, _$OrderIdDlnRequestDtoImpl>
    implements _$$OrderIdDlnRequestDtoImplCopyWith<$Res> {
  __$$OrderIdDlnRequestDtoImplCopyWithImpl(_$OrderIdDlnRequestDtoImpl _value,
      $Res Function(_$OrderIdDlnRequestDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? txId = null,
  }) {
    return _then(_$OrderIdDlnRequestDtoImpl(
      txId: null == txId
          ? _value.txId
          : txId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderIdDlnRequestDtoImpl implements _OrderIdDlnRequestDto {
  const _$OrderIdDlnRequestDtoImpl({required this.txId});

  factory _$OrderIdDlnRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderIdDlnRequestDtoImplFromJson(json);

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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, txId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderIdDlnRequestDtoImplCopyWith<_$OrderIdDlnRequestDtoImpl>
      get copyWith =>
          __$$OrderIdDlnRequestDtoImplCopyWithImpl<_$OrderIdDlnRequestDtoImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderIdDlnRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _OrderIdDlnRequestDto implements OrderIdDlnRequestDto {
  const factory _OrderIdDlnRequestDto({required final String txId}) =
      _$OrderIdDlnRequestDtoImpl;

  factory _OrderIdDlnRequestDto.fromJson(Map<String, dynamic> json) =
      _$OrderIdDlnRequestDtoImpl.fromJson;

  @override
  String get txId;
  @override
  @JsonKey(ignore: true)
  _$$OrderIdDlnRequestDtoImplCopyWith<_$OrderIdDlnRequestDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

OrderIdDlnResponseDto _$OrderIdDlnResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _OrderIdDlnResponseDto.fromJson(json);
}

/// @nodoc
mixin _$OrderIdDlnResponseDto {
  String? get orderId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderIdDlnResponseDtoCopyWith<OrderIdDlnResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderIdDlnResponseDtoCopyWith<$Res> {
  factory $OrderIdDlnResponseDtoCopyWith(OrderIdDlnResponseDto value,
          $Res Function(OrderIdDlnResponseDto) then) =
      _$OrderIdDlnResponseDtoCopyWithImpl<$Res, OrderIdDlnResponseDto>;
  @useResult
  $Res call({String? orderId});
}

/// @nodoc
class _$OrderIdDlnResponseDtoCopyWithImpl<$Res,
        $Val extends OrderIdDlnResponseDto>
    implements $OrderIdDlnResponseDtoCopyWith<$Res> {
  _$OrderIdDlnResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = freezed,
  }) {
    return _then(_value.copyWith(
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderIdDlnResponseDtoImplCopyWith<$Res>
    implements $OrderIdDlnResponseDtoCopyWith<$Res> {
  factory _$$OrderIdDlnResponseDtoImplCopyWith(
          _$OrderIdDlnResponseDtoImpl value,
          $Res Function(_$OrderIdDlnResponseDtoImpl) then) =
      __$$OrderIdDlnResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? orderId});
}

/// @nodoc
class __$$OrderIdDlnResponseDtoImplCopyWithImpl<$Res>
    extends _$OrderIdDlnResponseDtoCopyWithImpl<$Res,
        _$OrderIdDlnResponseDtoImpl>
    implements _$$OrderIdDlnResponseDtoImplCopyWith<$Res> {
  __$$OrderIdDlnResponseDtoImplCopyWithImpl(_$OrderIdDlnResponseDtoImpl _value,
      $Res Function(_$OrderIdDlnResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = freezed,
  }) {
    return _then(_$OrderIdDlnResponseDtoImpl(
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderIdDlnResponseDtoImpl implements _OrderIdDlnResponseDto {
  const _$OrderIdDlnResponseDtoImpl({required this.orderId});

  factory _$OrderIdDlnResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderIdDlnResponseDtoImplFromJson(json);

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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, orderId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderIdDlnResponseDtoImplCopyWith<_$OrderIdDlnResponseDtoImpl>
      get copyWith => __$$OrderIdDlnResponseDtoImplCopyWithImpl<
          _$OrderIdDlnResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderIdDlnResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _OrderIdDlnResponseDto implements OrderIdDlnResponseDto {
  const factory _OrderIdDlnResponseDto({required final String? orderId}) =
      _$OrderIdDlnResponseDtoImpl;

  factory _OrderIdDlnResponseDto.fromJson(Map<String, dynamic> json) =
      _$OrderIdDlnResponseDtoImpl.fromJson;

  @override
  String? get orderId;
  @override
  @JsonKey(ignore: true)
  _$$OrderIdDlnResponseDtoImplCopyWith<_$OrderIdDlnResponseDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
