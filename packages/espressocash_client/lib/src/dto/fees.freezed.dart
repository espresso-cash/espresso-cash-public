// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fees.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DirectPaymentQuoteRequestDto {
  String get receiverAccount;
  int get amount;
  String get mintAddress;

  /// Create a copy of DirectPaymentQuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DirectPaymentQuoteRequestDtoCopyWith<DirectPaymentQuoteRequestDto> get copyWith =>
      _$DirectPaymentQuoteRequestDtoCopyWithImpl<DirectPaymentQuoteRequestDto>(
        this as DirectPaymentQuoteRequestDto,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DirectPaymentQuoteRequestDto &&
            (identical(other.receiverAccount, receiverAccount) ||
                other.receiverAccount == receiverAccount) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.mintAddress, mintAddress) || other.mintAddress == mintAddress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, receiverAccount, amount, mintAddress);

  @override
  String toString() {
    return 'DirectPaymentQuoteRequestDto(receiverAccount: $receiverAccount, amount: $amount, mintAddress: $mintAddress)';
  }
}

/// @nodoc
abstract mixin class $DirectPaymentQuoteRequestDtoCopyWith<$Res> {
  factory $DirectPaymentQuoteRequestDtoCopyWith(
    DirectPaymentQuoteRequestDto value,
    $Res Function(DirectPaymentQuoteRequestDto) _then,
  ) = _$DirectPaymentQuoteRequestDtoCopyWithImpl;
  @useResult
  $Res call({String receiverAccount, int amount, String mintAddress});
}

