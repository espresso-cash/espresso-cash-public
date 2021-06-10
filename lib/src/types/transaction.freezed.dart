// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$TxInstructionTearOff {
  const _$TxInstructionTearOff();

  TransferInstruction transfer(
      {required int lamports,
      required String source,
      required String destination}) {
    return TransferInstruction(
      lamports: lamports,
      source: source,
      destination: destination,
    );
  }

  MemoInstruction memo(String memo) {
    return MemoInstruction(
      memo,
    );
  }
}

/// @nodoc
const $TxInstruction = _$TxInstructionTearOff();

/// @nodoc
mixin _$TxInstruction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int lamports, String source, String destination)
        transfer,
    required TResult Function(String memo) memo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int lamports, String source, String destination)? transfer,
    TResult Function(String memo)? memo,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransferInstruction value) transfer,
    required TResult Function(MemoInstruction value) memo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransferInstruction value)? transfer,
    TResult Function(MemoInstruction value)? memo,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TxInstructionCopyWith<$Res> {
  factory $TxInstructionCopyWith(
          TxInstruction value, $Res Function(TxInstruction) then) =
      _$TxInstructionCopyWithImpl<$Res>;
}

/// @nodoc
class _$TxInstructionCopyWithImpl<$Res>
    implements $TxInstructionCopyWith<$Res> {
  _$TxInstructionCopyWithImpl(this._value, this._then);

  final TxInstruction _value;
  // ignore: unused_field
  final $Res Function(TxInstruction) _then;
}

/// @nodoc
abstract class $TransferInstructionCopyWith<$Res> {
  factory $TransferInstructionCopyWith(
          TransferInstruction value, $Res Function(TransferInstruction) then) =
      _$TransferInstructionCopyWithImpl<$Res>;
  $Res call({int lamports, String source, String destination});
}

/// @nodoc
class _$TransferInstructionCopyWithImpl<$Res>
    extends _$TxInstructionCopyWithImpl<$Res>
    implements $TransferInstructionCopyWith<$Res> {
  _$TransferInstructionCopyWithImpl(
      TransferInstruction _value, $Res Function(TransferInstruction) _then)
      : super(_value, (v) => _then(v as TransferInstruction));

  @override
  TransferInstruction get _value => super._value as TransferInstruction;

  @override
  $Res call({
    Object? lamports = freezed,
    Object? source = freezed,
    Object? destination = freezed,
  }) {
    return _then(TransferInstruction(
      lamports: lamports == freezed
          ? _value.lamports
          : lamports // ignore: cast_nullable_to_non_nullable
              as int,
      source: source == freezed
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      destination: destination == freezed
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
class _$TransferInstruction extends TransferInstruction {
  const _$TransferInstruction(
      {required this.lamports, required this.source, required this.destination})
      : super._();

  @override
  final int lamports;
  @override
  final String source;
  @override
  final String destination;

  @override
  String toString() {
    return 'TxInstruction.transfer(lamports: $lamports, source: $source, destination: $destination)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TransferInstruction &&
            (identical(other.lamports, lamports) ||
                const DeepCollectionEquality()
                    .equals(other.lamports, lamports)) &&
            (identical(other.source, source) ||
                const DeepCollectionEquality().equals(other.source, source)) &&
            (identical(other.destination, destination) ||
                const DeepCollectionEquality()
                    .equals(other.destination, destination)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(lamports) ^
      const DeepCollectionEquality().hash(source) ^
      const DeepCollectionEquality().hash(destination);

  @JsonKey(ignore: true)
  @override
  $TransferInstructionCopyWith<TransferInstruction> get copyWith =>
      _$TransferInstructionCopyWithImpl<TransferInstruction>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int lamports, String source, String destination)
        transfer,
    required TResult Function(String memo) memo,
  }) {
    return transfer(lamports, source, destination);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int lamports, String source, String destination)? transfer,
    TResult Function(String memo)? memo,
    required TResult orElse(),
  }) {
    if (transfer != null) {
      return transfer(lamports, source, destination);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransferInstruction value) transfer,
    required TResult Function(MemoInstruction value) memo,
  }) {
    return transfer(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransferInstruction value)? transfer,
    TResult Function(MemoInstruction value)? memo,
    required TResult orElse(),
  }) {
    if (transfer != null) {
      return transfer(this);
    }
    return orElse();
  }
}

abstract class TransferInstruction extends TxInstruction {
  const factory TransferInstruction(
      {required int lamports,
      required String source,
      required String destination}) = _$TransferInstruction;
  const TransferInstruction._() : super._();

  int get lamports => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  String get destination => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransferInstructionCopyWith<TransferInstruction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemoInstructionCopyWith<$Res> {
  factory $MemoInstructionCopyWith(
          MemoInstruction value, $Res Function(MemoInstruction) then) =
      _$MemoInstructionCopyWithImpl<$Res>;
  $Res call({String memo});
}

/// @nodoc
class _$MemoInstructionCopyWithImpl<$Res>
    extends _$TxInstructionCopyWithImpl<$Res>
    implements $MemoInstructionCopyWith<$Res> {
  _$MemoInstructionCopyWithImpl(
      MemoInstruction _value, $Res Function(MemoInstruction) _then)
      : super(_value, (v) => _then(v as MemoInstruction));

  @override
  MemoInstruction get _value => super._value as MemoInstruction;

  @override
  $Res call({
    Object? memo = freezed,
  }) {
    return _then(MemoInstruction(
      memo == freezed
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
class _$MemoInstruction extends MemoInstruction {
  const _$MemoInstruction(this.memo) : super._();

  @override
  final String memo;

  @override
  String toString() {
    return 'TxInstruction.memo(memo: $memo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MemoInstruction &&
            (identical(other.memo, memo) ||
                const DeepCollectionEquality().equals(other.memo, memo)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(memo);

  @JsonKey(ignore: true)
  @override
  $MemoInstructionCopyWith<MemoInstruction> get copyWith =>
      _$MemoInstructionCopyWithImpl<MemoInstruction>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int lamports, String source, String destination)
        transfer,
    required TResult Function(String memo) memo,
  }) {
    return memo(this.memo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int lamports, String source, String destination)? transfer,
    TResult Function(String memo)? memo,
    required TResult orElse(),
  }) {
    if (memo != null) {
      return memo(this.memo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransferInstruction value) transfer,
    required TResult Function(MemoInstruction value) memo,
  }) {
    return memo(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransferInstruction value)? transfer,
    TResult Function(MemoInstruction value)? memo,
    required TResult orElse(),
  }) {
    if (memo != null) {
      return memo(this);
    }
    return orElse();
  }
}

abstract class MemoInstruction extends TxInstruction {
  const factory MemoInstruction(String memo) = _$MemoInstruction;
  const MemoInstruction._() : super._();

  String get memo => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MemoInstructionCopyWith<MemoInstruction> get copyWith =>
      throw _privateConstructorUsedError;
}
