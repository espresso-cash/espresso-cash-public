// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'currency.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Currency {}

/// @nodoc
abstract class $CurrencyCopyWith<$Res> {
  factory $CurrencyCopyWith(Currency value, $Res Function(Currency) then) =
      _$CurrencyCopyWithImpl<$Res, Currency>;
}

/// @nodoc
class _$CurrencyCopyWithImpl<$Res, $Val extends Currency>
    implements $CurrencyCopyWith<$Res> {
  _$CurrencyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$FiatCurrencyImplCopyWith<$Res> {
  factory _$$FiatCurrencyImplCopyWith(
          _$FiatCurrencyImpl value, $Res Function(_$FiatCurrencyImpl) then) =
      __$$FiatCurrencyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String name, int decimals, String symbol, String sign});
}

/// @nodoc
class __$$FiatCurrencyImplCopyWithImpl<$Res>
    extends _$CurrencyCopyWithImpl<$Res, _$FiatCurrencyImpl>
    implements _$$FiatCurrencyImplCopyWith<$Res> {
  __$$FiatCurrencyImplCopyWithImpl(
      _$FiatCurrencyImpl _value, $Res Function(_$FiatCurrencyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? decimals = null,
    Object? symbol = null,
    Object? sign = null,
  }) {
    return _then(_$FiatCurrencyImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      decimals: null == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      sign: null == sign
          ? _value.sign
          : sign // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FiatCurrencyImpl extends FiatCurrency {
  const _$FiatCurrencyImpl(
      {required this.name,
      required this.decimals,
      required this.symbol,
      required this.sign})
      : super._();

  @override
  final String name;
  @override
  final int decimals;
  @override
  final String symbol;
  @override
  final String sign;

  @override
  String toString() {
    return 'Currency.fiat(name: $name, decimals: $decimals, symbol: $symbol, sign: $sign)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FiatCurrencyImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.decimals, decimals) ||
                other.decimals == decimals) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.sign, sign) || other.sign == sign));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, decimals, symbol, sign);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FiatCurrencyImplCopyWith<_$FiatCurrencyImpl> get copyWith =>
      __$$FiatCurrencyImplCopyWithImpl<_$FiatCurrencyImpl>(this, _$identity);
}

abstract class FiatCurrency extends Currency {
  const factory FiatCurrency(
      {required final String name,
      required final int decimals,
      required final String symbol,
      required final String sign}) = _$FiatCurrencyImpl;
  const FiatCurrency._() : super._();

  String get name;
  int get decimals;
  String get symbol;
  String get sign;
  @JsonKey(ignore: true)
  _$$FiatCurrencyImplCopyWith<_$FiatCurrencyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CryptoCurrencyImplCopyWith<$Res> {
  factory _$$CryptoCurrencyImplCopyWith(_$CryptoCurrencyImpl value,
          $Res Function(_$CryptoCurrencyImpl) then) =
      __$$CryptoCurrencyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Token token});
}

/// @nodoc
class __$$CryptoCurrencyImplCopyWithImpl<$Res>
    extends _$CurrencyCopyWithImpl<$Res, _$CryptoCurrencyImpl>
    implements _$$CryptoCurrencyImplCopyWith<$Res> {
  __$$CryptoCurrencyImplCopyWithImpl(
      _$CryptoCurrencyImpl _value, $Res Function(_$CryptoCurrencyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
  }) {
    return _then(_$CryptoCurrencyImpl(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as Token,
    ));
  }
}

/// @nodoc

class _$CryptoCurrencyImpl extends CryptoCurrency {
  const _$CryptoCurrencyImpl({required this.token}) : super._();

  @override
  final Token token;

  @override
  String toString() {
    return 'Currency.crypto(token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CryptoCurrencyImpl &&
            (identical(other.token, token) || other.token == token));
  }

  @override
  int get hashCode => Object.hash(runtimeType, token);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CryptoCurrencyImplCopyWith<_$CryptoCurrencyImpl> get copyWith =>
      __$$CryptoCurrencyImplCopyWithImpl<_$CryptoCurrencyImpl>(
          this, _$identity);
}

abstract class CryptoCurrency extends Currency {
  const factory CryptoCurrency({required final Token token}) =
      _$CryptoCurrencyImpl;
  const CryptoCurrency._() : super._();

  Token get token;
  @JsonKey(ignore: true)
  _$$CryptoCurrencyImplCopyWith<_$CryptoCurrencyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