/// @nodoc
class _$DirectPaymentQuoteRequestDtoCopyWithImpl<$Res>
    implements $DirectPaymentQuoteRequestDtoCopyWith<$Res> {
  _$DirectPaymentQuoteRequestDtoCopyWithImpl(this._self, this._then);

  final DirectPaymentQuoteRequestDto _self;
  final $Res Function(DirectPaymentQuoteRequestDto) _then;

  /// Create a copy of DirectPaymentQuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? receiverAccount = null, Object? amount = null, Object? mintAddress = null}) {
    return _then(
      _self.copyWith(
        receiverAccount:
            null == receiverAccount
                ? _self.receiverAccount
                : receiverAccount // ignore: cast_nullable_to_non_nullable
                    as String,
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

class _DirectPaymentQuoteRequestDto implements DirectPaymentQuoteRequestDto {
  const _DirectPaymentQuoteRequestDto({
    required this.receiverAccount,
    required this.amount,
    required this.mintAddress,
  });

  @override
  final String receiverAccount;
  @override
  final int amount;
  @override
  final String mintAddress;

  /// Create a copy of DirectPaymentQuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DirectPaymentQuoteRequestDtoCopyWith<_DirectPaymentQuoteRequestDto> get copyWith =>
      __$DirectPaymentQuoteRequestDtoCopyWithImpl<_DirectPaymentQuoteRequestDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DirectPaymentQuoteRequestDto &&
            (identical(other.receiverAccount, receiverAccount) ||
                other.receiverAccount == receiverAccount) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.mintAddress, mintAddress) || other.mintAddress == mintAddress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, receiverAccount, amount, mintAddress);

  @override
  String toString() {
    return 'DirectPaymentQuoteRequestDto(receiverAccount: $receiverAccount, amount: $amount, mintAddress: $mintAddress)';
  }
}

/// @nodoc
abstract mixin class _$DirectPaymentQuoteRequestDtoCopyWith<$Res>
    implements $DirectPaymentQuoteRequestDtoCopyWith<$Res> {
  factory _$DirectPaymentQuoteRequestDtoCopyWith(
    _DirectPaymentQuoteRequestDto value,
    $Res Function(_DirectPaymentQuoteRequestDto) _then,
  ) = __$DirectPaymentQuoteRequestDtoCopyWithImpl;
  @override
  @useResult
  $Res call({String receiverAccount, int amount, String mintAddress});
}

/// @nodoc
class __$DirectPaymentQuoteRequestDtoCopyWithImpl<$Res>
    implements _$DirectPaymentQuoteRequestDtoCopyWith<$Res> {
  __$DirectPaymentQuoteRequestDtoCopyWithImpl(this._self, this._then);

  final _DirectPaymentQuoteRequestDto _self;
  final $Res Function(_DirectPaymentQuoteRequestDto) _then;

  /// Create a copy of DirectPaymentQuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? receiverAccount = null, Object? amount = null, Object? mintAddress = null}) {
    return _then(
      _DirectPaymentQuoteRequestDto(
        receiverAccount:
            null == receiverAccount
                ? _self.receiverAccount
                : receiverAccount // ignore: cast_nullable_to_non_nullable
                    as String,
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
mixin _$DirectPaymentQuoteResponseDto {
  int get fee;
  int get totalAmount;

  /// Create a copy of DirectPaymentQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DirectPaymentQuoteResponseDtoCopyWith<DirectPaymentQuoteResponseDto> get copyWith =>
      _$DirectPaymentQuoteResponseDtoCopyWithImpl<DirectPaymentQuoteResponseDto>(
        this as DirectPaymentQuoteResponseDto,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DirectPaymentQuoteResponseDto &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fee, totalAmount);

  @override
  String toString() {
    return 'DirectPaymentQuoteResponseDto(fee: $fee, totalAmount: $totalAmount)';
  }
}

/// @nodoc
abstract mixin class $DirectPaymentQuoteResponseDtoCopyWith<$Res> {
  factory $DirectPaymentQuoteResponseDtoCopyWith(
    DirectPaymentQuoteResponseDto value,
    $Res Function(DirectPaymentQuoteResponseDto) _then,
  ) = _$DirectPaymentQuoteResponseDtoCopyWithImpl;
  @useResult
  $Res call({int fee, int totalAmount});
}

/// @nodoc
class _$DirectPaymentQuoteResponseDtoCopyWithImpl<$Res>
    implements $DirectPaymentQuoteResponseDtoCopyWith<$Res> {
  _$DirectPaymentQuoteResponseDtoCopyWithImpl(this._self, this._then);

  final DirectPaymentQuoteResponseDto _self;
  final $Res Function(DirectPaymentQuoteResponseDto) _then;

  /// Create a copy of DirectPaymentQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? fee = null, Object? totalAmount = null}) {
    return _then(
      _self.copyWith(
        fee:
            null == fee
                ? _self.fee
                : fee // ignore: cast_nullable_to_non_nullable
                    as int,
        totalAmount:
            null == totalAmount
                ? _self.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _DirectPaymentQuoteResponseDto implements DirectPaymentQuoteResponseDto {
  const _DirectPaymentQuoteResponseDto({required this.fee, required this.totalAmount});

  @override
  final int fee;
  @override
  final int totalAmount;

  /// Create a copy of DirectPaymentQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DirectPaymentQuoteResponseDtoCopyWith<_DirectPaymentQuoteResponseDto> get copyWith =>
      __$DirectPaymentQuoteResponseDtoCopyWithImpl<_DirectPaymentQuoteResponseDto>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DirectPaymentQuoteResponseDto &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fee, totalAmount);

  @override
  String toString() {
    return 'DirectPaymentQuoteResponseDto(fee: $fee, totalAmount: $totalAmount)';
  }
}

/// @nodoc
abstract mixin class _$DirectPaymentQuoteResponseDtoCopyWith<$Res>
    implements $DirectPaymentQuoteResponseDtoCopyWith<$Res> {
  factory _$DirectPaymentQuoteResponseDtoCopyWith(
    _DirectPaymentQuoteResponseDto value,
    $Res Function(_DirectPaymentQuoteResponseDto) _then,
  ) = __$DirectPaymentQuoteResponseDtoCopyWithImpl;
  @override
  @useResult
  $Res call({int fee, int totalAmount});
}

/// @nodoc
class __$DirectPaymentQuoteResponseDtoCopyWithImpl<$Res>
    implements _$DirectPaymentQuoteResponseDtoCopyWith<$Res> {
  __$DirectPaymentQuoteResponseDtoCopyWithImpl(this._self, this._then);

  final _DirectPaymentQuoteResponseDto _self;
  final $Res Function(_DirectPaymentQuoteResponseDto) _then;

  /// Create a copy of DirectPaymentQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? fee = null, Object? totalAmount = null}) {
    return _then(
      _DirectPaymentQuoteResponseDto(
        fee:
            null == fee
                ? _self.fee
                : fee // ignore: cast_nullable_to_non_nullable
                    as int,
        totalAmount:
            null == totalAmount
                ? _self.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
mixin _$EscrowPaymentQuoteResponseDto {
  int get fee;

  /// Create a copy of EscrowPaymentQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EscrowPaymentQuoteResponseDtoCopyWith<EscrowPaymentQuoteResponseDto> get copyWith =>
      _$EscrowPaymentQuoteResponseDtoCopyWithImpl<EscrowPaymentQuoteResponseDto>(
        this as EscrowPaymentQuoteResponseDto,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EscrowPaymentQuoteResponseDto &&
            (identical(other.fee, fee) || other.fee == fee));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fee);

  @override
  String toString() {
    return 'EscrowPaymentQuoteResponseDto(fee: $fee)';
  }
}

/// @nodoc
abstract mixin class $EscrowPaymentQuoteResponseDtoCopyWith<$Res> {
  factory $EscrowPaymentQuoteResponseDtoCopyWith(
    EscrowPaymentQuoteResponseDto value,
    $Res Function(EscrowPaymentQuoteResponseDto) _then,
  ) = _$EscrowPaymentQuoteResponseDtoCopyWithImpl;
  @useResult
  $Res call({int fee});
}

/// @nodoc
class _$EscrowPaymentQuoteResponseDtoCopyWithImpl<$Res>
    implements $EscrowPaymentQuoteResponseDtoCopyWith<$Res> {
  _$EscrowPaymentQuoteResponseDtoCopyWithImpl(this._self, this._then);

  final EscrowPaymentQuoteResponseDto _self;
  final $Res Function(EscrowPaymentQuoteResponseDto) _then;

  /// Create a copy of EscrowPaymentQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? fee = null}) {
    return _then(
      _self.copyWith(
        fee:
            null == fee
                ? _self.fee
                : fee // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _EscrowPaymentQuoteResponseDto implements EscrowPaymentQuoteResponseDto {
  const _EscrowPaymentQuoteResponseDto({required this.fee});

  @override
  final int fee;

  /// Create a copy of EscrowPaymentQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EscrowPaymentQuoteResponseDtoCopyWith<_EscrowPaymentQuoteResponseDto> get copyWith =>
      __$EscrowPaymentQuoteResponseDtoCopyWithImpl<_EscrowPaymentQuoteResponseDto>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EscrowPaymentQuoteResponseDto &&
            (identical(other.fee, fee) || other.fee == fee));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fee);

  @override
  String toString() {
    return 'EscrowPaymentQuoteResponseDto(fee: $fee)';
  }
}

/// @nodoc
abstract mixin class _$EscrowPaymentQuoteResponseDtoCopyWith<$Res>
    implements $EscrowPaymentQuoteResponseDtoCopyWith<$Res> {
  factory _$EscrowPaymentQuoteResponseDtoCopyWith(
    _EscrowPaymentQuoteResponseDto value,
    $Res Function(_EscrowPaymentQuoteResponseDto) _then,
  ) = __$EscrowPaymentQuoteResponseDtoCopyWithImpl;
  @override
  @useResult
  $Res call({int fee});
}

/// @nodoc
class __$EscrowPaymentQuoteResponseDtoCopyWithImpl<$Res>
    implements _$EscrowPaymentQuoteResponseDtoCopyWith<$Res> {
  __$EscrowPaymentQuoteResponseDtoCopyWithImpl(this._self, this._then);

  final _EscrowPaymentQuoteResponseDto _self;
  final $Res Function(_EscrowPaymentQuoteResponseDto) _then;

  /// Create a copy of EscrowPaymentQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? fee = null}) {
    return _then(
      _EscrowPaymentQuoteResponseDto(
        fee:
            null == fee
                ? _self.fee
                : fee // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}
