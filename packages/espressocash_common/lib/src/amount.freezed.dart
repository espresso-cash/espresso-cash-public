// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'amount.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Amount {
  int get value => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AmountCopyWith<Amount> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AmountCopyWith<$Res> {
  factory $AmountCopyWith(Amount value, $Res Function(Amount) then) =
      _$AmountCopyWithImpl<$Res, Amount>;
  @useResult
  $Res call({int value});
}

/// @nodoc
class _$AmountCopyWithImpl<$Res, $Val extends Amount>
    implements $AmountCopyWith<$Res> {
  _$AmountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FiatAmountImplCopyWith<$Res>
    implements $AmountCopyWith<$Res> {
  factory _$$FiatAmountImplCopyWith(
          _$FiatAmountImpl value, $Res Function(_$FiatAmountImpl) then) =
      __$$FiatAmountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int value, FiatCurrency fiatCurrency});
}

/// @nodoc
class __$$FiatAmountImplCopyWithImpl<$Res>
    extends _$AmountCopyWithImpl<$Res, _$FiatAmountImpl>
    implements _$$FiatAmountImplCopyWith<$Res> {
  __$$FiatAmountImplCopyWithImpl(
      _$FiatAmountImpl _value, $Res Function(_$FiatAmountImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? fiatCurrency = freezed,
  }) {
    return _then(_$FiatAmountImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      fiatCurrency: freezed == fiatCurrency
          ? _value.fiatCurrency
          : fiatCurrency // ignore: cast_nullable_to_non_nullable
              as FiatCurrency,
    ));
  }
}

/// @nodoc

class _$FiatAmountImpl extends FiatAmount {
  const _$FiatAmountImpl({required this.value, required this.fiatCurrency})
      : super._();

  @override
  final int value;
  @override
  final FiatCurrency fiatCurrency;

  @override
  String toString() {
    return 'Amount.fiat(value: $value, fiatCurrency: $fiatCurrency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FiatAmountImpl &&
            (identical(other.value, value) || other.value == value) &&
            const DeepCollectionEquality()
                .equals(other.fiatCurrency, fiatCurrency));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, value, const DeepCollectionEquality().hash(fiatCurrency));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FiatAmountImplCopyWith<_$FiatAmountImpl> get copyWith =>
      __$$FiatAmountImplCopyWithImpl<_$FiatAmountImpl>(this, _$identity);
}

abstract class FiatAmount extends Amount {
  const factory FiatAmount(
      {required final int value,
      required final FiatCurrency fiatCurrency}) = _$FiatAmountImpl;
  const FiatAmount._() : super._();

  @override
  int get value;
  FiatCurrency get fiatCurrency;
  @override
  @JsonKey(ignore: true)
  _$$FiatAmountImplCopyWith<_$FiatAmountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CryptoAmountImplCopyWith<$Res>
    implements $AmountCopyWith<$Res> {
  factory _$$CryptoAmountImplCopyWith(
          _$CryptoAmountImpl value, $Res Function(_$CryptoAmountImpl) then) =
      __$$CryptoAmountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int value, CryptoCurrency cryptoCurrency});
}

/// @nodoc
class __$$CryptoAmountImplCopyWithImpl<$Res>
    extends _$AmountCopyWithImpl<$Res, _$CryptoAmountImpl>
    implements _$$CryptoAmountImplCopyWith<$Res> {
  __$$CryptoAmountImplCopyWithImpl(
      _$CryptoAmountImpl _value, $Res Function(_$CryptoAmountImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? cryptoCurrency = freezed,
  }) {
    return _then(_$CryptoAmountImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      cryptoCurrency: freezed == cryptoCurrency
          ? _value.cryptoCurrency
          : cryptoCurrency // ignore: cast_nullable_to_non_nullable
              as CryptoCurrency,
    ));
  }
}

/// @nodoc

class _$CryptoAmountImpl extends CryptoAmount {
  const _$CryptoAmountImpl({required this.value, required this.cryptoCurrency})
      : super._();

  @override
  final int value;
  @override
  final CryptoCurrency cryptoCurrency;

  @override
  String toString() {
    return 'Amount.crypto(value: $value, cryptoCurrency: $cryptoCurrency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CryptoAmountImpl &&
            (identical(other.value, value) || other.value == value) &&
            const DeepCollectionEquality()
                .equals(other.cryptoCurrency, cryptoCurrency));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, value, const DeepCollectionEquality().hash(cryptoCurrency));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CryptoAmountImplCopyWith<_$CryptoAmountImpl> get copyWith =>
      __$$CryptoAmountImplCopyWithImpl<_$CryptoAmountImpl>(this, _$identity);
}

abstract class CryptoAmount extends Amount {
  const factory CryptoAmount(
      {required final int value,
      required final CryptoCurrency cryptoCurrency}) = _$CryptoAmountImpl;
  const CryptoAmount._() : super._();

  @override
  int get value;
  CryptoCurrency get cryptoCurrency;
  @override
  @JsonKey(ignore: true)
  _$$CryptoAmountImplCopyWith<_$CryptoAmountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
