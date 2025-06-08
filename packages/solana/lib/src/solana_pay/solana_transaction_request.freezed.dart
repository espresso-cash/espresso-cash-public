// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'solana_transaction_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SolanaTransactionRequest {
  Uri get link;
  String? get label;
  String? get message;

  /// Create a copy of SolanaTransactionRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SolanaTransactionRequestCopyWith<SolanaTransactionRequest> get copyWith =>
      _$SolanaTransactionRequestCopyWithImpl<SolanaTransactionRequest>(
        this as SolanaTransactionRequest,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SolanaTransactionRequest &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, link, label, message);

  @override
  String toString() {
    return 'SolanaTransactionRequest(link: $link, label: $label, message: $message)';
  }
}

/// @nodoc
abstract mixin class $SolanaTransactionRequestCopyWith<$Res> {
  factory $SolanaTransactionRequestCopyWith(
    SolanaTransactionRequest value,
    $Res Function(SolanaTransactionRequest) _then,
  ) = _$SolanaTransactionRequestCopyWithImpl;
  @useResult
  $Res call({Uri link, String? label, String? message});
}

/// @nodoc
class _$SolanaTransactionRequestCopyWithImpl<$Res>
    implements $SolanaTransactionRequestCopyWith<$Res> {
  _$SolanaTransactionRequestCopyWithImpl(this._self, this._then);

  final SolanaTransactionRequest _self;
  final $Res Function(SolanaTransactionRequest) _then;

  /// Create a copy of SolanaTransactionRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? link = null, Object? label = freezed, Object? message = freezed}) {
    return _then(
      _self.copyWith(
        link:
            null == link
                ? _self.link
                : link // ignore: cast_nullable_to_non_nullable
                    as Uri,
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
      ),
    );
  }
}

/// @nodoc

class _SolanaTransactionRequest extends SolanaTransactionRequest {
  const _SolanaTransactionRequest({required this.link, this.label, this.message}) : super._();

  @override
  final Uri link;
  @override
  final String? label;
  @override
  final String? message;

  /// Create a copy of SolanaTransactionRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SolanaTransactionRequestCopyWith<_SolanaTransactionRequest> get copyWith =>
      __$SolanaTransactionRequestCopyWithImpl<_SolanaTransactionRequest>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SolanaTransactionRequest &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, link, label, message);

  @override
  String toString() {
    return 'SolanaTransactionRequest(link: $link, label: $label, message: $message)';
  }
}

/// @nodoc
abstract mixin class _$SolanaTransactionRequestCopyWith<$Res>
    implements $SolanaTransactionRequestCopyWith<$Res> {
  factory _$SolanaTransactionRequestCopyWith(
    _SolanaTransactionRequest value,
    $Res Function(_SolanaTransactionRequest) _then,
  ) = __$SolanaTransactionRequestCopyWithImpl;
  @override
  @useResult
  $Res call({Uri link, String? label, String? message});
}

/// @nodoc
class __$SolanaTransactionRequestCopyWithImpl<$Res>
    implements _$SolanaTransactionRequestCopyWith<$Res> {
  __$SolanaTransactionRequestCopyWithImpl(this._self, this._then);

  final _SolanaTransactionRequest _self;
  final $Res Function(_SolanaTransactionRequest) _then;

  /// Create a copy of SolanaTransactionRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? link = null, Object? label = freezed, Object? message = freezed}) {
    return _then(
      _SolanaTransactionRequest(
        link:
            null == link
                ? _self.link
                : link // ignore: cast_nullable_to_non_nullable
                    as Uri,
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
      ),
    );
  }
}
