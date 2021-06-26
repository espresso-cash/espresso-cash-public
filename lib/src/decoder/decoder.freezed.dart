// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of decoder;

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TxInstruction _$TxInstructionFromJson(Map<String, dynamic> json) {
  switch (json['program'] as String) {
    case 'system':
      return TxSystemInstruction.fromJson(json);
    case 'spl-memo':
      return TxMemoInstruction.fromJson(json);

    default:
      return TxUnsupportedInstruction.fromJson(json);
  }
}

/// @nodoc
class _$TxInstructionTearOff {
  const _$TxInstructionTearOff();

  TxSystemInstruction system(
      {required String programId, required SystemInstruction parsed}) {
    return TxSystemInstruction(
      programId: programId,
      parsed: parsed,
    );
  }

  TxMemoInstruction memo({@JsonKey(name: 'parsed') required String? memo}) {
    return TxMemoInstruction(
      memo: memo,
    );
  }

  TxUnsupportedInstruction unsupported({required String program}) {
    return TxUnsupportedInstruction(
      program: program,
    );
  }

  TxInstruction fromJson(Map<String, Object> json) {
    return TxInstruction.fromJson(json);
  }
}

/// @nodoc
const $TxInstruction = _$TxInstructionTearOff();

/// @nodoc
mixin _$TxInstruction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String programId, SystemInstruction parsed)
        system,
    required TResult Function(@JsonKey(name: 'parsed') String? memo) memo,
    required TResult Function(String program) unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String programId, SystemInstruction parsed)? system,
    TResult Function(@JsonKey(name: 'parsed') String? memo)? memo,
    TResult Function(String program)? unsupported,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TxSystemInstruction value) system,
    required TResult Function(TxMemoInstruction value) memo,
    required TResult Function(TxUnsupportedInstruction value) unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TxSystemInstruction value)? system,
    TResult Function(TxMemoInstruction value)? memo,
    TResult Function(TxUnsupportedInstruction value)? unsupported,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
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
abstract class $TxSystemInstructionCopyWith<$Res> {
  factory $TxSystemInstructionCopyWith(
          TxSystemInstruction value, $Res Function(TxSystemInstruction) then) =
      _$TxSystemInstructionCopyWithImpl<$Res>;
  $Res call({String programId, SystemInstruction parsed});

  $SystemInstructionCopyWith<$Res> get parsed;
}

