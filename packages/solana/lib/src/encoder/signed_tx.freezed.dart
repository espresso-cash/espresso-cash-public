// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signed_tx.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SignedTx {
  List<Signature> get signatures => throw _privateConstructorUsedError;
  CompiledMessage get compiledMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignedTxCopyWith<SignedTx> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignedTxCopyWith<$Res> {
  factory $SignedTxCopyWith(SignedTx value, $Res Function(SignedTx) then) =
      _$SignedTxCopyWithImpl<$Res, SignedTx>;
  @useResult
  $Res call({List<Signature> signatures, CompiledMessage compiledMessage});

  $CompiledMessageCopyWith<$Res> get compiledMessage;
}

/// @nodoc
class _$SignedTxCopyWithImpl<$Res, $Val extends SignedTx>
    implements $SignedTxCopyWith<$Res> {
  _$SignedTxCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signatures = null,
    Object? compiledMessage = null,
  }) {
    return _then(_value.copyWith(
      signatures: null == signatures
          ? _value.signatures
          : signatures // ignore: cast_nullable_to_non_nullable
              as List<Signature>,
      compiledMessage: null == compiledMessage
          ? _value.compiledMessage
          : compiledMessage // ignore: cast_nullable_to_non_nullable
              as CompiledMessage,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CompiledMessageCopyWith<$Res> get compiledMessage {
    return $CompiledMessageCopyWith<$Res>(_value.compiledMessage, (value) {
      return _then(_value.copyWith(compiledMessage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SignedTxCopyWith<$Res> implements $SignedTxCopyWith<$Res> {
  factory _$$_SignedTxCopyWith(
          _$_SignedTx value, $Res Function(_$_SignedTx) then) =
      __$$_SignedTxCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Signature> signatures, CompiledMessage compiledMessage});

  @override
  $CompiledMessageCopyWith<$Res> get compiledMessage;
}

/// @nodoc
class __$$_SignedTxCopyWithImpl<$Res>
    extends _$SignedTxCopyWithImpl<$Res, _$_SignedTx>
    implements _$$_SignedTxCopyWith<$Res> {
  __$$_SignedTxCopyWithImpl(
      _$_SignedTx _value, $Res Function(_$_SignedTx) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signatures = null,
    Object? compiledMessage = null,
  }) {
    return _then(_$_SignedTx(
      signatures: null == signatures
          ? _value._signatures
          : signatures // ignore: cast_nullable_to_non_nullable
              as List<Signature>,
      compiledMessage: null == compiledMessage
          ? _value.compiledMessage
          : compiledMessage // ignore: cast_nullable_to_non_nullable
              as CompiledMessage,
    ));
  }
}

/// @nodoc

class _$_SignedTx extends _SignedTx {
  const _$_SignedTx(
      {final List<Signature> signatures = const <Signature>[],
      required this.compiledMessage})
      : _signatures = signatures,
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

  @override
  String toString() {
    return 'SignedTx(signatures: $signatures, compiledMessage: $compiledMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SignedTx &&
            const DeepCollectionEquality()
                .equals(other._signatures, _signatures) &&
            (identical(other.compiledMessage, compiledMessage) ||
                other.compiledMessage == compiledMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_signatures), compiledMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SignedTxCopyWith<_$_SignedTx> get copyWith =>
      __$$_SignedTxCopyWithImpl<_$_SignedTx>(this, _$identity);
}

abstract class _SignedTx extends SignedTx {
  const factory _SignedTx(
      {final List<Signature> signatures,
      required final CompiledMessage compiledMessage}) = _$_SignedTx;
  const _SignedTx._() : super._();

  @override
  List<Signature> get signatures;
  @override
  CompiledMessage get compiledMessage;
  @override
  @JsonKey(ignore: true)
  _$$_SignedTxCopyWith<_$_SignedTx> get copyWith =>
      throw _privateConstructorUsedError;
}
