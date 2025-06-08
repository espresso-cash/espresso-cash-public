// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signed_tx.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignedTx {
  List<Signature> get signatures;
  CompiledMessage get compiledMessage;

  /// Create a copy of SignedTx
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignedTxCopyWith<SignedTx> get copyWith =>
      _$SignedTxCopyWithImpl<SignedTx>(this as SignedTx, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignedTx &&
            const DeepCollectionEquality().equals(other.signatures, signatures) &&
            (identical(other.compiledMessage, compiledMessage) ||
                other.compiledMessage == compiledMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(signatures), compiledMessage);

  @override
  String toString() {
    return 'SignedTx(signatures: $signatures, compiledMessage: $compiledMessage)';
  }
}

/// @nodoc
abstract mixin class $SignedTxCopyWith<$Res> {
  factory $SignedTxCopyWith(SignedTx value, $Res Function(SignedTx) _then) = _$SignedTxCopyWithImpl;
  @useResult
  $Res call({List<Signature> signatures, CompiledMessage compiledMessage});

  $CompiledMessageCopyWith<$Res> get compiledMessage;
}

/// @nodoc
class _$SignedTxCopyWithImpl<$Res> implements $SignedTxCopyWith<$Res> {
  _$SignedTxCopyWithImpl(this._self, this._then);

  final SignedTx _self;
  final $Res Function(SignedTx) _then;

  /// Create a copy of SignedTx
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? signatures = null, Object? compiledMessage = null}) {
    return _then(
      _self.copyWith(
        signatures:
            null == signatures
                ? _self.signatures
                : signatures // ignore: cast_nullable_to_non_nullable
                    as List<Signature>,
        compiledMessage:
            null == compiledMessage
                ? _self.compiledMessage
                : compiledMessage // ignore: cast_nullable_to_non_nullable
                    as CompiledMessage,
      ),
    );
  }

  /// Create a copy of SignedTx
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CompiledMessageCopyWith<$Res> get compiledMessage {
    return $CompiledMessageCopyWith<$Res>(_self.compiledMessage, (value) {
      return _then(_self.copyWith(compiledMessage: value));
    });
  }
}

/// @nodoc

class _SignedTx extends SignedTx {
  const _SignedTx({
    final List<Signature> signatures = const <Signature>[],
    required this.compiledMessage,
  }) : _signatures = signatures,
       super._();

  final List<Signature> _signatures;
  @override
  @JsonKey()
  List<Signature> get signatures {
    if (_signatures is EqualUnmodifiableListView) return _signatures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_signatures);
  }

  @override
  final CompiledMessage compiledMessage;

  /// Create a copy of SignedTx
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SignedTxCopyWith<_SignedTx> get copyWith =>
      __$SignedTxCopyWithImpl<_SignedTx>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SignedTx &&
            const DeepCollectionEquality().equals(other._signatures, _signatures) &&
            (identical(other.compiledMessage, compiledMessage) ||
                other.compiledMessage == compiledMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_signatures), compiledMessage);

  @override
  String toString() {
    return 'SignedTx(signatures: $signatures, compiledMessage: $compiledMessage)';
  }
}

/// @nodoc
abstract mixin class _$SignedTxCopyWith<$Res> implements $SignedTxCopyWith<$Res> {
  factory _$SignedTxCopyWith(_SignedTx value, $Res Function(_SignedTx) _then) =
      __$SignedTxCopyWithImpl;
  @override
  @useResult
  $Res call({List<Signature> signatures, CompiledMessage compiledMessage});

  @override
  $CompiledMessageCopyWith<$Res> get compiledMessage;
}

/// @nodoc
class __$SignedTxCopyWithImpl<$Res> implements _$SignedTxCopyWith<$Res> {
  __$SignedTxCopyWithImpl(this._self, this._then);

  final _SignedTx _self;
  final $Res Function(_SignedTx) _then;

  /// Create a copy of SignedTx
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? signatures = null, Object? compiledMessage = null}) {
    return _then(
      _SignedTx(
        signatures:
            null == signatures
                ? _self._signatures
                : signatures // ignore: cast_nullable_to_non_nullable
                    as List<Signature>,
        compiledMessage:
            null == compiledMessage
                ? _self.compiledMessage
                : compiledMessage // ignore: cast_nullable_to_non_nullable
                    as CompiledMessage,
      ),
    );
  }

  /// Create a copy of SignedTx
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CompiledMessageCopyWith<$Res> get compiledMessage {
    return $CompiledMessageCopyWith<$Res>(_self.compiledMessage, (value) {
      return _then(_self.copyWith(compiledMessage: value));
    });
  }
}
