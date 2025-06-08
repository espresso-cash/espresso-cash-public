// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'solana_pay_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SolanaPayRequest {
  Ed25519HDPublicKey get recipient;
  Decimal? get amount;
  Ed25519HDPublicKey? get splToken;
  Iterable<Ed25519HDPublicKey>? get reference;
  String? get label;
  String? get message;
  String? get memo;

  /// Create a copy of SolanaPayRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SolanaPayRequestCopyWith<SolanaPayRequest> get copyWith =>
      _$SolanaPayRequestCopyWithImpl<SolanaPayRequest>(this as SolanaPayRequest, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SolanaPayRequest &&
            (identical(other.recipient, recipient) || other.recipient == recipient) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.splToken, splToken) || other.splToken == splToken) &&
            const DeepCollectionEquality().equals(other.reference, reference) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.memo, memo) || other.memo == memo));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    recipient,
    amount,
    splToken,
    const DeepCollectionEquality().hash(reference),
    label,
    message,
    memo,
  );

  @override
  String toString() {
    return 'SolanaPayRequest(recipient: $recipient, amount: $amount, splToken: $splToken, reference: $reference, label: $label, message: $message, memo: $memo)';
  }
}

/// @nodoc
abstract mixin class $SolanaPayRequestCopyWith<$Res> {
  factory $SolanaPayRequestCopyWith(SolanaPayRequest value, $Res Function(SolanaPayRequest) _then) =
      _$SolanaPayRequestCopyWithImpl;
  @useResult
  $Res call({
    Ed25519HDPublicKey recipient,
    Decimal? amount,
    Ed25519HDPublicKey? splToken,
    Iterable<Ed25519HDPublicKey>? reference,
    String? label,
    String? message,
    String? memo,
  });
}

/// @nodoc
class _$SolanaPayRequestCopyWithImpl<$Res> implements $SolanaPayRequestCopyWith<$Res> {
  _$SolanaPayRequestCopyWithImpl(this._self, this._then);

  final SolanaPayRequest _self;
  final $Res Function(SolanaPayRequest) _then;

  /// Create a copy of SolanaPayRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipient = null,
    Object? amount = freezed,
    Object? splToken = freezed,
    Object? reference = freezed,
    Object? label = freezed,
    Object? message = freezed,
    Object? memo = freezed,
  }) {
    return _then(
      _self.copyWith(
        recipient:
            null == recipient
                ? _self.recipient
                : recipient // ignore: cast_nullable_to_non_nullable
                    as Ed25519HDPublicKey,
        amount:
            freezed == amount
                ? _self.amount
                : amount // ignore: cast_nullable_to_non_nullable
                    as Decimal?,
        splToken:
            freezed == splToken
                ? _self.splToken
                : splToken // ignore: cast_nullable_to_non_nullable
                    as Ed25519HDPublicKey?,
        reference:
            freezed == reference
                ? _self.reference
                : reference // ignore: cast_nullable_to_non_nullable
                    as Iterable<Ed25519HDPublicKey>?,
        label:
            freezed == label
                ? _self.label
                : label // ignore: cast_nullable_to_non_nullable
                    as String?,
        message:
            freezed == message
                ? _self.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String?,
        memo:
            freezed == memo
                ? _self.memo
                : memo // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _SolanaPayRequest extends SolanaPayRequest {
  const _SolanaPayRequest({
    required this.recipient,
    this.amount,
    this.splToken,
    this.reference,
    this.label,
    this.message,
    this.memo,
  }) : super._();

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

  /// Create a copy of SolanaPayRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SolanaPayRequestCopyWith<_SolanaPayRequest> get copyWith =>
      __$SolanaPayRequestCopyWithImpl<_SolanaPayRequest>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SolanaPayRequest &&
            (identical(other.recipient, recipient) || other.recipient == recipient) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.splToken, splToken) || other.splToken == splToken) &&
            const DeepCollectionEquality().equals(other.reference, reference) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.memo, memo) || other.memo == memo));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    recipient,
    amount,
    splToken,
    const DeepCollectionEquality().hash(reference),
    label,
    message,
    memo,
  );

  @override
  String toString() {
    return 'SolanaPayRequest(recipient: $recipient, amount: $amount, splToken: $splToken, reference: $reference, label: $label, message: $message, memo: $memo)';
  }
}

/// @nodoc
abstract mixin class _$SolanaPayRequestCopyWith<$Res> implements $SolanaPayRequestCopyWith<$Res> {
  factory _$SolanaPayRequestCopyWith(
    _SolanaPayRequest value,
    $Res Function(_SolanaPayRequest) _then,
  ) = __$SolanaPayRequestCopyWithImpl;
  @override
  @useResult
  $Res call({
    Ed25519HDPublicKey recipient,
    Decimal? amount,
    Ed25519HDPublicKey? splToken,
    Iterable<Ed25519HDPublicKey>? reference,
    String? label,
    String? message,
    String? memo,
  });
}

/// @nodoc
class __$SolanaPayRequestCopyWithImpl<$Res> implements _$SolanaPayRequestCopyWith<$Res> {
  __$SolanaPayRequestCopyWithImpl(this._self, this._then);

  final _SolanaPayRequest _self;
  final $Res Function(_SolanaPayRequest) _then;

  /// Create a copy of SolanaPayRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? recipient = null,
    Object? amount = freezed,
    Object? splToken = freezed,
    Object? reference = freezed,
    Object? label = freezed,
    Object? message = freezed,
    Object? memo = freezed,
  }) {
    return _then(
      _SolanaPayRequest(
        recipient:
            null == recipient
                ? _self.recipient
                : recipient // ignore: cast_nullable_to_non_nullable
                    as Ed25519HDPublicKey,
        amount:
            freezed == amount
                ? _self.amount
                : amount // ignore: cast_nullable_to_non_nullable
                    as Decimal?,
        splToken:
            freezed == splToken
                ? _self.splToken
                : splToken // ignore: cast_nullable_to_non_nullable
                    as Ed25519HDPublicKey?,
        reference:
            freezed == reference
                ? _self.reference
                : reference // ignore: cast_nullable_to_non_nullable
                    as Iterable<Ed25519HDPublicKey>?,
        label:
            freezed == label
                ? _self.label
                : label // ignore: cast_nullable_to_non_nullable
                    as String?,
        message:
            freezed == message
                ? _self.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String?,
        memo:
            freezed == memo
                ? _self.memo
                : memo // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}
