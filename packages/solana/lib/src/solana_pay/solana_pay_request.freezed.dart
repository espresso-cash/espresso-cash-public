// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'solana_pay_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SolanaPayRequestTearOff {
  const _$SolanaPayRequestTearOff();

  _SolanaPayRequest call(
      {required Ed25519HDPublicKey recipient,
      Decimal? amount,
      Ed25519HDPublicKey? splToken,
      Iterable<Ed25519HDPublicKey>? reference,
      String? label,
      String? message,
      String? memo}) {
    return _SolanaPayRequest(
      recipient: recipient,
      amount: amount,
      splToken: splToken,
      reference: reference,
      label: label,
      message: message,
      memo: memo,
    );
  }
}

/// @nodoc
const $SolanaPayRequest = _$SolanaPayRequestTearOff();

/// @nodoc
mixin _$SolanaPayRequest {
  Ed25519HDPublicKey get recipient => throw _privateConstructorUsedError;
  Decimal? get amount => throw _privateConstructorUsedError;
  Ed25519HDPublicKey? get splToken => throw _privateConstructorUsedError;
  Iterable<Ed25519HDPublicKey>? get reference =>
      throw _privateConstructorUsedError;
  String? get label => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SolanaPayRequestCopyWith<SolanaPayRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SolanaPayRequestCopyWith<$Res> {
  factory $SolanaPayRequestCopyWith(
          SolanaPayRequest value, $Res Function(SolanaPayRequest) then) =
      _$SolanaPayRequestCopyWithImpl<$Res>;
  $Res call(
      {Ed25519HDPublicKey recipient,
      Decimal? amount,
      Ed25519HDPublicKey? splToken,
      Iterable<Ed25519HDPublicKey>? reference,
      String? label,
      String? message,
      String? memo});
}

/// @nodoc
class _$SolanaPayRequestCopyWithImpl<$Res>
    implements $SolanaPayRequestCopyWith<$Res> {
  _$SolanaPayRequestCopyWithImpl(this._value, this._then);

  final SolanaPayRequest _value;
  // ignore: unused_field
  final $Res Function(SolanaPayRequest) _then;

  @override
  $Res call({
    Object? recipient = freezed,
    Object? amount = freezed,
    Object? splToken = freezed,
    Object? reference = freezed,
    Object? label = freezed,
    Object? message = freezed,
    Object? memo = freezed,
  }) {
    return _then(_value.copyWith(
      recipient: recipient == freezed
          ? _value.recipient
          : recipient // ignore: cast_nullable_to_non_nullable
              as Ed25519HDPublicKey,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as Decimal?,
      splToken: splToken == freezed
          ? _value.splToken
          : splToken // ignore: cast_nullable_to_non_nullable
              as Ed25519HDPublicKey?,
      reference: reference == freezed
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as Iterable<Ed25519HDPublicKey>?,
      label: label == freezed
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      memo: memo == freezed
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$SolanaPayRequestCopyWith<$Res>
    implements $SolanaPayRequestCopyWith<$Res> {
  factory _$SolanaPayRequestCopyWith(
          _SolanaPayRequest value, $Res Function(_SolanaPayRequest) then) =
      __$SolanaPayRequestCopyWithImpl<$Res>;
  @override
  $Res call(
      {Ed25519HDPublicKey recipient,
      Decimal? amount,
      Ed25519HDPublicKey? splToken,
      Iterable<Ed25519HDPublicKey>? reference,
      String? label,
      String? message,
      String? memo});
}

/// @nodoc
class __$SolanaPayRequestCopyWithImpl<$Res>
    extends _$SolanaPayRequestCopyWithImpl<$Res>
    implements _$SolanaPayRequestCopyWith<$Res> {
  __$SolanaPayRequestCopyWithImpl(
      _SolanaPayRequest _value, $Res Function(_SolanaPayRequest) _then)
      : super(_value, (v) => _then(v as _SolanaPayRequest));

  @override
  _SolanaPayRequest get _value => super._value as _SolanaPayRequest;

  @override
  $Res call({
    Object? recipient = freezed,
    Object? amount = freezed,
    Object? splToken = freezed,
    Object? reference = freezed,
    Object? label = freezed,
    Object? message = freezed,
    Object? memo = freezed,
  }) {
    return _then(_SolanaPayRequest(
      recipient: recipient == freezed
          ? _value.recipient
          : recipient // ignore: cast_nullable_to_non_nullable
              as Ed25519HDPublicKey,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as Decimal?,
      splToken: splToken == freezed
          ? _value.splToken
          : splToken // ignore: cast_nullable_to_non_nullable
              as Ed25519HDPublicKey?,
      reference: reference == freezed
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as Iterable<Ed25519HDPublicKey>?,
      label: label == freezed
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      memo: memo == freezed
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_SolanaPayRequest extends _SolanaPayRequest {
  const _$_SolanaPayRequest(
      {required this.recipient,
      this.amount,
      this.splToken,
      this.reference,
      this.label,
      this.message,
      this.memo})
      : super._();

  @override
  final Ed25519HDPublicKey recipient;
  @override
  final Decimal? amount;
  @override
  final Ed25519HDPublicKey? splToken;
  @override
  final Iterable<Ed25519HDPublicKey>? reference;
  @override
  final String? label;
  @override
  final String? message;
  @override
  final String? memo;

  @override
  String toString() {
    return 'SolanaPayRequest(recipient: $recipient, amount: $amount, splToken: $splToken, reference: $reference, label: $label, message: $message, memo: $memo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SolanaPayRequest &&
            const DeepCollectionEquality().equals(other.recipient, recipient) &&
            const DeepCollectionEquality().equals(other.amount, amount) &&
            const DeepCollectionEquality().equals(other.splToken, splToken) &&
            const DeepCollectionEquality().equals(other.reference, reference) &&
            const DeepCollectionEquality().equals(other.label, label) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.memo, memo));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(recipient),
      const DeepCollectionEquality().hash(amount),
      const DeepCollectionEquality().hash(splToken),
      const DeepCollectionEquality().hash(reference),
      const DeepCollectionEquality().hash(label),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(memo));

  @JsonKey(ignore: true)
  @override
  _$SolanaPayRequestCopyWith<_SolanaPayRequest> get copyWith =>
      __$SolanaPayRequestCopyWithImpl<_SolanaPayRequest>(this, _$identity);
}

abstract class _SolanaPayRequest extends SolanaPayRequest {
  const factory _SolanaPayRequest(
      {required Ed25519HDPublicKey recipient,
      Decimal? amount,
      Ed25519HDPublicKey? splToken,
      Iterable<Ed25519HDPublicKey>? reference,
      String? label,
      String? message,
      String? memo}) = _$_SolanaPayRequest;
  const _SolanaPayRequest._() : super._();

  @override
  Ed25519HDPublicKey get recipient;
  @override
  Decimal? get amount;
  @override
  Ed25519HDPublicKey? get splToken;
  @override
  Iterable<Ed25519HDPublicKey>? get reference;
  @override
  String? get label;
  @override
  String? get message;
  @override
  String? get memo;
  @override
  @JsonKey(ignore: true)
  _$SolanaPayRequestCopyWith<_SolanaPayRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