/// @nodoc
class _$TxSystemInstructionCopyWithImpl<$Res>
    extends _$TxInstructionCopyWithImpl<$Res>
    implements $TxSystemInstructionCopyWith<$Res> {
  _$TxSystemInstructionCopyWithImpl(
      TxSystemInstruction _value, $Res Function(TxSystemInstruction) _then)
      : super(_value, (v) => _then(v as TxSystemInstruction));

  @override
  TxSystemInstruction get _value => super._value as TxSystemInstruction;

  @override
  $Res call({
    Object? programId = freezed,
    Object? parsed = freezed,
  }) {
    return _then(TxSystemInstruction(
      programId: programId == freezed
          ? _value.programId
          : programId // ignore: cast_nullable_to_non_nullable
              as String,
      parsed: parsed == freezed
          ? _value.parsed
          : parsed // ignore: cast_nullable_to_non_nullable
              as SystemInstruction,
    ));
  }

  @override
  $SystemInstructionCopyWith<$Res> get parsed {
    return $SystemInstructionCopyWith<$Res>(_value.parsed, (value) {
      return _then(_value.copyWith(parsed: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$TxSystemInstruction implements TxSystemInstruction {
  const _$TxSystemInstruction({required this.programId, required this.parsed});

  factory _$TxSystemInstruction.fromJson(Map<String, dynamic> json) =>
      _$_$TxSystemInstructionFromJson(json);

  @override
  final String programId;
  @override
  final SystemInstruction parsed;

  @override
  String toString() {
    return 'TxInstruction.system(programId: $programId, parsed: $parsed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TxSystemInstruction &&
            (identical(other.programId, programId) ||
                const DeepCollectionEquality()
                    .equals(other.programId, programId)) &&
            (identical(other.parsed, parsed) ||
                const DeepCollectionEquality().equals(other.parsed, parsed)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(programId) ^
      const DeepCollectionEquality().hash(parsed);

  @JsonKey(ignore: true)
  @override
  $TxSystemInstructionCopyWith<TxSystemInstruction> get copyWith =>
      _$TxSystemInstructionCopyWithImpl<TxSystemInstruction>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String programId, SystemInstruction parsed)
        system,
    required TResult Function(@JsonKey(name: 'parsed') String? memo) memo,
    required TResult Function(String program) unsupported,
  }) {
    return system(programId, parsed);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String programId, SystemInstruction parsed)? system,
    TResult Function(@JsonKey(name: 'parsed') String? memo)? memo,
    TResult Function(String program)? unsupported,
    required TResult orElse(),
  }) {
    if (system != null) {
      return system(programId, parsed);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TxSystemInstruction value) system,
    required TResult Function(TxMemoInstruction value) memo,
    required TResult Function(TxUnsupportedInstruction value) unsupported,
  }) {
    return system(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TxSystemInstruction value)? system,
    TResult Function(TxMemoInstruction value)? memo,
    TResult Function(TxUnsupportedInstruction value)? unsupported,
    required TResult orElse(),
  }) {
    if (system != null) {
      return system(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$TxSystemInstructionToJson(this)..['program'] = 'system';
  }
}

abstract class TxSystemInstruction implements TxInstruction {
  const factory TxSystemInstruction(
      {required String programId,
      required SystemInstruction parsed}) = _$TxSystemInstruction;

  factory TxSystemInstruction.fromJson(Map<String, dynamic> json) =
      _$TxSystemInstruction.fromJson;

  String get programId => throw _privateConstructorUsedError;
  SystemInstruction get parsed => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TxSystemInstructionCopyWith<TxSystemInstruction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TxMemoInstructionCopyWith<$Res> {
  factory $TxMemoInstructionCopyWith(
          TxMemoInstruction value, $Res Function(TxMemoInstruction) then) =
      _$TxMemoInstructionCopyWithImpl<$Res>;
  $Res call({@JsonKey(name: 'parsed') String? memo});
}

/// @nodoc
class _$TxMemoInstructionCopyWithImpl<$Res>
    extends _$TxInstructionCopyWithImpl<$Res>
    implements $TxMemoInstructionCopyWith<$Res> {
  _$TxMemoInstructionCopyWithImpl(
      TxMemoInstruction _value, $Res Function(TxMemoInstruction) _then)
      : super(_value, (v) => _then(v as TxMemoInstruction));

  @override
  TxMemoInstruction get _value => super._value as TxMemoInstruction;

  @override
  $Res call({
    Object? memo = freezed,
  }) {
    return _then(TxMemoInstruction(
      memo: memo == freezed
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('spl-memo')
class _$TxMemoInstruction implements TxMemoInstruction {
  const _$TxMemoInstruction({@JsonKey(name: 'parsed') required this.memo});

  factory _$TxMemoInstruction.fromJson(Map<String, dynamic> json) =>
      _$_$TxMemoInstructionFromJson(json);

  @override
  @JsonKey(name: 'parsed')
  final String? memo;

  @override
  String toString() {
    return 'TxInstruction.memo(memo: $memo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TxMemoInstruction &&
            (identical(other.memo, memo) ||
                const DeepCollectionEquality().equals(other.memo, memo)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(memo);

  @JsonKey(ignore: true)
  @override
  $TxMemoInstructionCopyWith<TxMemoInstruction> get copyWith =>
      _$TxMemoInstructionCopyWithImpl<TxMemoInstruction>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String programId, SystemInstruction parsed)
        system,
    required TResult Function(@JsonKey(name: 'parsed') String? memo) memo,
    required TResult Function(String program) unsupported,
  }) {
    return memo(this.memo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String programId, SystemInstruction parsed)? system,
    TResult Function(@JsonKey(name: 'parsed') String? memo)? memo,
    TResult Function(String program)? unsupported,
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
    required TResult Function(TxSystemInstruction value) system,
    required TResult Function(TxMemoInstruction value) memo,
    required TResult Function(TxUnsupportedInstruction value) unsupported,
  }) {
    return memo(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TxSystemInstruction value)? system,
    TResult Function(TxMemoInstruction value)? memo,
    TResult Function(TxUnsupportedInstruction value)? unsupported,
    required TResult orElse(),
  }) {
    if (memo != null) {
      return memo(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$TxMemoInstructionToJson(this)..['program'] = 'spl-memo';
  }
}

abstract class TxMemoInstruction implements TxInstruction {
  const factory TxMemoInstruction(
      {@JsonKey(name: 'parsed') required String? memo}) = _$TxMemoInstruction;

  factory TxMemoInstruction.fromJson(Map<String, dynamic> json) =
      _$TxMemoInstruction.fromJson;

  @JsonKey(name: 'parsed')
  String? get memo => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TxMemoInstructionCopyWith<TxMemoInstruction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TxUnsupportedInstructionCopyWith<$Res> {
  factory $TxUnsupportedInstructionCopyWith(TxUnsupportedInstruction value,
          $Res Function(TxUnsupportedInstruction) then) =
      _$TxUnsupportedInstructionCopyWithImpl<$Res>;
  $Res call({String program});
}

/// @nodoc
class _$TxUnsupportedInstructionCopyWithImpl<$Res>
    extends _$TxInstructionCopyWithImpl<$Res>
    implements $TxUnsupportedInstructionCopyWith<$Res> {
  _$TxUnsupportedInstructionCopyWithImpl(TxUnsupportedInstruction _value,
      $Res Function(TxUnsupportedInstruction) _then)
      : super(_value, (v) => _then(v as TxUnsupportedInstruction));

  @override
  TxUnsupportedInstruction get _value =>
      super._value as TxUnsupportedInstruction;

  @override
  $Res call({
    Object? program = freezed,
  }) {
    return _then(TxUnsupportedInstruction(
      program: program == freezed
          ? _value.program
          : program // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TxUnsupportedInstruction implements TxUnsupportedInstruction {
  const _$TxUnsupportedInstruction({required this.program});

  factory _$TxUnsupportedInstruction.fromJson(Map<String, dynamic> json) =>
      _$_$TxUnsupportedInstructionFromJson(json);

  @override
  final String program;

  @override
  String toString() {
    return 'TxInstruction.unsupported(program: $program)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TxUnsupportedInstruction &&
            (identical(other.program, program) ||
                const DeepCollectionEquality().equals(other.program, program)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(program);

  @JsonKey(ignore: true)
  @override
  $TxUnsupportedInstructionCopyWith<TxUnsupportedInstruction> get copyWith =>
      _$TxUnsupportedInstructionCopyWithImpl<TxUnsupportedInstruction>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String programId, SystemInstruction parsed)
        system,
    required TResult Function(@JsonKey(name: 'parsed') String? memo) memo,
    required TResult Function(String program) unsupported,
  }) {
    return unsupported(program);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String programId, SystemInstruction parsed)? system,
    TResult Function(@JsonKey(name: 'parsed') String? memo)? memo,
    TResult Function(String program)? unsupported,
    required TResult orElse(),
  }) {
    if (unsupported != null) {
      return unsupported(program);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TxSystemInstruction value) system,
    required TResult Function(TxMemoInstruction value) memo,
    required TResult Function(TxUnsupportedInstruction value) unsupported,
  }) {
    return unsupported(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TxSystemInstruction value)? system,
    TResult Function(TxMemoInstruction value)? memo,
    TResult Function(TxUnsupportedInstruction value)? unsupported,
    required TResult orElse(),
  }) {
    if (unsupported != null) {
      return unsupported(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$TxUnsupportedInstructionToJson(this)
      ..['program'] = 'unsupported';
  }
}

abstract class TxUnsupportedInstruction implements TxInstruction {
  const factory TxUnsupportedInstruction({required String program}) =
      _$TxUnsupportedInstruction;

  factory TxUnsupportedInstruction.fromJson(Map<String, dynamic> json) =
      _$TxUnsupportedInstruction.fromJson;

  String get program => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TxUnsupportedInstructionCopyWith<TxUnsupportedInstruction> get copyWith =>
      throw _privateConstructorUsedError;
}

SystemInstruction _$SystemInstructionFromJson(Map<String, dynamic> json) {
  switch (json['type'] as String) {
    case 'transfer':
      return TxSystemInstructionTransfer.fromJson(json);

    default:
      return TxSystemInstructionUnsupported.fromJson(json);
  }
}

/// @nodoc
class _$SystemInstructionTearOff {
  const _$SystemInstructionTearOff();

  TxSystemInstructionTransfer transfer({required TransferInfo info}) {
    return TxSystemInstructionTransfer(
      info: info,
    );
  }

  TxSystemInstructionUnsupported unsupported({required String type}) {
    return TxSystemInstructionUnsupported(
      type: type,
    );
  }

  SystemInstruction fromJson(Map<String, Object> json) {
    return SystemInstruction.fromJson(json);
  }
}

/// @nodoc
const $SystemInstruction = _$SystemInstructionTearOff();

/// @nodoc
mixin _$SystemInstruction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TransferInfo info) transfer,
    required TResult Function(String type) unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TransferInfo info)? transfer,
    TResult Function(String type)? unsupported,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TxSystemInstructionTransfer value) transfer,
    required TResult Function(TxSystemInstructionUnsupported value) unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TxSystemInstructionTransfer value)? transfer,
    TResult Function(TxSystemInstructionUnsupported value)? unsupported,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SystemInstructionCopyWith<$Res> {
  factory $SystemInstructionCopyWith(
          SystemInstruction value, $Res Function(SystemInstruction) then) =
      _$SystemInstructionCopyWithImpl<$Res>;
}

/// @nodoc
class _$SystemInstructionCopyWithImpl<$Res>
    implements $SystemInstructionCopyWith<$Res> {
  _$SystemInstructionCopyWithImpl(this._value, this._then);

  final SystemInstruction _value;
  // ignore: unused_field
  final $Res Function(SystemInstruction) _then;
}

/// @nodoc
abstract class $TxSystemInstructionTransferCopyWith<$Res> {
  factory $TxSystemInstructionTransferCopyWith(
          TxSystemInstructionTransfer value,
          $Res Function(TxSystemInstructionTransfer) then) =
      _$TxSystemInstructionTransferCopyWithImpl<$Res>;
  $Res call({TransferInfo info});

  $TransferInfoCopyWith<$Res> get info;
}

/// @nodoc
class _$TxSystemInstructionTransferCopyWithImpl<$Res>
    extends _$SystemInstructionCopyWithImpl<$Res>
    implements $TxSystemInstructionTransferCopyWith<$Res> {
  _$TxSystemInstructionTransferCopyWithImpl(TxSystemInstructionTransfer _value,
      $Res Function(TxSystemInstructionTransfer) _then)
      : super(_value, (v) => _then(v as TxSystemInstructionTransfer));

  @override
  TxSystemInstructionTransfer get _value =>
      super._value as TxSystemInstructionTransfer;

  @override
  $Res call({
    Object? info = freezed,
  }) {
    return _then(TxSystemInstructionTransfer(
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as TransferInfo,
    ));
  }

  @override
  $TransferInfoCopyWith<$Res> get info {
    return $TransferInfoCopyWith<$Res>(_value.info, (value) {
      return _then(_value.copyWith(info: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$TxSystemInstructionTransfer implements TxSystemInstructionTransfer {
  const _$TxSystemInstructionTransfer({required this.info});

  factory _$TxSystemInstructionTransfer.fromJson(Map<String, dynamic> json) =>
      _$_$TxSystemInstructionTransferFromJson(json);

  @override
  final TransferInfo info;

  @override
  String toString() {
    return 'SystemInstruction.transfer(info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TxSystemInstructionTransfer &&
            (identical(other.info, info) ||
                const DeepCollectionEquality().equals(other.info, info)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(info);

  @JsonKey(ignore: true)
  @override
  $TxSystemInstructionTransferCopyWith<TxSystemInstructionTransfer>
      get copyWith => _$TxSystemInstructionTransferCopyWithImpl<
          TxSystemInstructionTransfer>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TransferInfo info) transfer,
    required TResult Function(String type) unsupported,
  }) {
    return transfer(info);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TransferInfo info)? transfer,
    TResult Function(String type)? unsupported,
    required TResult orElse(),
  }) {
    if (transfer != null) {
      return transfer(info);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TxSystemInstructionTransfer value) transfer,
    required TResult Function(TxSystemInstructionUnsupported value) unsupported,
  }) {
    return transfer(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TxSystemInstructionTransfer value)? transfer,
    TResult Function(TxSystemInstructionUnsupported value)? unsupported,
    required TResult orElse(),
  }) {
    if (transfer != null) {
      return transfer(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$TxSystemInstructionTransferToJson(this)..['type'] = 'transfer';
  }
}

abstract class TxSystemInstructionTransfer implements SystemInstruction {
  const factory TxSystemInstructionTransfer({required TransferInfo info}) =
      _$TxSystemInstructionTransfer;

  factory TxSystemInstructionTransfer.fromJson(Map<String, dynamic> json) =
      _$TxSystemInstructionTransfer.fromJson;

  TransferInfo get info => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TxSystemInstructionTransferCopyWith<TxSystemInstructionTransfer>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TxSystemInstructionUnsupportedCopyWith<$Res> {
  factory $TxSystemInstructionUnsupportedCopyWith(
          TxSystemInstructionUnsupported value,
          $Res Function(TxSystemInstructionUnsupported) then) =
      _$TxSystemInstructionUnsupportedCopyWithImpl<$Res>;
  $Res call({String type});
}

/// @nodoc
class _$TxSystemInstructionUnsupportedCopyWithImpl<$Res>
    extends _$SystemInstructionCopyWithImpl<$Res>
    implements $TxSystemInstructionUnsupportedCopyWith<$Res> {
  _$TxSystemInstructionUnsupportedCopyWithImpl(
      TxSystemInstructionUnsupported _value,
      $Res Function(TxSystemInstructionUnsupported) _then)
      : super(_value, (v) => _then(v as TxSystemInstructionUnsupported));

  @override
  TxSystemInstructionUnsupported get _value =>
      super._value as TxSystemInstructionUnsupported;

  @override
  $Res call({
    Object? type = freezed,
  }) {
    return _then(TxSystemInstructionUnsupported(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TxSystemInstructionUnsupported
    implements TxSystemInstructionUnsupported {
  const _$TxSystemInstructionUnsupported({required this.type});

  factory _$TxSystemInstructionUnsupported.fromJson(
          Map<String, dynamic> json) =>
      _$_$TxSystemInstructionUnsupportedFromJson(json);

  @override
  final String type;

  @override
  String toString() {
    return 'SystemInstruction.unsupported(type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TxSystemInstructionUnsupported &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(type);

  @JsonKey(ignore: true)
  @override
  $TxSystemInstructionUnsupportedCopyWith<TxSystemInstructionUnsupported>
      get copyWith => _$TxSystemInstructionUnsupportedCopyWithImpl<
          TxSystemInstructionUnsupported>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TransferInfo info) transfer,
    required TResult Function(String type) unsupported,
  }) {
    return unsupported(type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TransferInfo info)? transfer,
    TResult Function(String type)? unsupported,
    required TResult orElse(),
  }) {
    if (unsupported != null) {
      return unsupported(type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TxSystemInstructionTransfer value) transfer,
    required TResult Function(TxSystemInstructionUnsupported value) unsupported,
  }) {
    return unsupported(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TxSystemInstructionTransfer value)? transfer,
    TResult Function(TxSystemInstructionUnsupported value)? unsupported,
    required TResult orElse(),
  }) {
    if (unsupported != null) {
      return unsupported(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$TxSystemInstructionUnsupportedToJson(this)
      ..['type'] = 'unsupported';
  }
}

abstract class TxSystemInstructionUnsupported implements SystemInstruction {
  const factory TxSystemInstructionUnsupported({required String type}) =
      _$TxSystemInstructionUnsupported;

  factory TxSystemInstructionUnsupported.fromJson(Map<String, dynamic> json) =
      _$TxSystemInstructionUnsupported.fromJson;

  String get type => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TxSystemInstructionUnsupportedCopyWith<TxSystemInstructionUnsupported>
      get copyWith => throw _privateConstructorUsedError;
}

TransferInfo _$TransferInfoFromJson(Map<String, dynamic> json) {
  return _TransferInfo.fromJson(json);
}

/// @nodoc
class _$TransferInfoTearOff {
  const _$TransferInfoTearOff();

  _TransferInfo call(
      {required int lamports,
      required String source,
      required String destination}) {
    return _TransferInfo(
      lamports: lamports,
      source: source,
      destination: destination,
    );
  }

  TransferInfo fromJson(Map<String, Object> json) {
    return TransferInfo.fromJson(json);
  }
}

/// @nodoc
const $TransferInfo = _$TransferInfoTearOff();

/// @nodoc
mixin _$TransferInfo {
  int get lamports => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  String get destination => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransferInfoCopyWith<TransferInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferInfoCopyWith<$Res> {
  factory $TransferInfoCopyWith(
          TransferInfo value, $Res Function(TransferInfo) then) =
      _$TransferInfoCopyWithImpl<$Res>;
  $Res call({int lamports, String source, String destination});
}

/// @nodoc
class _$TransferInfoCopyWithImpl<$Res> implements $TransferInfoCopyWith<$Res> {
  _$TransferInfoCopyWithImpl(this._value, this._then);

  final TransferInfo _value;
  // ignore: unused_field
  final $Res Function(TransferInfo) _then;

  @override
  $Res call({
    Object? lamports = freezed,
    Object? source = freezed,
    Object? destination = freezed,
  }) {
    return _then(_value.copyWith(
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
abstract class _$TransferInfoCopyWith<$Res>
    implements $TransferInfoCopyWith<$Res> {
  factory _$TransferInfoCopyWith(
          _TransferInfo value, $Res Function(_TransferInfo) then) =
      __$TransferInfoCopyWithImpl<$Res>;
  @override
  $Res call({int lamports, String source, String destination});
}

/// @nodoc
class __$TransferInfoCopyWithImpl<$Res> extends _$TransferInfoCopyWithImpl<$Res>
    implements _$TransferInfoCopyWith<$Res> {
  __$TransferInfoCopyWithImpl(
      _TransferInfo _value, $Res Function(_TransferInfo) _then)
      : super(_value, (v) => _then(v as _TransferInfo));

  @override
  _TransferInfo get _value => super._value as _TransferInfo;

  @override
  $Res call({
    Object? lamports = freezed,
    Object? source = freezed,
    Object? destination = freezed,
  }) {
    return _then(_TransferInfo(
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
@JsonSerializable()
class _$_TransferInfo implements _TransferInfo {
  const _$_TransferInfo(
      {required this.lamports,
      required this.source,
      required this.destination});

  factory _$_TransferInfo.fromJson(Map<String, dynamic> json) =>
      _$_$_TransferInfoFromJson(json);

  @override
  final int lamports;
  @override
  final String source;
  @override
  final String destination;

  @override
  String toString() {
    return 'TransferInfo(lamports: $lamports, source: $source, destination: $destination)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TransferInfo &&
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
  _$TransferInfoCopyWith<_TransferInfo> get copyWith =>
      __$TransferInfoCopyWithImpl<_TransferInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_TransferInfoToJson(this);
  }
}

abstract class _TransferInfo implements TransferInfo {
  const factory _TransferInfo(
      {required int lamports,
      required String source,
      required String destination}) = _$_TransferInfo;

  factory _TransferInfo.fromJson(Map<String, dynamic> json) =
      _$_TransferInfo.fromJson;

  @override
  int get lamports => throw _privateConstructorUsedError;
  @override
  String get source => throw _privateConstructorUsedError;
  @override
  String get destination => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$TransferInfoCopyWith<_TransferInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
