// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'solana_transaction_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SolanaTransactionRequest {
  Uri get link => throw _privateConstructorUsedError;
  String? get label => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SolanaTransactionRequestCopyWith<SolanaTransactionRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SolanaTransactionRequestCopyWith<$Res> {
  factory $SolanaTransactionRequestCopyWith(SolanaTransactionRequest value,
          $Res Function(SolanaTransactionRequest) then) =
      _$SolanaTransactionRequestCopyWithImpl<$Res, SolanaTransactionRequest>;
  @useResult
  $Res call({Uri link, String? label, String? message});
}

/// @nodoc
class _$SolanaTransactionRequestCopyWithImpl<$Res,
        $Val extends SolanaTransactionRequest>
    implements $SolanaTransactionRequestCopyWith<$Res> {
  _$SolanaTransactionRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
    Object? label = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as Uri,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SolanaTransactionRequestCopyWith<$Res>
    implements $SolanaTransactionRequestCopyWith<$Res> {
  factory _$$_SolanaTransactionRequestCopyWith(
          _$_SolanaTransactionRequest value,
          $Res Function(_$_SolanaTransactionRequest) then) =
      __$$_SolanaTransactionRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Uri link, String? label, String? message});
}

/// @nodoc
class __$$_SolanaTransactionRequestCopyWithImpl<$Res>
    extends _$SolanaTransactionRequestCopyWithImpl<$Res,
        _$_SolanaTransactionRequest>
    implements _$$_SolanaTransactionRequestCopyWith<$Res> {
  __$$_SolanaTransactionRequestCopyWithImpl(_$_SolanaTransactionRequest _value,
      $Res Function(_$_SolanaTransactionRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
    Object? label = freezed,
    Object? message = freezed,
  }) {
    return _then(_$_SolanaTransactionRequest(
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as Uri,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_SolanaTransactionRequest extends _SolanaTransactionRequest {
  const _$_SolanaTransactionRequest(
      {required this.link, this.label, this.message})
      : super._();

  @override
  final Uri link;
  @override
  final String? label;
  @override
  final String? message;

  @override
  String toString() {
    return 'SolanaTransactionRequest(link: $link, label: $label, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SolanaTransactionRequest &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, link, label, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SolanaTransactionRequestCopyWith<_$_SolanaTransactionRequest>
      get copyWith => __$$_SolanaTransactionRequestCopyWithImpl<
          _$_SolanaTransactionRequest>(this, _$identity);
}

abstract class _SolanaTransactionRequest extends SolanaTransactionRequest {
  const factory _SolanaTransactionRequest(
      {required final Uri link,
      final String? label,
      final String? message}) = _$_SolanaTransactionRequest;
  const _SolanaTransactionRequest._() : super._();

  @override
  Uri get link;
  @override
  String? get label;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$_SolanaTransactionRequestCopyWith<_$_SolanaTransactionRequest>
      get copyWith => throw _privateConstructorUsedError;
}
