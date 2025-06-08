// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateDirectPaymentRequestDto {
  String get senderAccount;
  String get receiverAccount;
  String? get referenceAccount;
  int get amount;
  String get mintAddress;

  /// Create a copy of CreateDirectPaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreateDirectPaymentRequestDtoCopyWith<CreateDirectPaymentRequestDto> get copyWith =>
      _$CreateDirectPaymentRequestDtoCopyWithImpl<CreateDirectPaymentRequestDto>(
        this as CreateDirectPaymentRequestDto,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreateDirectPaymentRequestDto &&
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

  @override
  String toString() {
    return 'CreateDirectPaymentRequestDto(senderAccount: $senderAccount, receiverAccount: $receiverAccount, referenceAccount: $referenceAccount, amount: $amount, mintAddress: $mintAddress)';
  }
}

/// @nodoc
abstract mixin class $CreateDirectPaymentRequestDtoCopyWith<$Res> {
  factory $CreateDirectPaymentRequestDtoCopyWith(
    CreateDirectPaymentRequestDto value,
    $Res Function(CreateDirectPaymentRequestDto) _then,
  ) = _$CreateDirectPaymentRequestDtoCopyWithImpl;
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
class _$CreateDirectPaymentRequestDtoCopyWithImpl<$Res>
    implements $CreateDirectPaymentRequestDtoCopyWith<$Res> {
  _$CreateDirectPaymentRequestDtoCopyWithImpl(this._self, this._then);

  final CreateDirectPaymentRequestDto _self;
  final $Res Function(CreateDirectPaymentRequestDto) _then;

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
      _self.copyWith(
        senderAccount:
            null == senderAccount
                ? _self.senderAccount
                : senderAccount // ignore: cast_nullable_to_non_nullable
                    as String,
        receiverAccount:
            null == receiverAccount
                ? _self.receiverAccount
                : receiverAccount // ignore: cast_nullable_to_non_nullable
                    as String,
        referenceAccount:
            freezed == referenceAccount
                ? _self.referenceAccount
                : referenceAccount // ignore: cast_nullable_to_non_nullable
                    as String?,
        amount:
            null == amount
                ? _self.amount
                : amount // ignore: cast_nullable_to_non_nullable
                    as int,
        mintAddress:
            null == mintAddress
                ? _self.mintAddress
                : mintAddress // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _CreateDirectPaymentRequestDto implements CreateDirectPaymentRequestDto {
  const _CreateDirectPaymentRequestDto({
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

  /// Create a copy of CreateDirectPaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CreateDirectPaymentRequestDtoCopyWith<_CreateDirectPaymentRequestDto> get copyWith =>
      __$CreateDirectPaymentRequestDtoCopyWithImpl<_CreateDirectPaymentRequestDto>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CreateDirectPaymentRequestDto &&
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

  @override
  String toString() {
    return 'CreateDirectPaymentRequestDto(senderAccount: $senderAccount, receiverAccount: $receiverAccount, referenceAccount: $referenceAccount, amount: $amount, mintAddress: $mintAddress)';
  }
}

/// @nodoc
abstract mixin class _$CreateDirectPaymentRequestDtoCopyWith<$Res>
    implements $CreateDirectPaymentRequestDtoCopyWith<$Res> {
  factory _$CreateDirectPaymentRequestDtoCopyWith(
    _CreateDirectPaymentRequestDto value,
    $Res Function(_CreateDirectPaymentRequestDto) _then,
  ) = __$CreateDirectPaymentRequestDtoCopyWithImpl;
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
class __$CreateDirectPaymentRequestDtoCopyWithImpl<$Res>
    implements _$CreateDirectPaymentRequestDtoCopyWith<$Res> {
  __$CreateDirectPaymentRequestDtoCopyWithImpl(this._self, this._then);

  final _CreateDirectPaymentRequestDto _self;
  final $Res Function(_CreateDirectPaymentRequestDto) _then;

  /// Create a copy of CreateDirectPaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? senderAccount = null,
    Object? receiverAccount = null,
    Object? referenceAccount = freezed,
    Object? amount = null,
    Object? mintAddress = null,
  }) {
    return _then(
      _CreateDirectPaymentRequestDto(
        senderAccount:
            null == senderAccount
                ? _self.senderAccount
                : senderAccount // ignore: cast_nullable_to_non_nullable
                    as String,
        receiverAccount:
            null == receiverAccount
                ? _self.receiverAccount
                : receiverAccount // ignore: cast_nullable_to_non_nullable
                    as String,
        referenceAccount:
            freezed == referenceAccount
                ? _self.referenceAccount
                : referenceAccount // ignore: cast_nullable_to_non_nullable
                    as String?,
        amount:
            null == amount
                ? _self.amount
                : amount // ignore: cast_nullable_to_non_nullable
                    as int,
        mintAddress:
            null == mintAddress
                ? _self.mintAddress
                : mintAddress // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
mixin _$CreateDirectPaymentResponseDto {
  int get fee;
  String get transaction;
  BigInt get slot;

  /// Create a copy of CreateDirectPaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreateDirectPaymentResponseDtoCopyWith<CreateDirectPaymentResponseDto> get copyWith =>
      _$CreateDirectPaymentResponseDtoCopyWithImpl<CreateDirectPaymentResponseDto>(
        this as CreateDirectPaymentResponseDto,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreateDirectPaymentResponseDto &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.transaction, transaction) || other.transaction == transaction) &&
            (identical(other.slot, slot) || other.slot == slot));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fee, transaction, slot);

  @override
  String toString() {
    return 'CreateDirectPaymentResponseDto(fee: $fee, transaction: $transaction, slot: $slot)';
  }
}

/// @nodoc
abstract mixin class $CreateDirectPaymentResponseDtoCopyWith<$Res> {
  factory $CreateDirectPaymentResponseDtoCopyWith(
    CreateDirectPaymentResponseDto value,
    $Res Function(CreateDirectPaymentResponseDto) _then,
  ) = _$CreateDirectPaymentResponseDtoCopyWithImpl;
  @useResult
  $Res call({int fee, String transaction, BigInt slot});
}

/// @nodoc
class _$CreateDirectPaymentResponseDtoCopyWithImpl<$Res>
    implements $CreateDirectPaymentResponseDtoCopyWith<$Res> {
  _$CreateDirectPaymentResponseDtoCopyWithImpl(this._self, this._then);

  final CreateDirectPaymentResponseDto _self;
  final $Res Function(CreateDirectPaymentResponseDto) _then;

  /// Create a copy of CreateDirectPaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? fee = null, Object? transaction = null, Object? slot = null}) {
    return _then(
      _self.copyWith(
        fee:
            null == fee
                ? _self.fee
                : fee // ignore: cast_nullable_to_non_nullable
                    as int,
        transaction:
            null == transaction
                ? _self.transaction
                : transaction // ignore: cast_nullable_to_non_nullable
                    as String,
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

class _CreateDirectPaymentResponseDto implements CreateDirectPaymentResponseDto {
  const _CreateDirectPaymentResponseDto({
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

  /// Create a copy of CreateDirectPaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CreateDirectPaymentResponseDtoCopyWith<_CreateDirectPaymentResponseDto> get copyWith =>
      __$CreateDirectPaymentResponseDtoCopyWithImpl<_CreateDirectPaymentResponseDto>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CreateDirectPaymentResponseDto &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.transaction, transaction) || other.transaction == transaction) &&
            (identical(other.slot, slot) || other.slot == slot));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fee, transaction, slot);

  @override
  String toString() {
    return 'CreateDirectPaymentResponseDto(fee: $fee, transaction: $transaction, slot: $slot)';
  }
}

/// @nodoc
abstract mixin class _$CreateDirectPaymentResponseDtoCopyWith<$Res>
    implements $CreateDirectPaymentResponseDtoCopyWith<$Res> {
  factory _$CreateDirectPaymentResponseDtoCopyWith(
    _CreateDirectPaymentResponseDto value,
    $Res Function(_CreateDirectPaymentResponseDto) _then,
  ) = __$CreateDirectPaymentResponseDtoCopyWithImpl;
  @override
  @useResult
  $Res call({int fee, String transaction, BigInt slot});
}

/// @nodoc
class __$CreateDirectPaymentResponseDtoCopyWithImpl<$Res>
    implements _$CreateDirectPaymentResponseDtoCopyWith<$Res> {
  __$CreateDirectPaymentResponseDtoCopyWithImpl(this._self, this._then);

  final _CreateDirectPaymentResponseDto _self;
  final $Res Function(_CreateDirectPaymentResponseDto) _then;

  /// Create a copy of CreateDirectPaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? fee = null, Object? transaction = null, Object? slot = null}) {
    return _then(
      _CreateDirectPaymentResponseDto(
        fee:
            null == fee
                ? _self.fee
                : fee // ignore: cast_nullable_to_non_nullable
                    as int,
        transaction:
            null == transaction
                ? _self.transaction
                : transaction // ignore: cast_nullable_to_non_nullable
                    as String,
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
mixin _$CreatePaymentRequestDto {
  String get senderAccount;
  String get escrowAccount;
  int get amount;

  /// Create a copy of CreatePaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreatePaymentRequestDtoCopyWith<CreatePaymentRequestDto> get copyWith =>
      _$CreatePaymentRequestDtoCopyWithImpl<CreatePaymentRequestDto>(
        this as CreatePaymentRequestDto,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreatePaymentRequestDto &&
            (identical(other.senderAccount, senderAccount) ||
                other.senderAccount == senderAccount) &&
            (identical(other.escrowAccount, escrowAccount) ||
                other.escrowAccount == escrowAccount) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, senderAccount, escrowAccount, amount);

  @override
  String toString() {
    return 'CreatePaymentRequestDto(senderAccount: $senderAccount, escrowAccount: $escrowAccount, amount: $amount)';
  }
}

/// @nodoc
abstract mixin class $CreatePaymentRequestDtoCopyWith<$Res> {
  factory $CreatePaymentRequestDtoCopyWith(
    CreatePaymentRequestDto value,
    $Res Function(CreatePaymentRequestDto) _then,
  ) = _$CreatePaymentRequestDtoCopyWithImpl;
  @useResult
  $Res call({String senderAccount, String escrowAccount, int amount});
}

/// @nodoc
class _$CreatePaymentRequestDtoCopyWithImpl<$Res>
    implements $CreatePaymentRequestDtoCopyWith<$Res> {
  _$CreatePaymentRequestDtoCopyWithImpl(this._self, this._then);

  final CreatePaymentRequestDto _self;
  final $Res Function(CreatePaymentRequestDto) _then;

  /// Create a copy of CreatePaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? senderAccount = null, Object? escrowAccount = null, Object? amount = null}) {
    return _then(
      _self.copyWith(
        senderAccount:
            null == senderAccount
                ? _self.senderAccount
                : senderAccount // ignore: cast_nullable_to_non_nullable
                    as String,
        escrowAccount:
            null == escrowAccount
                ? _self.escrowAccount
                : escrowAccount // ignore: cast_nullable_to_non_nullable
                    as String,
        amount:
            null == amount
                ? _self.amount
                : amount // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _CreatePaymentRequestDto implements CreatePaymentRequestDto {
  const _CreatePaymentRequestDto({
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

  /// Create a copy of CreatePaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CreatePaymentRequestDtoCopyWith<_CreatePaymentRequestDto> get copyWith =>
      __$CreatePaymentRequestDtoCopyWithImpl<_CreatePaymentRequestDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CreatePaymentRequestDto &&
            (identical(other.senderAccount, senderAccount) ||
                other.senderAccount == senderAccount) &&
            (identical(other.escrowAccount, escrowAccount) ||
                other.escrowAccount == escrowAccount) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, senderAccount, escrowAccount, amount);

  @override
  String toString() {
    return 'CreatePaymentRequestDto(senderAccount: $senderAccount, escrowAccount: $escrowAccount, amount: $amount)';
  }
}

/// @nodoc
abstract mixin class _$CreatePaymentRequestDtoCopyWith<$Res>
    implements $CreatePaymentRequestDtoCopyWith<$Res> {
  factory _$CreatePaymentRequestDtoCopyWith(
    _CreatePaymentRequestDto value,
    $Res Function(_CreatePaymentRequestDto) _then,
  ) = __$CreatePaymentRequestDtoCopyWithImpl;
  @override
  @useResult
  $Res call({String senderAccount, String escrowAccount, int amount});
}

/// @nodoc
class __$CreatePaymentRequestDtoCopyWithImpl<$Res>
    implements _$CreatePaymentRequestDtoCopyWith<$Res> {
  __$CreatePaymentRequestDtoCopyWithImpl(this._self, this._then);

  final _CreatePaymentRequestDto _self;
  final $Res Function(_CreatePaymentRequestDto) _then;

  /// Create a copy of CreatePaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? senderAccount = null, Object? escrowAccount = null, Object? amount = null}) {
    return _then(
      _CreatePaymentRequestDto(
        senderAccount:
            null == senderAccount
                ? _self.senderAccount
                : senderAccount // ignore: cast_nullable_to_non_nullable
                    as String,
        escrowAccount:
            null == escrowAccount
                ? _self.escrowAccount
                : escrowAccount // ignore: cast_nullable_to_non_nullable
                    as String,
        amount:
            null == amount
                ? _self.amount
                : amount // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
mixin _$CreatePaymentResponseDto {
  String get transaction;
  BigInt get slot;

  /// Create a copy of CreatePaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreatePaymentResponseDtoCopyWith<CreatePaymentResponseDto> get copyWith =>
      _$CreatePaymentResponseDtoCopyWithImpl<CreatePaymentResponseDto>(
        this as CreatePaymentResponseDto,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreatePaymentResponseDto &&
            (identical(other.transaction, transaction) || other.transaction == transaction) &&
            (identical(other.slot, slot) || other.slot == slot));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transaction, slot);

  @override
  String toString() {
    return 'CreatePaymentResponseDto(transaction: $transaction, slot: $slot)';
  }
}

/// @nodoc
abstract mixin class $CreatePaymentResponseDtoCopyWith<$Res> {
  factory $CreatePaymentResponseDtoCopyWith(
    CreatePaymentResponseDto value,
    $Res Function(CreatePaymentResponseDto) _then,
  ) = _$CreatePaymentResponseDtoCopyWithImpl;
  @useResult
  $Res call({String transaction, BigInt slot});
}

/// @nodoc
class _$CreatePaymentResponseDtoCopyWithImpl<$Res>
    implements $CreatePaymentResponseDtoCopyWith<$Res> {
  _$CreatePaymentResponseDtoCopyWithImpl(this._self, this._then);

  final CreatePaymentResponseDto _self;
  final $Res Function(CreatePaymentResponseDto) _then;

  /// Create a copy of CreatePaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? transaction = null, Object? slot = null}) {
    return _then(
      _self.copyWith(
        transaction:
            null == transaction
                ? _self.transaction
                : transaction // ignore: cast_nullable_to_non_nullable
                    as String,
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

class _CreatePaymentResponseDto implements CreatePaymentResponseDto {
  const _CreatePaymentResponseDto({required this.transaction, required this.slot});

  @override
  final String transaction;
  @override
  final BigInt slot;

  /// Create a copy of CreatePaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CreatePaymentResponseDtoCopyWith<_CreatePaymentResponseDto> get copyWith =>
      __$CreatePaymentResponseDtoCopyWithImpl<_CreatePaymentResponseDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CreatePaymentResponseDto &&
            (identical(other.transaction, transaction) || other.transaction == transaction) &&
            (identical(other.slot, slot) || other.slot == slot));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transaction, slot);

  @override
  String toString() {
    return 'CreatePaymentResponseDto(transaction: $transaction, slot: $slot)';
  }
}

/// @nodoc
abstract mixin class _$CreatePaymentResponseDtoCopyWith<$Res>
    implements $CreatePaymentResponseDtoCopyWith<$Res> {
  factory _$CreatePaymentResponseDtoCopyWith(
    _CreatePaymentResponseDto value,
    $Res Function(_CreatePaymentResponseDto) _then,
  ) = __$CreatePaymentResponseDtoCopyWithImpl;
  @override
  @useResult
  $Res call({String transaction, BigInt slot});
}

/// @nodoc
class __$CreatePaymentResponseDtoCopyWithImpl<$Res>
    implements _$CreatePaymentResponseDtoCopyWith<$Res> {
  __$CreatePaymentResponseDtoCopyWithImpl(this._self, this._then);

  final _CreatePaymentResponseDto _self;
  final $Res Function(_CreatePaymentResponseDto) _then;

  /// Create a copy of CreatePaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? transaction = null, Object? slot = null}) {
    return _then(
      _CreatePaymentResponseDto(
        transaction:
            null == transaction
                ? _self.transaction
                : transaction // ignore: cast_nullable_to_non_nullable
                    as String,
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
mixin _$ReceivePaymentRequestDto {
  String get receiverAccount;
  String get escrowAccount;

  /// Create a copy of ReceivePaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReceivePaymentRequestDtoCopyWith<ReceivePaymentRequestDto> get copyWith =>
      _$ReceivePaymentRequestDtoCopyWithImpl<ReceivePaymentRequestDto>(
        this as ReceivePaymentRequestDto,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReceivePaymentRequestDto &&
            (identical(other.receiverAccount, receiverAccount) ||
                other.receiverAccount == receiverAccount) &&
            (identical(other.escrowAccount, escrowAccount) ||
                other.escrowAccount == escrowAccount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, receiverAccount, escrowAccount);

  @override
  String toString() {
    return 'ReceivePaymentRequestDto(receiverAccount: $receiverAccount, escrowAccount: $escrowAccount)';
  }
}

/// @nodoc
abstract mixin class $ReceivePaymentRequestDtoCopyWith<$Res> {
  factory $ReceivePaymentRequestDtoCopyWith(
    ReceivePaymentRequestDto value,
    $Res Function(ReceivePaymentRequestDto) _then,
  ) = _$ReceivePaymentRequestDtoCopyWithImpl;
  @useResult
  $Res call({String receiverAccount, String escrowAccount});
}

/// @nodoc
class _$ReceivePaymentRequestDtoCopyWithImpl<$Res>
    implements $ReceivePaymentRequestDtoCopyWith<$Res> {
  _$ReceivePaymentRequestDtoCopyWithImpl(this._self, this._then);

  final ReceivePaymentRequestDto _self;
  final $Res Function(ReceivePaymentRequestDto) _then;

  /// Create a copy of ReceivePaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? receiverAccount = null, Object? escrowAccount = null}) {
    return _then(
      _self.copyWith(
        receiverAccount:
            null == receiverAccount
                ? _self.receiverAccount
                : receiverAccount // ignore: cast_nullable_to_non_nullable
                    as String,
        escrowAccount:
            null == escrowAccount
                ? _self.escrowAccount
                : escrowAccount // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _ReceivePaymentRequestDto implements ReceivePaymentRequestDto {
  const _ReceivePaymentRequestDto({required this.receiverAccount, required this.escrowAccount});

  @override
  final String receiverAccount;
  @override
  final String escrowAccount;

  /// Create a copy of ReceivePaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReceivePaymentRequestDtoCopyWith<_ReceivePaymentRequestDto> get copyWith =>
      __$ReceivePaymentRequestDtoCopyWithImpl<_ReceivePaymentRequestDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReceivePaymentRequestDto &&
            (identical(other.receiverAccount, receiverAccount) ||
                other.receiverAccount == receiverAccount) &&
            (identical(other.escrowAccount, escrowAccount) ||
                other.escrowAccount == escrowAccount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, receiverAccount, escrowAccount);

  @override
  String toString() {
    return 'ReceivePaymentRequestDto(receiverAccount: $receiverAccount, escrowAccount: $escrowAccount)';
  }
}

/// @nodoc
abstract mixin class _$ReceivePaymentRequestDtoCopyWith<$Res>
    implements $ReceivePaymentRequestDtoCopyWith<$Res> {
  factory _$ReceivePaymentRequestDtoCopyWith(
    _ReceivePaymentRequestDto value,
    $Res Function(_ReceivePaymentRequestDto) _then,
  ) = __$ReceivePaymentRequestDtoCopyWithImpl;
  @override
  @useResult
  $Res call({String receiverAccount, String escrowAccount});
}

/// @nodoc
class __$ReceivePaymentRequestDtoCopyWithImpl<$Res>
    implements _$ReceivePaymentRequestDtoCopyWith<$Res> {
  __$ReceivePaymentRequestDtoCopyWithImpl(this._self, this._then);

  final _ReceivePaymentRequestDto _self;
  final $Res Function(_ReceivePaymentRequestDto) _then;

  /// Create a copy of ReceivePaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? receiverAccount = null, Object? escrowAccount = null}) {
    return _then(
      _ReceivePaymentRequestDto(
        receiverAccount:
            null == receiverAccount
                ? _self.receiverAccount
                : receiverAccount // ignore: cast_nullable_to_non_nullable
                    as String,
        escrowAccount:
            null == escrowAccount
                ? _self.escrowAccount
                : escrowAccount // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
mixin _$ReceivePaymentResponseDto {
  String get transaction;
  BigInt get slot;

  /// Create a copy of ReceivePaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReceivePaymentResponseDtoCopyWith<ReceivePaymentResponseDto> get copyWith =>
      _$ReceivePaymentResponseDtoCopyWithImpl<ReceivePaymentResponseDto>(
        this as ReceivePaymentResponseDto,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReceivePaymentResponseDto &&
            (identical(other.transaction, transaction) || other.transaction == transaction) &&
            (identical(other.slot, slot) || other.slot == slot));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transaction, slot);

  @override
  String toString() {
    return 'ReceivePaymentResponseDto(transaction: $transaction, slot: $slot)';
  }
}

/// @nodoc
abstract mixin class $ReceivePaymentResponseDtoCopyWith<$Res> {
  factory $ReceivePaymentResponseDtoCopyWith(
    ReceivePaymentResponseDto value,
    $Res Function(ReceivePaymentResponseDto) _then,
  ) = _$ReceivePaymentResponseDtoCopyWithImpl;
  @useResult
  $Res call({String transaction, BigInt slot});
}

/// @nodoc
class _$ReceivePaymentResponseDtoCopyWithImpl<$Res>
    implements $ReceivePaymentResponseDtoCopyWith<$Res> {
  _$ReceivePaymentResponseDtoCopyWithImpl(this._self, this._then);

  final ReceivePaymentResponseDto _self;
  final $Res Function(ReceivePaymentResponseDto) _then;

  /// Create a copy of ReceivePaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? transaction = null, Object? slot = null}) {
    return _then(
      _self.copyWith(
        transaction:
            null == transaction
                ? _self.transaction
                : transaction // ignore: cast_nullable_to_non_nullable
                    as String,
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

class _ReceivePaymentResponseDto implements ReceivePaymentResponseDto {
  const _ReceivePaymentResponseDto({required this.transaction, required this.slot});

  @override
  final String transaction;
  @override
  final BigInt slot;

  /// Create a copy of ReceivePaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReceivePaymentResponseDtoCopyWith<_ReceivePaymentResponseDto> get copyWith =>
      __$ReceivePaymentResponseDtoCopyWithImpl<_ReceivePaymentResponseDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReceivePaymentResponseDto &&
            (identical(other.transaction, transaction) || other.transaction == transaction) &&
            (identical(other.slot, slot) || other.slot == slot));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transaction, slot);

  @override
  String toString() {
    return 'ReceivePaymentResponseDto(transaction: $transaction, slot: $slot)';
  }
}

/// @nodoc
abstract mixin class _$ReceivePaymentResponseDtoCopyWith<$Res>
    implements $ReceivePaymentResponseDtoCopyWith<$Res> {
  factory _$ReceivePaymentResponseDtoCopyWith(
    _ReceivePaymentResponseDto value,
    $Res Function(_ReceivePaymentResponseDto) _then,
  ) = __$ReceivePaymentResponseDtoCopyWithImpl;
  @override
  @useResult
  $Res call({String transaction, BigInt slot});
}

/// @nodoc
class __$ReceivePaymentResponseDtoCopyWithImpl<$Res>
    implements _$ReceivePaymentResponseDtoCopyWith<$Res> {
  __$ReceivePaymentResponseDtoCopyWithImpl(this._self, this._then);

  final _ReceivePaymentResponseDto _self;
  final $Res Function(_ReceivePaymentResponseDto) _then;

  /// Create a copy of ReceivePaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? transaction = null, Object? slot = null}) {
    return _then(
      _ReceivePaymentResponseDto(
        transaction:
            null == transaction
                ? _self.transaction
                : transaction // ignore: cast_nullable_to_non_nullable
                    as String,
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
mixin _$CancelPaymentRequestDto {
  String get senderAccount;
  String get escrowAccount;

  /// Create a copy of CancelPaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CancelPaymentRequestDtoCopyWith<CancelPaymentRequestDto> get copyWith =>
      _$CancelPaymentRequestDtoCopyWithImpl<CancelPaymentRequestDto>(
        this as CancelPaymentRequestDto,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CancelPaymentRequestDto &&
            (identical(other.senderAccount, senderAccount) ||
                other.senderAccount == senderAccount) &&
            (identical(other.escrowAccount, escrowAccount) ||
                other.escrowAccount == escrowAccount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, senderAccount, escrowAccount);

  @override
  String toString() {
    return 'CancelPaymentRequestDto(senderAccount: $senderAccount, escrowAccount: $escrowAccount)';
  }
}

/// @nodoc
abstract mixin class $CancelPaymentRequestDtoCopyWith<$Res> {
  factory $CancelPaymentRequestDtoCopyWith(
    CancelPaymentRequestDto value,
    $Res Function(CancelPaymentRequestDto) _then,
  ) = _$CancelPaymentRequestDtoCopyWithImpl;
  @useResult
  $Res call({String senderAccount, String escrowAccount});
}

/// @nodoc
class _$CancelPaymentRequestDtoCopyWithImpl<$Res>
    implements $CancelPaymentRequestDtoCopyWith<$Res> {
  _$CancelPaymentRequestDtoCopyWithImpl(this._self, this._then);

  final CancelPaymentRequestDto _self;
  final $Res Function(CancelPaymentRequestDto) _then;

  /// Create a copy of CancelPaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? senderAccount = null, Object? escrowAccount = null}) {
    return _then(
      _self.copyWith(
        senderAccount:
            null == senderAccount
                ? _self.senderAccount
                : senderAccount // ignore: cast_nullable_to_non_nullable
                    as String,
        escrowAccount:
            null == escrowAccount
                ? _self.escrowAccount
                : escrowAccount // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _CancelPaymentRequestDto implements CancelPaymentRequestDto {
  const _CancelPaymentRequestDto({required this.senderAccount, required this.escrowAccount});

  @override
  final String senderAccount;
  @override
  final String escrowAccount;

  /// Create a copy of CancelPaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CancelPaymentRequestDtoCopyWith<_CancelPaymentRequestDto> get copyWith =>
      __$CancelPaymentRequestDtoCopyWithImpl<_CancelPaymentRequestDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CancelPaymentRequestDto &&
            (identical(other.senderAccount, senderAccount) ||
                other.senderAccount == senderAccount) &&
            (identical(other.escrowAccount, escrowAccount) ||
                other.escrowAccount == escrowAccount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, senderAccount, escrowAccount);

  @override
  String toString() {
    return 'CancelPaymentRequestDto(senderAccount: $senderAccount, escrowAccount: $escrowAccount)';
  }
}

/// @nodoc
abstract mixin class _$CancelPaymentRequestDtoCopyWith<$Res>
    implements $CancelPaymentRequestDtoCopyWith<$Res> {
  factory _$CancelPaymentRequestDtoCopyWith(
    _CancelPaymentRequestDto value,
    $Res Function(_CancelPaymentRequestDto) _then,
  ) = __$CancelPaymentRequestDtoCopyWithImpl;
  @override
  @useResult
  $Res call({String senderAccount, String escrowAccount});
}

/// @nodoc
class __$CancelPaymentRequestDtoCopyWithImpl<$Res>
    implements _$CancelPaymentRequestDtoCopyWith<$Res> {
  __$CancelPaymentRequestDtoCopyWithImpl(this._self, this._then);

  final _CancelPaymentRequestDto _self;
  final $Res Function(_CancelPaymentRequestDto) _then;

  /// Create a copy of CancelPaymentRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? senderAccount = null, Object? escrowAccount = null}) {
    return _then(
      _CancelPaymentRequestDto(
        senderAccount:
            null == senderAccount
                ? _self.senderAccount
                : senderAccount // ignore: cast_nullable_to_non_nullable
                    as String,
        escrowAccount:
            null == escrowAccount
                ? _self.escrowAccount
                : escrowAccount // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
mixin _$CancelPaymentResponseDto {
  String get transaction;
  BigInt get slot;

  /// Create a copy of CancelPaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CancelPaymentResponseDtoCopyWith<CancelPaymentResponseDto> get copyWith =>
      _$CancelPaymentResponseDtoCopyWithImpl<CancelPaymentResponseDto>(
        this as CancelPaymentResponseDto,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CancelPaymentResponseDto &&
            (identical(other.transaction, transaction) || other.transaction == transaction) &&
            (identical(other.slot, slot) || other.slot == slot));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transaction, slot);

  @override
  String toString() {
    return 'CancelPaymentResponseDto(transaction: $transaction, slot: $slot)';
  }
}

/// @nodoc
abstract mixin class $CancelPaymentResponseDtoCopyWith<$Res> {
  factory $CancelPaymentResponseDtoCopyWith(
    CancelPaymentResponseDto value,
    $Res Function(CancelPaymentResponseDto) _then,
  ) = _$CancelPaymentResponseDtoCopyWithImpl;
  @useResult
  $Res call({String transaction, BigInt slot});
}

/// @nodoc
class _$CancelPaymentResponseDtoCopyWithImpl<$Res>
    implements $CancelPaymentResponseDtoCopyWith<$Res> {
  _$CancelPaymentResponseDtoCopyWithImpl(this._self, this._then);

  final CancelPaymentResponseDto _self;
  final $Res Function(CancelPaymentResponseDto) _then;

  /// Create a copy of CancelPaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? transaction = null, Object? slot = null}) {
    return _then(
      _self.copyWith(
        transaction:
            null == transaction
                ? _self.transaction
                : transaction // ignore: cast_nullable_to_non_nullable
                    as String,
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

class _CancelPaymentResponseDto implements CancelPaymentResponseDto {
  const _CancelPaymentResponseDto({required this.transaction, required this.slot});

  @override
  final String transaction;
  @override
  final BigInt slot;

  /// Create a copy of CancelPaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CancelPaymentResponseDtoCopyWith<_CancelPaymentResponseDto> get copyWith =>
      __$CancelPaymentResponseDtoCopyWithImpl<_CancelPaymentResponseDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CancelPaymentResponseDto &&
            (identical(other.transaction, transaction) || other.transaction == transaction) &&
            (identical(other.slot, slot) || other.slot == slot));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transaction, slot);

  @override
  String toString() {
    return 'CancelPaymentResponseDto(transaction: $transaction, slot: $slot)';
  }
}

/// @nodoc
abstract mixin class _$CancelPaymentResponseDtoCopyWith<$Res>
    implements $CancelPaymentResponseDtoCopyWith<$Res> {
  factory _$CancelPaymentResponseDtoCopyWith(
    _CancelPaymentResponseDto value,
    $Res Function(_CancelPaymentResponseDto) _then,
  ) = __$CancelPaymentResponseDtoCopyWithImpl;
  @override
  @useResult
  $Res call({String transaction, BigInt slot});
}

/// @nodoc
class __$CancelPaymentResponseDtoCopyWithImpl<$Res>
    implements _$CancelPaymentResponseDtoCopyWith<$Res> {
  __$CancelPaymentResponseDtoCopyWithImpl(this._self, this._then);

  final _CancelPaymentResponseDto _self;
  final $Res Function(_CancelPaymentResponseDto) _then;

  /// Create a copy of CancelPaymentResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? transaction = null, Object? slot = null}) {
    return _then(
      _CancelPaymentResponseDto(
        transaction:
            null == transaction
                ? _self.transaction
                : transaction // ignore: cast_nullable_to_non_nullable
                    as String,
        slot:
            null == slot
                ? _self.slot
                : slot // ignore: cast_nullable_to_non_nullable
                    as BigInt,
      ),
    );
  }
}
