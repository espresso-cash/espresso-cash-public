// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CreatePaymentRequestDto _$CreatePaymentRequestDtoFromJson(
    Map<String, dynamic> json) {
  return _CreatePaymentRequestDto.fromJson(json);
}

/// @nodoc
mixin _$CreatePaymentRequestDto {
  String get senderAccount => throw _privateConstructorUsedError;
  String get escrowAccount => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  Cluster get cluster => throw _privateConstructorUsedError;
  bool get durable => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreatePaymentRequestDtoCopyWith<CreatePaymentRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatePaymentRequestDtoCopyWith<$Res> {
  factory $CreatePaymentRequestDtoCopyWith(CreatePaymentRequestDto value,
          $Res Function(CreatePaymentRequestDto) then) =
      _$CreatePaymentRequestDtoCopyWithImpl<$Res, CreatePaymentRequestDto>;
  @useResult
  $Res call(
      {String senderAccount,
      String escrowAccount,
      int amount,
      Cluster cluster,
      bool durable});
}

/// @nodoc
class _$CreatePaymentRequestDtoCopyWithImpl<$Res,
        $Val extends CreatePaymentRequestDto>
    implements $CreatePaymentRequestDtoCopyWith<$Res> {
  _$CreatePaymentRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderAccount = null,
    Object? escrowAccount = null,
    Object? amount = null,
    Object? cluster = null,
    Object? durable = null,
  }) {
    return _then(_value.copyWith(
      senderAccount: null == senderAccount
          ? _value.senderAccount
          : senderAccount // ignore: cast_nullable_to_non_nullable
              as String,
      escrowAccount: null == escrowAccount
          ? _value.escrowAccount
          : escrowAccount // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      cluster: null == cluster
          ? _value.cluster
          : cluster // ignore: cast_nullable_to_non_nullable
              as Cluster,
      durable: null == durable
          ? _value.durable
          : durable // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreatePaymentRequestDtoImplCopyWith<$Res>
    implements $CreatePaymentRequestDtoCopyWith<$Res> {
  factory _$$CreatePaymentRequestDtoImplCopyWith(
          _$CreatePaymentRequestDtoImpl value,
          $Res Function(_$CreatePaymentRequestDtoImpl) then) =
      __$$CreatePaymentRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String senderAccount,
      String escrowAccount,
      int amount,
      Cluster cluster,
      bool durable});
}

/// @nodoc
class __$$CreatePaymentRequestDtoImplCopyWithImpl<$Res>
    extends _$CreatePaymentRequestDtoCopyWithImpl<$Res,
        _$CreatePaymentRequestDtoImpl>
    implements _$$CreatePaymentRequestDtoImplCopyWith<$Res> {
  __$$CreatePaymentRequestDtoImplCopyWithImpl(
      _$CreatePaymentRequestDtoImpl _value,
      $Res Function(_$CreatePaymentRequestDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderAccount = null,
    Object? escrowAccount = null,
    Object? amount = null,
    Object? cluster = null,
    Object? durable = null,
  }) {
    return _then(_$CreatePaymentRequestDtoImpl(
      senderAccount: null == senderAccount
          ? _value.senderAccount
          : senderAccount // ignore: cast_nullable_to_non_nullable
              as String,
      escrowAccount: null == escrowAccount
          ? _value.escrowAccount
          : escrowAccount // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      cluster: null == cluster
          ? _value.cluster
          : cluster // ignore: cast_nullable_to_non_nullable
              as Cluster,
      durable: null == durable
          ? _value.durable
          : durable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreatePaymentRequestDtoImpl implements _CreatePaymentRequestDto {
  const _$CreatePaymentRequestDtoImpl(
      {required this.senderAccount,
      required this.escrowAccount,
      required this.amount,
      required this.cluster,
      this.durable = false});

  factory _$CreatePaymentRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreatePaymentRequestDtoImplFromJson(json);

  @override
  final String senderAccount;
  @override
  final String escrowAccount;
  @override
  final int amount;
  @override
  final Cluster cluster;
  @override
  @JsonKey()
  final bool durable;

  @override
  String toString() {
    return 'CreatePaymentRequestDto(senderAccount: $senderAccount, escrowAccount: $escrowAccount, amount: $amount, cluster: $cluster, durable: $durable)';
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
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.cluster, cluster) || other.cluster == cluster) &&
            (identical(other.durable, durable) || other.durable == durable));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, senderAccount, escrowAccount, amount, cluster, durable);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatePaymentRequestDtoImplCopyWith<_$CreatePaymentRequestDtoImpl>
      get copyWith => __$$CreatePaymentRequestDtoImplCopyWithImpl<
          _$CreatePaymentRequestDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreatePaymentRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _CreatePaymentRequestDto implements CreatePaymentRequestDto {
  const factory _CreatePaymentRequestDto(
      {required final String senderAccount,
      required final String escrowAccount,
      required final int amount,
      required final Cluster cluster,
      final bool durable}) = _$CreatePaymentRequestDtoImpl;

  factory _CreatePaymentRequestDto.fromJson(Map<String, dynamic> json) =
      _$CreatePaymentRequestDtoImpl.fromJson;

  @override
  String get senderAccount;
  @override
  String get escrowAccount;
  @override
  int get amount;
  @override
  Cluster get cluster;
  @override
  bool get durable;
  @override
  @JsonKey(ignore: true)
  _$$CreatePaymentRequestDtoImplCopyWith<_$CreatePaymentRequestDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

CreatePaymentResponseDto _$CreatePaymentResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _CreatePaymentResponseDto.fromJson(json);
}

/// @nodoc
mixin _$CreatePaymentResponseDto {
  String get transaction => throw _privateConstructorUsedError;
  BigInt get slot => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreatePaymentResponseDtoCopyWith<CreatePaymentResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatePaymentResponseDtoCopyWith<$Res> {
  factory $CreatePaymentResponseDtoCopyWith(CreatePaymentResponseDto value,
          $Res Function(CreatePaymentResponseDto) then) =
      _$CreatePaymentResponseDtoCopyWithImpl<$Res, CreatePaymentResponseDto>;
  @useResult
  $Res call({String transaction, BigInt slot});
}

/// @nodoc
class _$CreatePaymentResponseDtoCopyWithImpl<$Res,
        $Val extends CreatePaymentResponseDto>
    implements $CreatePaymentResponseDtoCopyWith<$Res> {
  _$CreatePaymentResponseDtoCopyWithImpl(this._value, this._then);

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
abstract class _$$CreatePaymentResponseDtoImplCopyWith<$Res>
    implements $CreatePaymentResponseDtoCopyWith<$Res> {
  factory _$$CreatePaymentResponseDtoImplCopyWith(
          _$CreatePaymentResponseDtoImpl value,
          $Res Function(_$CreatePaymentResponseDtoImpl) then) =
      __$$CreatePaymentResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String transaction, BigInt slot});
}

/// @nodoc
class __$$CreatePaymentResponseDtoImplCopyWithImpl<$Res>
    extends _$CreatePaymentResponseDtoCopyWithImpl<$Res,
        _$CreatePaymentResponseDtoImpl>
    implements _$$CreatePaymentResponseDtoImplCopyWith<$Res> {
  __$$CreatePaymentResponseDtoImplCopyWithImpl(
      _$CreatePaymentResponseDtoImpl _value,
      $Res Function(_$CreatePaymentResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transaction = null,
    Object? slot = null,
  }) {
    return _then(_$CreatePaymentResponseDtoImpl(
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
class _$CreatePaymentResponseDtoImpl implements _CreatePaymentResponseDto {
  const _$CreatePaymentResponseDtoImpl(
      {required this.transaction, required this.slot});

  factory _$CreatePaymentResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreatePaymentResponseDtoImplFromJson(json);

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
  _$$CreatePaymentResponseDtoImplCopyWith<_$CreatePaymentResponseDtoImpl>
      get copyWith => __$$CreatePaymentResponseDtoImplCopyWithImpl<
          _$CreatePaymentResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreatePaymentResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _CreatePaymentResponseDto implements CreatePaymentResponseDto {
  const factory _CreatePaymentResponseDto(
      {required final String transaction,
      required final BigInt slot}) = _$CreatePaymentResponseDtoImpl;

  factory _CreatePaymentResponseDto.fromJson(Map<String, dynamic> json) =
      _$CreatePaymentResponseDtoImpl.fromJson;

  @override
  String get transaction;
  @override
  BigInt get slot;
  @override
  @JsonKey(ignore: true)
  _$$CreatePaymentResponseDtoImplCopyWith<_$CreatePaymentResponseDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ReceivePaymentRequestDto _$ReceivePaymentRequestDtoFromJson(
    Map<String, dynamic> json) {
  return _ReceivePaymentRequestDto.fromJson(json);
}

/// @nodoc
mixin _$ReceivePaymentRequestDto {
  String get receiverAccount => throw _privateConstructorUsedError;
  String get escrowAccount => throw _privateConstructorUsedError;
  Cluster get cluster => throw _privateConstructorUsedError;
  bool get durable => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReceivePaymentRequestDtoCopyWith<ReceivePaymentRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceivePaymentRequestDtoCopyWith<$Res> {
  factory $ReceivePaymentRequestDtoCopyWith(ReceivePaymentRequestDto value,
          $Res Function(ReceivePaymentRequestDto) then) =
      _$ReceivePaymentRequestDtoCopyWithImpl<$Res, ReceivePaymentRequestDto>;
  @useResult
  $Res call(
      {String receiverAccount,
      String escrowAccount,
      Cluster cluster,
      bool durable});
}

/// @nodoc
class _$ReceivePaymentRequestDtoCopyWithImpl<$Res,
        $Val extends ReceivePaymentRequestDto>
    implements $ReceivePaymentRequestDtoCopyWith<$Res> {
  _$ReceivePaymentRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? receiverAccount = null,
    Object? escrowAccount = null,
    Object? cluster = null,
    Object? durable = null,
  }) {
    return _then(_value.copyWith(
      receiverAccount: null == receiverAccount
          ? _value.receiverAccount
          : receiverAccount // ignore: cast_nullable_to_non_nullable
              as String,
      escrowAccount: null == escrowAccount
          ? _value.escrowAccount
          : escrowAccount // ignore: cast_nullable_to_non_nullable
              as String,
      cluster: null == cluster
          ? _value.cluster
          : cluster // ignore: cast_nullable_to_non_nullable
              as Cluster,
      durable: null == durable
          ? _value.durable
          : durable // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReceivePaymentRequestDtoImplCopyWith<$Res>
    implements $ReceivePaymentRequestDtoCopyWith<$Res> {
  factory _$$ReceivePaymentRequestDtoImplCopyWith(
          _$ReceivePaymentRequestDtoImpl value,
          $Res Function(_$ReceivePaymentRequestDtoImpl) then) =
      __$$ReceivePaymentRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String receiverAccount,
      String escrowAccount,
      Cluster cluster,
      bool durable});
}

/// @nodoc
class __$$ReceivePaymentRequestDtoImplCopyWithImpl<$Res>
    extends _$ReceivePaymentRequestDtoCopyWithImpl<$Res,
        _$ReceivePaymentRequestDtoImpl>
    implements _$$ReceivePaymentRequestDtoImplCopyWith<$Res> {
  __$$ReceivePaymentRequestDtoImplCopyWithImpl(
      _$ReceivePaymentRequestDtoImpl _value,
      $Res Function(_$ReceivePaymentRequestDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? receiverAccount = null,
    Object? escrowAccount = null,
    Object? cluster = null,
    Object? durable = null,
  }) {
    return _then(_$ReceivePaymentRequestDtoImpl(
      receiverAccount: null == receiverAccount
          ? _value.receiverAccount
          : receiverAccount // ignore: cast_nullable_to_non_nullable
              as String,
      escrowAccount: null == escrowAccount
          ? _value.escrowAccount
          : escrowAccount // ignore: cast_nullable_to_non_nullable
              as String,
      cluster: null == cluster
          ? _value.cluster
          : cluster // ignore: cast_nullable_to_non_nullable
              as Cluster,
      durable: null == durable
          ? _value.durable
          : durable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReceivePaymentRequestDtoImpl implements _ReceivePaymentRequestDto {
  const _$ReceivePaymentRequestDtoImpl(
      {required this.receiverAccount,
      required this.escrowAccount,
      required this.cluster,
      this.durable = false});

  factory _$ReceivePaymentRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReceivePaymentRequestDtoImplFromJson(json);

  @override
  final String receiverAccount;
  @override
  final String escrowAccount;
  @override
  final Cluster cluster;
  @override
  @JsonKey()
  final bool durable;

  @override
  String toString() {
    return 'ReceivePaymentRequestDto(receiverAccount: $receiverAccount, escrowAccount: $escrowAccount, cluster: $cluster, durable: $durable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReceivePaymentRequestDtoImpl &&
            (identical(other.receiverAccount, receiverAccount) ||
                other.receiverAccount == receiverAccount) &&
            (identical(other.escrowAccount, escrowAccount) ||
                other.escrowAccount == escrowAccount) &&
            (identical(other.cluster, cluster) || other.cluster == cluster) &&
            (identical(other.durable, durable) || other.durable == durable));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, receiverAccount, escrowAccount, cluster, durable);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReceivePaymentRequestDtoImplCopyWith<_$ReceivePaymentRequestDtoImpl>
      get copyWith => __$$ReceivePaymentRequestDtoImplCopyWithImpl<
          _$ReceivePaymentRequestDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReceivePaymentRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _ReceivePaymentRequestDto implements ReceivePaymentRequestDto {
  const factory _ReceivePaymentRequestDto(
      {required final String receiverAccount,
      required final String escrowAccount,
      required final Cluster cluster,
      final bool durable}) = _$ReceivePaymentRequestDtoImpl;

  factory _ReceivePaymentRequestDto.fromJson(Map<String, dynamic> json) =
      _$ReceivePaymentRequestDtoImpl.fromJson;

  @override
  String get receiverAccount;
  @override
  String get escrowAccount;
  @override
  Cluster get cluster;
  @override
  bool get durable;
  @override
  @JsonKey(ignore: true)
  _$$ReceivePaymentRequestDtoImplCopyWith<_$ReceivePaymentRequestDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ReceivePaymentResponseDto _$ReceivePaymentResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _ReceivePaymentResponseDto.fromJson(json);
}

/// @nodoc
mixin _$ReceivePaymentResponseDto {
  String get transaction => throw _privateConstructorUsedError;
  BigInt get slot => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReceivePaymentResponseDtoCopyWith<ReceivePaymentResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceivePaymentResponseDtoCopyWith<$Res> {
  factory $ReceivePaymentResponseDtoCopyWith(ReceivePaymentResponseDto value,
          $Res Function(ReceivePaymentResponseDto) then) =
      _$ReceivePaymentResponseDtoCopyWithImpl<$Res, ReceivePaymentResponseDto>;
  @useResult
  $Res call({String transaction, BigInt slot});
}

/// @nodoc
class _$ReceivePaymentResponseDtoCopyWithImpl<$Res,
        $Val extends ReceivePaymentResponseDto>
    implements $ReceivePaymentResponseDtoCopyWith<$Res> {
  _$ReceivePaymentResponseDtoCopyWithImpl(this._value, this._then);

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
abstract class _$$ReceivePaymentResponseDtoImplCopyWith<$Res>
    implements $ReceivePaymentResponseDtoCopyWith<$Res> {
  factory _$$ReceivePaymentResponseDtoImplCopyWith(
          _$ReceivePaymentResponseDtoImpl value,
          $Res Function(_$ReceivePaymentResponseDtoImpl) then) =
      __$$ReceivePaymentResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String transaction, BigInt slot});
}

/// @nodoc
class __$$ReceivePaymentResponseDtoImplCopyWithImpl<$Res>
    extends _$ReceivePaymentResponseDtoCopyWithImpl<$Res,
        _$ReceivePaymentResponseDtoImpl>
    implements _$$ReceivePaymentResponseDtoImplCopyWith<$Res> {
  __$$ReceivePaymentResponseDtoImplCopyWithImpl(
      _$ReceivePaymentResponseDtoImpl _value,
      $Res Function(_$ReceivePaymentResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transaction = null,
    Object? slot = null,
  }) {
    return _then(_$ReceivePaymentResponseDtoImpl(
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
class _$ReceivePaymentResponseDtoImpl implements _ReceivePaymentResponseDto {
  const _$ReceivePaymentResponseDtoImpl(
      {required this.transaction, required this.slot});

  factory _$ReceivePaymentResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReceivePaymentResponseDtoImplFromJson(json);

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
  _$$ReceivePaymentResponseDtoImplCopyWith<_$ReceivePaymentResponseDtoImpl>
      get copyWith => __$$ReceivePaymentResponseDtoImplCopyWithImpl<
          _$ReceivePaymentResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReceivePaymentResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _ReceivePaymentResponseDto implements ReceivePaymentResponseDto {
  const factory _ReceivePaymentResponseDto(
      {required final String transaction,
      required final BigInt slot}) = _$ReceivePaymentResponseDtoImpl;

  factory _ReceivePaymentResponseDto.fromJson(Map<String, dynamic> json) =
      _$ReceivePaymentResponseDtoImpl.fromJson;

  @override
  String get transaction;
  @override
  BigInt get slot;
  @override
  @JsonKey(ignore: true)
  _$$ReceivePaymentResponseDtoImplCopyWith<_$ReceivePaymentResponseDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

CreateDirectPaymentRequestDto _$CreateDirectPaymentRequestDtoFromJson(
    Map<String, dynamic> json) {
  return _CreateDirectPaymentRequestDto.fromJson(json);
}

/// @nodoc
mixin _$CreateDirectPaymentRequestDto {
  String get senderAccount => throw _privateConstructorUsedError;
  String get receiverAccount => throw _privateConstructorUsedError;
  String? get referenceAccount => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  Cluster get cluster => throw _privateConstructorUsedError;
  bool get durable => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateDirectPaymentRequestDtoCopyWith<CreateDirectPaymentRequestDto>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateDirectPaymentRequestDtoCopyWith<$Res> {
  factory $CreateDirectPaymentRequestDtoCopyWith(
          CreateDirectPaymentRequestDto value,
          $Res Function(CreateDirectPaymentRequestDto) then) =
      _$CreateDirectPaymentRequestDtoCopyWithImpl<$Res,
          CreateDirectPaymentRequestDto>;
  @useResult
  $Res call(
      {String senderAccount,
      String receiverAccount,
      String? referenceAccount,
      int amount,
      Cluster cluster,
      bool durable});
}

/// @nodoc
class _$CreateDirectPaymentRequestDtoCopyWithImpl<$Res,
        $Val extends CreateDirectPaymentRequestDto>
    implements $CreateDirectPaymentRequestDtoCopyWith<$Res> {
  _$CreateDirectPaymentRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderAccount = null,
    Object? receiverAccount = null,
    Object? referenceAccount = freezed,
    Object? amount = null,
    Object? cluster = null,
    Object? durable = null,
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
      referenceAccount: freezed == referenceAccount
          ? _value.referenceAccount
          : referenceAccount // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      cluster: null == cluster
          ? _value.cluster
          : cluster // ignore: cast_nullable_to_non_nullable
              as Cluster,
      durable: null == durable
          ? _value.durable
          : durable // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateDirectPaymentRequestDtoImplCopyWith<$Res>
    implements $CreateDirectPaymentRequestDtoCopyWith<$Res> {
  factory _$$CreateDirectPaymentRequestDtoImplCopyWith(
          _$CreateDirectPaymentRequestDtoImpl value,
          $Res Function(_$CreateDirectPaymentRequestDtoImpl) then) =
      __$$CreateDirectPaymentRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String senderAccount,
      String receiverAccount,
      String? referenceAccount,
      int amount,
      Cluster cluster,
      bool durable});
}

/// @nodoc
class __$$CreateDirectPaymentRequestDtoImplCopyWithImpl<$Res>
    extends _$CreateDirectPaymentRequestDtoCopyWithImpl<$Res,
        _$CreateDirectPaymentRequestDtoImpl>
    implements _$$CreateDirectPaymentRequestDtoImplCopyWith<$Res> {
  __$$CreateDirectPaymentRequestDtoImplCopyWithImpl(
      _$CreateDirectPaymentRequestDtoImpl _value,
      $Res Function(_$CreateDirectPaymentRequestDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderAccount = null,
    Object? receiverAccount = null,
    Object? referenceAccount = freezed,
    Object? amount = null,
    Object? cluster = null,
    Object? durable = null,
  }) {
    return _then(_$CreateDirectPaymentRequestDtoImpl(
      senderAccount: null == senderAccount
          ? _value.senderAccount
          : senderAccount // ignore: cast_nullable_to_non_nullable
              as String,
      receiverAccount: null == receiverAccount
          ? _value.receiverAccount
          : receiverAccount // ignore: cast_nullable_to_non_nullable
              as String,
      referenceAccount: freezed == referenceAccount
          ? _value.referenceAccount
          : referenceAccount // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      cluster: null == cluster
          ? _value.cluster
          : cluster // ignore: cast_nullable_to_non_nullable
              as Cluster,
      durable: null == durable
          ? _value.durable
          : durable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateDirectPaymentRequestDtoImpl
    implements _CreateDirectPaymentRequestDto {
  const _$CreateDirectPaymentRequestDtoImpl(
      {required this.senderAccount,
      required this.receiverAccount,
      required this.referenceAccount,
      required this.amount,
      required this.cluster,
      this.durable = false});

  factory _$CreateDirectPaymentRequestDtoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CreateDirectPaymentRequestDtoImplFromJson(json);

  @override
  final String senderAccount;
  @override
  final String receiverAccount;
  @override
  final String? referenceAccount;
  @override
  final int amount;
  @override
  final Cluster cluster;
  @override
  @JsonKey()
  final bool durable;

  @override
  String toString() {
    return 'CreateDirectPaymentRequestDto(senderAccount: $senderAccount, receiverAccount: $receiverAccount, referenceAccount: $referenceAccount, amount: $amount, cluster: $cluster, durable: $durable)';
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
            (identical(other.cluster, cluster) || other.cluster == cluster) &&
            (identical(other.durable, durable) || other.durable == durable));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, senderAccount, receiverAccount,
      referenceAccount, amount, cluster, durable);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateDirectPaymentRequestDtoImplCopyWith<
          _$CreateDirectPaymentRequestDtoImpl>
      get copyWith => __$$CreateDirectPaymentRequestDtoImplCopyWithImpl<
          _$CreateDirectPaymentRequestDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateDirectPaymentRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _CreateDirectPaymentRequestDto
    implements CreateDirectPaymentRequestDto {
  const factory _CreateDirectPaymentRequestDto(
      {required final String senderAccount,
      required final String receiverAccount,
      required final String? referenceAccount,
      required final int amount,
      required final Cluster cluster,
      final bool durable}) = _$CreateDirectPaymentRequestDtoImpl;

  factory _CreateDirectPaymentRequestDto.fromJson(Map<String, dynamic> json) =
      _$CreateDirectPaymentRequestDtoImpl.fromJson;

  @override
  String get senderAccount;
  @override
  String get receiverAccount;
  @override
  String? get referenceAccount;
  @override
  int get amount;
  @override
  Cluster get cluster;
  @override
  bool get durable;
  @override
  @JsonKey(ignore: true)
  _$$CreateDirectPaymentRequestDtoImplCopyWith<
          _$CreateDirectPaymentRequestDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

CreateDirectPaymentResponseDto _$CreateDirectPaymentResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _CreateDirectPaymentResponseDto.fromJson(json);
}

/// @nodoc
mixin _$CreateDirectPaymentResponseDto {
  int get fee => throw _privateConstructorUsedError;
  String get transaction => throw _privateConstructorUsedError;
  BigInt get slot => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateDirectPaymentResponseDtoCopyWith<CreateDirectPaymentResponseDto>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateDirectPaymentResponseDtoCopyWith<$Res> {
  factory $CreateDirectPaymentResponseDtoCopyWith(
          CreateDirectPaymentResponseDto value,
          $Res Function(CreateDirectPaymentResponseDto) then) =
      _$CreateDirectPaymentResponseDtoCopyWithImpl<$Res,
          CreateDirectPaymentResponseDto>;
  @useResult
  $Res call({int fee, String transaction, BigInt slot});
}

/// @nodoc
class _$CreateDirectPaymentResponseDtoCopyWithImpl<$Res,
        $Val extends CreateDirectPaymentResponseDto>
    implements $CreateDirectPaymentResponseDtoCopyWith<$Res> {
  _$CreateDirectPaymentResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fee = null,
    Object? transaction = null,
    Object? slot = null,
  }) {
    return _then(_value.copyWith(
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as int,
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
abstract class _$$CreateDirectPaymentResponseDtoImplCopyWith<$Res>
    implements $CreateDirectPaymentResponseDtoCopyWith<$Res> {
  factory _$$CreateDirectPaymentResponseDtoImplCopyWith(
          _$CreateDirectPaymentResponseDtoImpl value,
          $Res Function(_$CreateDirectPaymentResponseDtoImpl) then) =
      __$$CreateDirectPaymentResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int fee, String transaction, BigInt slot});
}

/// @nodoc
class __$$CreateDirectPaymentResponseDtoImplCopyWithImpl<$Res>
    extends _$CreateDirectPaymentResponseDtoCopyWithImpl<$Res,
        _$CreateDirectPaymentResponseDtoImpl>
    implements _$$CreateDirectPaymentResponseDtoImplCopyWith<$Res> {
  __$$CreateDirectPaymentResponseDtoImplCopyWithImpl(
      _$CreateDirectPaymentResponseDtoImpl _value,
      $Res Function(_$CreateDirectPaymentResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fee = null,
    Object? transaction = null,
    Object? slot = null,
  }) {
    return _then(_$CreateDirectPaymentResponseDtoImpl(
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as int,
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
class _$CreateDirectPaymentResponseDtoImpl
    implements _CreateDirectPaymentResponseDto {
  const _$CreateDirectPaymentResponseDtoImpl(
      {required this.fee, required this.transaction, required this.slot});

  factory _$CreateDirectPaymentResponseDtoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CreateDirectPaymentResponseDtoImplFromJson(json);

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
            (identical(other.transaction, transaction) ||
                other.transaction == transaction) &&
            (identical(other.slot, slot) || other.slot == slot));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, fee, transaction, slot);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateDirectPaymentResponseDtoImplCopyWith<
          _$CreateDirectPaymentResponseDtoImpl>
      get copyWith => __$$CreateDirectPaymentResponseDtoImplCopyWithImpl<
          _$CreateDirectPaymentResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateDirectPaymentResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _CreateDirectPaymentResponseDto
    implements CreateDirectPaymentResponseDto {
  const factory _CreateDirectPaymentResponseDto(
      {required final int fee,
      required final String transaction,
      required final BigInt slot}) = _$CreateDirectPaymentResponseDtoImpl;

  factory _CreateDirectPaymentResponseDto.fromJson(Map<String, dynamic> json) =
      _$CreateDirectPaymentResponseDtoImpl.fromJson;

  @override
  int get fee;
  @override
  String get transaction;
  @override
  BigInt get slot;
  @override
  @JsonKey(ignore: true)
  _$$CreateDirectPaymentResponseDtoImplCopyWith<
          _$CreateDirectPaymentResponseDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

CancelPaymentRequestDto _$CancelPaymentRequestDtoFromJson(
    Map<String, dynamic> json) {
  return _CancelPaymentRequestDto.fromJson(json);
}

/// @nodoc
mixin _$CancelPaymentRequestDto {
  String get senderAccount => throw _privateConstructorUsedError;
  String get escrowAccount => throw _privateConstructorUsedError;
  Cluster get cluster => throw _privateConstructorUsedError;
  bool get durable => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CancelPaymentRequestDtoCopyWith<CancelPaymentRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CancelPaymentRequestDtoCopyWith<$Res> {
  factory $CancelPaymentRequestDtoCopyWith(CancelPaymentRequestDto value,
          $Res Function(CancelPaymentRequestDto) then) =
      _$CancelPaymentRequestDtoCopyWithImpl<$Res, CancelPaymentRequestDto>;
  @useResult
  $Res call(
      {String senderAccount,
      String escrowAccount,
      Cluster cluster,
      bool durable});
}

/// @nodoc
class _$CancelPaymentRequestDtoCopyWithImpl<$Res,
        $Val extends CancelPaymentRequestDto>
    implements $CancelPaymentRequestDtoCopyWith<$Res> {
  _$CancelPaymentRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderAccount = null,
    Object? escrowAccount = null,
    Object? cluster = null,
    Object? durable = null,
  }) {
    return _then(_value.copyWith(
      senderAccount: null == senderAccount
          ? _value.senderAccount
          : senderAccount // ignore: cast_nullable_to_non_nullable
              as String,
      escrowAccount: null == escrowAccount
          ? _value.escrowAccount
          : escrowAccount // ignore: cast_nullable_to_non_nullable
              as String,
      cluster: null == cluster
          ? _value.cluster
          : cluster // ignore: cast_nullable_to_non_nullable
              as Cluster,
      durable: null == durable
          ? _value.durable
          : durable // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CancelPaymentRequestDtoImplCopyWith<$Res>
    implements $CancelPaymentRequestDtoCopyWith<$Res> {
  factory _$$CancelPaymentRequestDtoImplCopyWith(
          _$CancelPaymentRequestDtoImpl value,
          $Res Function(_$CancelPaymentRequestDtoImpl) then) =
      __$$CancelPaymentRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String senderAccount,
      String escrowAccount,
      Cluster cluster,
      bool durable});
}

/// @nodoc
class __$$CancelPaymentRequestDtoImplCopyWithImpl<$Res>
    extends _$CancelPaymentRequestDtoCopyWithImpl<$Res,
        _$CancelPaymentRequestDtoImpl>
    implements _$$CancelPaymentRequestDtoImplCopyWith<$Res> {
  __$$CancelPaymentRequestDtoImplCopyWithImpl(
      _$CancelPaymentRequestDtoImpl _value,
      $Res Function(_$CancelPaymentRequestDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderAccount = null,
    Object? escrowAccount = null,
    Object? cluster = null,
    Object? durable = null,
  }) {
    return _then(_$CancelPaymentRequestDtoImpl(
      senderAccount: null == senderAccount
          ? _value.senderAccount
          : senderAccount // ignore: cast_nullable_to_non_nullable
              as String,
      escrowAccount: null == escrowAccount
          ? _value.escrowAccount
          : escrowAccount // ignore: cast_nullable_to_non_nullable
              as String,
      cluster: null == cluster
          ? _value.cluster
          : cluster // ignore: cast_nullable_to_non_nullable
              as Cluster,
      durable: null == durable
          ? _value.durable
          : durable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CancelPaymentRequestDtoImpl implements _CancelPaymentRequestDto {
  const _$CancelPaymentRequestDtoImpl(
      {required this.senderAccount,
      required this.escrowAccount,
      required this.cluster,
      this.durable = false});

  factory _$CancelPaymentRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CancelPaymentRequestDtoImplFromJson(json);

  @override
  final String senderAccount;
  @override
  final String escrowAccount;
  @override
  final Cluster cluster;
  @override
  @JsonKey()
  final bool durable;

  @override
  String toString() {
    return 'CancelPaymentRequestDto(senderAccount: $senderAccount, escrowAccount: $escrowAccount, cluster: $cluster, durable: $durable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CancelPaymentRequestDtoImpl &&
            (identical(other.senderAccount, senderAccount) ||
                other.senderAccount == senderAccount) &&
            (identical(other.escrowAccount, escrowAccount) ||
                other.escrowAccount == escrowAccount) &&
            (identical(other.cluster, cluster) || other.cluster == cluster) &&
            (identical(other.durable, durable) || other.durable == durable));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, senderAccount, escrowAccount, cluster, durable);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CancelPaymentRequestDtoImplCopyWith<_$CancelPaymentRequestDtoImpl>
      get copyWith => __$$CancelPaymentRequestDtoImplCopyWithImpl<
          _$CancelPaymentRequestDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CancelPaymentRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _CancelPaymentRequestDto implements CancelPaymentRequestDto {
  const factory _CancelPaymentRequestDto(
      {required final String senderAccount,
      required final String escrowAccount,
      required final Cluster cluster,
      final bool durable}) = _$CancelPaymentRequestDtoImpl;

  factory _CancelPaymentRequestDto.fromJson(Map<String, dynamic> json) =
      _$CancelPaymentRequestDtoImpl.fromJson;

  @override
  String get senderAccount;
  @override
  String get escrowAccount;
  @override
  Cluster get cluster;
  @override
  bool get durable;
  @override
  @JsonKey(ignore: true)
  _$$CancelPaymentRequestDtoImplCopyWith<_$CancelPaymentRequestDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

CancelPaymentResponseDto _$CancelPaymentResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _CancelPaymentResponseDto.fromJson(json);
}

/// @nodoc
mixin _$CancelPaymentResponseDto {
  String get transaction => throw _privateConstructorUsedError;
  BigInt get slot => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CancelPaymentResponseDtoCopyWith<CancelPaymentResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CancelPaymentResponseDtoCopyWith<$Res> {
  factory $CancelPaymentResponseDtoCopyWith(CancelPaymentResponseDto value,
          $Res Function(CancelPaymentResponseDto) then) =
      _$CancelPaymentResponseDtoCopyWithImpl<$Res, CancelPaymentResponseDto>;
  @useResult
  $Res call({String transaction, BigInt slot});
}

/// @nodoc
class _$CancelPaymentResponseDtoCopyWithImpl<$Res,
        $Val extends CancelPaymentResponseDto>
    implements $CancelPaymentResponseDtoCopyWith<$Res> {
  _$CancelPaymentResponseDtoCopyWithImpl(this._value, this._then);

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
abstract class _$$CancelPaymentResponseDtoImplCopyWith<$Res>
    implements $CancelPaymentResponseDtoCopyWith<$Res> {
  factory _$$CancelPaymentResponseDtoImplCopyWith(
          _$CancelPaymentResponseDtoImpl value,
          $Res Function(_$CancelPaymentResponseDtoImpl) then) =
      __$$CancelPaymentResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String transaction, BigInt slot});
}

/// @nodoc
class __$$CancelPaymentResponseDtoImplCopyWithImpl<$Res>
    extends _$CancelPaymentResponseDtoCopyWithImpl<$Res,
        _$CancelPaymentResponseDtoImpl>
    implements _$$CancelPaymentResponseDtoImplCopyWith<$Res> {
  __$$CancelPaymentResponseDtoImplCopyWithImpl(
      _$CancelPaymentResponseDtoImpl _value,
      $Res Function(_$CancelPaymentResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transaction = null,
    Object? slot = null,
  }) {
    return _then(_$CancelPaymentResponseDtoImpl(
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
class _$CancelPaymentResponseDtoImpl implements _CancelPaymentResponseDto {
  const _$CancelPaymentResponseDtoImpl(
      {required this.transaction, required this.slot});

  factory _$CancelPaymentResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CancelPaymentResponseDtoImplFromJson(json);

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
  _$$CancelPaymentResponseDtoImplCopyWith<_$CancelPaymentResponseDtoImpl>
      get copyWith => __$$CancelPaymentResponseDtoImplCopyWithImpl<
          _$CancelPaymentResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CancelPaymentResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _CancelPaymentResponseDto implements CancelPaymentResponseDto {
  const factory _CancelPaymentResponseDto(
      {required final String transaction,
      required final BigInt slot}) = _$CancelPaymentResponseDtoImpl;

  factory _CancelPaymentResponseDto.fromJson(Map<String, dynamic> json) =
      _$CancelPaymentResponseDtoImpl.fromJson;

  @override
  String get transaction;
  @override
  BigInt get slot;
  @override
  @JsonKey(ignore: true)
  _$$CancelPaymentResponseDtoImplCopyWith<_$CancelPaymentResponseDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
