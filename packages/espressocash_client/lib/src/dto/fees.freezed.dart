// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fees.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DirectPaymentQuoteRequestDto {
  String get receiverAccount => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  String get mintAddress => throw _privateConstructorUsedError;

  /// Create a copy of DirectPaymentQuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DirectPaymentQuoteRequestDtoCopyWith<DirectPaymentQuoteRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DirectPaymentQuoteRequestDtoCopyWith<$Res> {
  factory $DirectPaymentQuoteRequestDtoCopyWith(
    DirectPaymentQuoteRequestDto value,
    $Res Function(DirectPaymentQuoteRequestDto) then,
  ) = _$DirectPaymentQuoteRequestDtoCopyWithImpl<$Res, DirectPaymentQuoteRequestDto>;
  @useResult
  $Res call({String receiverAccount, int amount, String mintAddress});
}

/// @nodoc
class _$DirectPaymentQuoteRequestDtoCopyWithImpl<$Res, $Val extends DirectPaymentQuoteRequestDto>
    implements $DirectPaymentQuoteRequestDtoCopyWith<$Res> {
  _$DirectPaymentQuoteRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DirectPaymentQuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? receiverAccount = null, Object? amount = null, Object? mintAddress = null}) {
    return _then(
      _value.copyWith(
            receiverAccount:
                null == receiverAccount
                    ? _value.receiverAccount
                    : receiverAccount // ignore: cast_nullable_to_non_nullable
                        as String,
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
abstract class _$$DirectPaymentQuoteRequestDtoImplCopyWith<$Res>
    implements $DirectPaymentQuoteRequestDtoCopyWith<$Res> {
  factory _$$DirectPaymentQuoteRequestDtoImplCopyWith(
    _$DirectPaymentQuoteRequestDtoImpl value,
    $Res Function(_$DirectPaymentQuoteRequestDtoImpl) then,
  ) = __$$DirectPaymentQuoteRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String receiverAccount, int amount, String mintAddress});
}

/// @nodoc
class __$$DirectPaymentQuoteRequestDtoImplCopyWithImpl<$Res>
    extends _$DirectPaymentQuoteRequestDtoCopyWithImpl<$Res, _$DirectPaymentQuoteRequestDtoImpl>
    implements _$$DirectPaymentQuoteRequestDtoImplCopyWith<$Res> {
  __$$DirectPaymentQuoteRequestDtoImplCopyWithImpl(
    _$DirectPaymentQuoteRequestDtoImpl _value,
    $Res Function(_$DirectPaymentQuoteRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DirectPaymentQuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? receiverAccount = null, Object? amount = null, Object? mintAddress = null}) {
    return _then(
      _$DirectPaymentQuoteRequestDtoImpl(
        receiverAccount:
            null == receiverAccount
                ? _value.receiverAccount
                : receiverAccount // ignore: cast_nullable_to_non_nullable
                    as String,
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

class _$DirectPaymentQuoteRequestDtoImpl implements _DirectPaymentQuoteRequestDto {
  const _$DirectPaymentQuoteRequestDtoImpl({
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

  @override
  String toString() {
    return 'DirectPaymentQuoteRequestDto(receiverAccount: $receiverAccount, amount: $amount, mintAddress: $mintAddress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DirectPaymentQuoteRequestDtoImpl &&
            (identical(other.receiverAccount, receiverAccount) ||
                other.receiverAccount == receiverAccount) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.mintAddress, mintAddress) || other.mintAddress == mintAddress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, receiverAccount, amount, mintAddress);

  /// Create a copy of DirectPaymentQuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DirectPaymentQuoteRequestDtoImplCopyWith<_$DirectPaymentQuoteRequestDtoImpl> get copyWith =>
      __$$DirectPaymentQuoteRequestDtoImplCopyWithImpl<_$DirectPaymentQuoteRequestDtoImpl>(
        this,
        _$identity,
      );
}

abstract class _DirectPaymentQuoteRequestDto implements DirectPaymentQuoteRequestDto {
  const factory _DirectPaymentQuoteRequestDto({
    required final String receiverAccount,
    required final int amount,
    required final String mintAddress,
  }) = _$DirectPaymentQuoteRequestDtoImpl;

  @override
  String get receiverAccount;
  @override
  int get amount;
  @override
  String get mintAddress;

  /// Create a copy of DirectPaymentQuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DirectPaymentQuoteRequestDtoImplCopyWith<_$DirectPaymentQuoteRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DirectPaymentQuoteResponseDto {
  int get fee => throw _privateConstructorUsedError;
  int get totalAmount => throw _privateConstructorUsedError;

  /// Create a copy of DirectPaymentQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DirectPaymentQuoteResponseDtoCopyWith<DirectPaymentQuoteResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DirectPaymentQuoteResponseDtoCopyWith<$Res> {
  factory $DirectPaymentQuoteResponseDtoCopyWith(
    DirectPaymentQuoteResponseDto value,
    $Res Function(DirectPaymentQuoteResponseDto) then,
  ) = _$DirectPaymentQuoteResponseDtoCopyWithImpl<$Res, DirectPaymentQuoteResponseDto>;
  @useResult
  $Res call({int fee, int totalAmount});
}

/// @nodoc
class _$DirectPaymentQuoteResponseDtoCopyWithImpl<$Res, $Val extends DirectPaymentQuoteResponseDto>
    implements $DirectPaymentQuoteResponseDtoCopyWith<$Res> {
  _$DirectPaymentQuoteResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DirectPaymentQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? fee = null, Object? totalAmount = null}) {
    return _then(
      _value.copyWith(
            fee:
                null == fee
                    ? _value.fee
                    : fee // ignore: cast_nullable_to_non_nullable
                        as int,
            totalAmount:
                null == totalAmount
                    ? _value.totalAmount
                    : totalAmount // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DirectPaymentQuoteResponseDtoImplCopyWith<$Res>
    implements $DirectPaymentQuoteResponseDtoCopyWith<$Res> {
  factory _$$DirectPaymentQuoteResponseDtoImplCopyWith(
    _$DirectPaymentQuoteResponseDtoImpl value,
    $Res Function(_$DirectPaymentQuoteResponseDtoImpl) then,
  ) = __$$DirectPaymentQuoteResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int fee, int totalAmount});
}

/// @nodoc
class __$$DirectPaymentQuoteResponseDtoImplCopyWithImpl<$Res>
    extends _$DirectPaymentQuoteResponseDtoCopyWithImpl<$Res, _$DirectPaymentQuoteResponseDtoImpl>
    implements _$$DirectPaymentQuoteResponseDtoImplCopyWith<$Res> {
  __$$DirectPaymentQuoteResponseDtoImplCopyWithImpl(
    _$DirectPaymentQuoteResponseDtoImpl _value,
    $Res Function(_$DirectPaymentQuoteResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DirectPaymentQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? fee = null, Object? totalAmount = null}) {
    return _then(
      _$DirectPaymentQuoteResponseDtoImpl(
        fee:
            null == fee
                ? _value.fee
                : fee // ignore: cast_nullable_to_non_nullable
                    as int,
        totalAmount:
            null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _$DirectPaymentQuoteResponseDtoImpl implements _DirectPaymentQuoteResponseDto {
  const _$DirectPaymentQuoteResponseDtoImpl({required this.fee, required this.totalAmount});

  @override
  final int fee;
  @override
  final int totalAmount;

  @override
  String toString() {
    return 'DirectPaymentQuoteResponseDto(fee: $fee, totalAmount: $totalAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DirectPaymentQuoteResponseDtoImpl &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fee, totalAmount);

  /// Create a copy of DirectPaymentQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DirectPaymentQuoteResponseDtoImplCopyWith<_$DirectPaymentQuoteResponseDtoImpl> get copyWith =>
      __$$DirectPaymentQuoteResponseDtoImplCopyWithImpl<_$DirectPaymentQuoteResponseDtoImpl>(
        this,
        _$identity,
      );
}

abstract class _DirectPaymentQuoteResponseDto implements DirectPaymentQuoteResponseDto {
  const factory _DirectPaymentQuoteResponseDto({
    required final int fee,
    required final int totalAmount,
  }) = _$DirectPaymentQuoteResponseDtoImpl;

  @override
  int get fee;
  @override
  int get totalAmount;

  /// Create a copy of DirectPaymentQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DirectPaymentQuoteResponseDtoImplCopyWith<_$DirectPaymentQuoteResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EscrowPaymentQuoteResponseDto {
  int get fee => throw _privateConstructorUsedError;

  /// Create a copy of EscrowPaymentQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EscrowPaymentQuoteResponseDtoCopyWith<EscrowPaymentQuoteResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EscrowPaymentQuoteResponseDtoCopyWith<$Res> {
  factory $EscrowPaymentQuoteResponseDtoCopyWith(
    EscrowPaymentQuoteResponseDto value,
    $Res Function(EscrowPaymentQuoteResponseDto) then,
  ) = _$EscrowPaymentQuoteResponseDtoCopyWithImpl<$Res, EscrowPaymentQuoteResponseDto>;
  @useResult
  $Res call({int fee});
}

/// @nodoc
class _$EscrowPaymentQuoteResponseDtoCopyWithImpl<$Res, $Val extends EscrowPaymentQuoteResponseDto>
    implements $EscrowPaymentQuoteResponseDtoCopyWith<$Res> {
  _$EscrowPaymentQuoteResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EscrowPaymentQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? fee = null}) {
    return _then(
      _value.copyWith(
            fee:
                null == fee
                    ? _value.fee
                    : fee // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EscrowPaymentQuoteResponseDtoImplCopyWith<$Res>
    implements $EscrowPaymentQuoteResponseDtoCopyWith<$Res> {
  factory _$$EscrowPaymentQuoteResponseDtoImplCopyWith(
    _$EscrowPaymentQuoteResponseDtoImpl value,
    $Res Function(_$EscrowPaymentQuoteResponseDtoImpl) then,
  ) = __$$EscrowPaymentQuoteResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int fee});
}

/// @nodoc
class __$$EscrowPaymentQuoteResponseDtoImplCopyWithImpl<$Res>
    extends _$EscrowPaymentQuoteResponseDtoCopyWithImpl<$Res, _$EscrowPaymentQuoteResponseDtoImpl>
    implements _$$EscrowPaymentQuoteResponseDtoImplCopyWith<$Res> {
  __$$EscrowPaymentQuoteResponseDtoImplCopyWithImpl(
    _$EscrowPaymentQuoteResponseDtoImpl _value,
    $Res Function(_$EscrowPaymentQuoteResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EscrowPaymentQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? fee = null}) {
    return _then(
      _$EscrowPaymentQuoteResponseDtoImpl(
        fee:
            null == fee
                ? _value.fee
                : fee // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _$EscrowPaymentQuoteResponseDtoImpl implements _EscrowPaymentQuoteResponseDto {
  const _$EscrowPaymentQuoteResponseDtoImpl({required this.fee});

  @override
  final int fee;

  @override
  String toString() {
    return 'EscrowPaymentQuoteResponseDto(fee: $fee)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EscrowPaymentQuoteResponseDtoImpl &&
            (identical(other.fee, fee) || other.fee == fee));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fee);

  /// Create a copy of EscrowPaymentQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EscrowPaymentQuoteResponseDtoImplCopyWith<_$EscrowPaymentQuoteResponseDtoImpl> get copyWith =>
      __$$EscrowPaymentQuoteResponseDtoImplCopyWithImpl<_$EscrowPaymentQuoteResponseDtoImpl>(
        this,
        _$identity,
      );
}

abstract class _EscrowPaymentQuoteResponseDto implements EscrowPaymentQuoteResponseDto {
  const factory _EscrowPaymentQuoteResponseDto({required final int fee}) =
      _$EscrowPaymentQuoteResponseDtoImpl;

  @override
  int get fee;

  /// Create a copy of EscrowPaymentQuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EscrowPaymentQuoteResponseDtoImplCopyWith<_$EscrowPaymentQuoteResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
