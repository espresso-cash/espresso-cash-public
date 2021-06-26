// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of decoder;

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ParsedInstruction _$ParsedInstructionFromJson(Map<String, dynamic> json) {
  switch (json['program'] as String) {
    case 'system':
      return ParsedInstructionSystem.fromJson(json);
    case 'spl-token':
      return ParsedInstructionSplToken.fromJson(json);
    case 'spl-memo':
      return ParsedInstructionMemo.fromJson(json);

    default:
      return ParsedInstructionUnsupported.fromJson(json);
  }
}

/// @nodoc
class _$ParsedInstructionTearOff {
  const _$ParsedInstructionTearOff();

  ParsedInstructionSystem system(
      {required String programId, required ParsedSystemInstruction parsed}) {
    return ParsedInstructionSystem(
      programId: programId,
      parsed: parsed,
    );
  }

  ParsedInstructionSplToken splToken(
      {required ParsedSplTokenInstruction parsed}) {
    return ParsedInstructionSplToken(
      parsed: parsed,
    );
  }

  ParsedInstructionMemo memo({@JsonKey(name: 'parsed') required String? memo}) {
    return ParsedInstructionMemo(
      memo: memo,
    );
  }

  ParsedInstructionUnsupported unsupported({required String program}) {
    return ParsedInstructionUnsupported(
      program: program,
    );
  }

  ParsedInstruction fromJson(Map<String, Object> json) {
    return ParsedInstruction.fromJson(json);
  }
}

/// @nodoc
const $ParsedInstruction = _$ParsedInstructionTearOff();

/// @nodoc
mixin _$ParsedInstruction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String programId, ParsedSystemInstruction parsed)
        system,
    required TResult Function(ParsedSplTokenInstruction parsed) splToken,
    required TResult Function(@JsonKey(name: 'parsed') String? memo) memo,
    required TResult Function(String program) unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String programId, ParsedSystemInstruction parsed)? system,
    TResult Function(ParsedSplTokenInstruction parsed)? splToken,
    TResult Function(@JsonKey(name: 'parsed') String? memo)? memo,
    TResult Function(String program)? unsupported,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ParsedInstructionSystem value) system,
    required TResult Function(ParsedInstructionSplToken value) splToken,
    required TResult Function(ParsedInstructionMemo value) memo,
    required TResult Function(ParsedInstructionUnsupported value) unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParsedInstructionSystem value)? system,
    TResult Function(ParsedInstructionSplToken value)? splToken,
    TResult Function(ParsedInstructionMemo value)? memo,
    TResult Function(ParsedInstructionUnsupported value)? unsupported,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParsedInstructionCopyWith<$Res> {
  factory $ParsedInstructionCopyWith(
          ParsedInstruction value, $Res Function(ParsedInstruction) then) =
      _$ParsedInstructionCopyWithImpl<$Res>;
}

/// @nodoc
class _$ParsedInstructionCopyWithImpl<$Res>
    implements $ParsedInstructionCopyWith<$Res> {
  _$ParsedInstructionCopyWithImpl(this._value, this._then);

  final ParsedInstruction _value;
  // ignore: unused_field
  final $Res Function(ParsedInstruction) _then;
}

/// @nodoc
abstract class $ParsedInstructionSystemCopyWith<$Res> {
  factory $ParsedInstructionSystemCopyWith(ParsedInstructionSystem value,
          $Res Function(ParsedInstructionSystem) then) =
      _$ParsedInstructionSystemCopyWithImpl<$Res>;
  $Res call({String programId, ParsedSystemInstruction parsed});

  $ParsedSystemInstructionCopyWith<$Res> get parsed;
}

/// @nodoc
class _$ParsedInstructionSystemCopyWithImpl<$Res>
    extends _$ParsedInstructionCopyWithImpl<$Res>
    implements $ParsedInstructionSystemCopyWith<$Res> {
  _$ParsedInstructionSystemCopyWithImpl(ParsedInstructionSystem _value,
      $Res Function(ParsedInstructionSystem) _then)
      : super(_value, (v) => _then(v as ParsedInstructionSystem));

  @override
  ParsedInstructionSystem get _value => super._value as ParsedInstructionSystem;

  @override
  $Res call({
    Object? programId = freezed,
    Object? parsed = freezed,
  }) {
    return _then(ParsedInstructionSystem(
      programId: programId == freezed
          ? _value.programId
          : programId // ignore: cast_nullable_to_non_nullable
              as String,
      parsed: parsed == freezed
          ? _value.parsed
          : parsed // ignore: cast_nullable_to_non_nullable
              as ParsedSystemInstruction,
    ));
  }

  @override
  $ParsedSystemInstructionCopyWith<$Res> get parsed {
    return $ParsedSystemInstructionCopyWith<$Res>(_value.parsed, (value) {
      return _then(_value.copyWith(parsed: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ParsedInstructionSystem implements ParsedInstructionSystem {
  const _$ParsedInstructionSystem(
      {required this.programId, required this.parsed});

  factory _$ParsedInstructionSystem.fromJson(Map<String, dynamic> json) =>
      _$_$ParsedInstructionSystemFromJson(json);

  @override
  final String programId;
  @override
  final ParsedSystemInstruction parsed;

  @override
  String toString() {
    return 'ParsedInstruction.system(programId: $programId, parsed: $parsed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ParsedInstructionSystem &&
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
  $ParsedInstructionSystemCopyWith<ParsedInstructionSystem> get copyWith =>
      _$ParsedInstructionSystemCopyWithImpl<ParsedInstructionSystem>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String programId, ParsedSystemInstruction parsed)
        system,
    required TResult Function(ParsedSplTokenInstruction parsed) splToken,
    required TResult Function(@JsonKey(name: 'parsed') String? memo) memo,
    required TResult Function(String program) unsupported,
  }) {
    return system(programId, parsed);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String programId, ParsedSystemInstruction parsed)? system,
    TResult Function(ParsedSplTokenInstruction parsed)? splToken,
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
    required TResult Function(ParsedInstructionSystem value) system,
    required TResult Function(ParsedInstructionSplToken value) splToken,
    required TResult Function(ParsedInstructionMemo value) memo,
    required TResult Function(ParsedInstructionUnsupported value) unsupported,
  }) {
    return system(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParsedInstructionSystem value)? system,
    TResult Function(ParsedInstructionSplToken value)? splToken,
    TResult Function(ParsedInstructionMemo value)? memo,
    TResult Function(ParsedInstructionUnsupported value)? unsupported,
    required TResult orElse(),
  }) {
    if (system != null) {
      return system(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$ParsedInstructionSystemToJson(this)..['program'] = 'system';
  }
}

abstract class ParsedInstructionSystem implements ParsedInstruction {
  const factory ParsedInstructionSystem(
      {required String programId,
      required ParsedSystemInstruction parsed}) = _$ParsedInstructionSystem;

  factory ParsedInstructionSystem.fromJson(Map<String, dynamic> json) =
      _$ParsedInstructionSystem.fromJson;

  String get programId => throw _privateConstructorUsedError;
  ParsedSystemInstruction get parsed => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ParsedInstructionSystemCopyWith<ParsedInstructionSystem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParsedInstructionSplTokenCopyWith<$Res> {
  factory $ParsedInstructionSplTokenCopyWith(ParsedInstructionSplToken value,
          $Res Function(ParsedInstructionSplToken) then) =
      _$ParsedInstructionSplTokenCopyWithImpl<$Res>;
  $Res call({ParsedSplTokenInstruction parsed});

  $ParsedSplTokenInstructionCopyWith<$Res> get parsed;
}

/// @nodoc
class _$ParsedInstructionSplTokenCopyWithImpl<$Res>
    extends _$ParsedInstructionCopyWithImpl<$Res>
    implements $ParsedInstructionSplTokenCopyWith<$Res> {
  _$ParsedInstructionSplTokenCopyWithImpl(ParsedInstructionSplToken _value,
      $Res Function(ParsedInstructionSplToken) _then)
      : super(_value, (v) => _then(v as ParsedInstructionSplToken));

  @override
  ParsedInstructionSplToken get _value =>
      super._value as ParsedInstructionSplToken;

  @override
  $Res call({
    Object? parsed = freezed,
  }) {
    return _then(ParsedInstructionSplToken(
      parsed: parsed == freezed
          ? _value.parsed
          : parsed // ignore: cast_nullable_to_non_nullable
              as ParsedSplTokenInstruction,
    ));
  }

  @override
  $ParsedSplTokenInstructionCopyWith<$Res> get parsed {
    return $ParsedSplTokenInstructionCopyWith<$Res>(_value.parsed, (value) {
      return _then(_value.copyWith(parsed: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('spl-token')
class _$ParsedInstructionSplToken implements ParsedInstructionSplToken {
  const _$ParsedInstructionSplToken({required this.parsed});

  factory _$ParsedInstructionSplToken.fromJson(Map<String, dynamic> json) =>
      _$_$ParsedInstructionSplTokenFromJson(json);

  @override
  final ParsedSplTokenInstruction parsed;

  @override
  String toString() {
    return 'ParsedInstruction.splToken(parsed: $parsed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ParsedInstructionSplToken &&
            (identical(other.parsed, parsed) ||
                const DeepCollectionEquality().equals(other.parsed, parsed)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(parsed);

  @JsonKey(ignore: true)
  @override
  $ParsedInstructionSplTokenCopyWith<ParsedInstructionSplToken> get copyWith =>
      _$ParsedInstructionSplTokenCopyWithImpl<ParsedInstructionSplToken>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String programId, ParsedSystemInstruction parsed)
        system,
    required TResult Function(ParsedSplTokenInstruction parsed) splToken,
    required TResult Function(@JsonKey(name: 'parsed') String? memo) memo,
    required TResult Function(String program) unsupported,
  }) {
    return splToken(parsed);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String programId, ParsedSystemInstruction parsed)? system,
    TResult Function(ParsedSplTokenInstruction parsed)? splToken,
    TResult Function(@JsonKey(name: 'parsed') String? memo)? memo,
    TResult Function(String program)? unsupported,
    required TResult orElse(),
  }) {
    if (splToken != null) {
      return splToken(parsed);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ParsedInstructionSystem value) system,
    required TResult Function(ParsedInstructionSplToken value) splToken,
    required TResult Function(ParsedInstructionMemo value) memo,
    required TResult Function(ParsedInstructionUnsupported value) unsupported,
  }) {
    return splToken(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParsedInstructionSystem value)? system,
    TResult Function(ParsedInstructionSplToken value)? splToken,
    TResult Function(ParsedInstructionMemo value)? memo,
    TResult Function(ParsedInstructionUnsupported value)? unsupported,
    required TResult orElse(),
  }) {
    if (splToken != null) {
      return splToken(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$ParsedInstructionSplTokenToJson(this)..['program'] = 'spl-token';
  }
}

abstract class ParsedInstructionSplToken implements ParsedInstruction {
  const factory ParsedInstructionSplToken(
          {required ParsedSplTokenInstruction parsed}) =
      _$ParsedInstructionSplToken;

  factory ParsedInstructionSplToken.fromJson(Map<String, dynamic> json) =
      _$ParsedInstructionSplToken.fromJson;

  ParsedSplTokenInstruction get parsed => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ParsedInstructionSplTokenCopyWith<ParsedInstructionSplToken> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParsedInstructionMemoCopyWith<$Res> {
  factory $ParsedInstructionMemoCopyWith(ParsedInstructionMemo value,
          $Res Function(ParsedInstructionMemo) then) =
      _$ParsedInstructionMemoCopyWithImpl<$Res>;
  $Res call({@JsonKey(name: 'parsed') String? memo});
}

/// @nodoc
class _$ParsedInstructionMemoCopyWithImpl<$Res>
    extends _$ParsedInstructionCopyWithImpl<$Res>
    implements $ParsedInstructionMemoCopyWith<$Res> {
  _$ParsedInstructionMemoCopyWithImpl(
      ParsedInstructionMemo _value, $Res Function(ParsedInstructionMemo) _then)
      : super(_value, (v) => _then(v as ParsedInstructionMemo));

  @override
  ParsedInstructionMemo get _value => super._value as ParsedInstructionMemo;

  @override
  $Res call({
    Object? memo = freezed,
  }) {
    return _then(ParsedInstructionMemo(
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
class _$ParsedInstructionMemo implements ParsedInstructionMemo {
  const _$ParsedInstructionMemo({@JsonKey(name: 'parsed') required this.memo});

  factory _$ParsedInstructionMemo.fromJson(Map<String, dynamic> json) =>
      _$_$ParsedInstructionMemoFromJson(json);

  @override
  @JsonKey(name: 'parsed')
  final String? memo;

  @override
  String toString() {
    return 'ParsedInstruction.memo(memo: $memo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ParsedInstructionMemo &&
            (identical(other.memo, memo) ||
                const DeepCollectionEquality().equals(other.memo, memo)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(memo);

  @JsonKey(ignore: true)
  @override
  $ParsedInstructionMemoCopyWith<ParsedInstructionMemo> get copyWith =>
      _$ParsedInstructionMemoCopyWithImpl<ParsedInstructionMemo>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String programId, ParsedSystemInstruction parsed)
        system,
    required TResult Function(ParsedSplTokenInstruction parsed) splToken,
    required TResult Function(@JsonKey(name: 'parsed') String? memo) memo,
    required TResult Function(String program) unsupported,
  }) {
    return memo(this.memo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String programId, ParsedSystemInstruction parsed)? system,
    TResult Function(ParsedSplTokenInstruction parsed)? splToken,
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
    required TResult Function(ParsedInstructionSystem value) system,
    required TResult Function(ParsedInstructionSplToken value) splToken,
    required TResult Function(ParsedInstructionMemo value) memo,
    required TResult Function(ParsedInstructionUnsupported value) unsupported,
  }) {
    return memo(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParsedInstructionSystem value)? system,
    TResult Function(ParsedInstructionSplToken value)? splToken,
    TResult Function(ParsedInstructionMemo value)? memo,
    TResult Function(ParsedInstructionUnsupported value)? unsupported,
    required TResult orElse(),
  }) {
    if (memo != null) {
      return memo(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$ParsedInstructionMemoToJson(this)..['program'] = 'spl-memo';
  }
}

abstract class ParsedInstructionMemo implements ParsedInstruction {
  const factory ParsedInstructionMemo(
          {@JsonKey(name: 'parsed') required String? memo}) =
      _$ParsedInstructionMemo;

  factory ParsedInstructionMemo.fromJson(Map<String, dynamic> json) =
      _$ParsedInstructionMemo.fromJson;

  @JsonKey(name: 'parsed')
  String? get memo => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ParsedInstructionMemoCopyWith<ParsedInstructionMemo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParsedInstructionUnsupportedCopyWith<$Res> {
  factory $ParsedInstructionUnsupportedCopyWith(
          ParsedInstructionUnsupported value,
          $Res Function(ParsedInstructionUnsupported) then) =
      _$ParsedInstructionUnsupportedCopyWithImpl<$Res>;
  $Res call({String program});
}

/// @nodoc
class _$ParsedInstructionUnsupportedCopyWithImpl<$Res>
    extends _$ParsedInstructionCopyWithImpl<$Res>
    implements $ParsedInstructionUnsupportedCopyWith<$Res> {
  _$ParsedInstructionUnsupportedCopyWithImpl(
      ParsedInstructionUnsupported _value,
      $Res Function(ParsedInstructionUnsupported) _then)
      : super(_value, (v) => _then(v as ParsedInstructionUnsupported));

  @override
  ParsedInstructionUnsupported get _value =>
      super._value as ParsedInstructionUnsupported;

  @override
  $Res call({
    Object? program = freezed,
  }) {
    return _then(ParsedInstructionUnsupported(
      program: program == freezed
          ? _value.program
          : program // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParsedInstructionUnsupported implements ParsedInstructionUnsupported {
  const _$ParsedInstructionUnsupported({required this.program});

  factory _$ParsedInstructionUnsupported.fromJson(Map<String, dynamic> json) =>
      _$_$ParsedInstructionUnsupportedFromJson(json);

  @override
  final String program;

  @override
  String toString() {
    return 'ParsedInstruction.unsupported(program: $program)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ParsedInstructionUnsupported &&
            (identical(other.program, program) ||
                const DeepCollectionEquality().equals(other.program, program)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(program);

  @JsonKey(ignore: true)
  @override
  $ParsedInstructionUnsupportedCopyWith<ParsedInstructionUnsupported>
      get copyWith => _$ParsedInstructionUnsupportedCopyWithImpl<
          ParsedInstructionUnsupported>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String programId, ParsedSystemInstruction parsed)
        system,
    required TResult Function(ParsedSplTokenInstruction parsed) splToken,
    required TResult Function(@JsonKey(name: 'parsed') String? memo) memo,
    required TResult Function(String program) unsupported,
  }) {
    return unsupported(program);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String programId, ParsedSystemInstruction parsed)? system,
    TResult Function(ParsedSplTokenInstruction parsed)? splToken,
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
    required TResult Function(ParsedInstructionSystem value) system,
    required TResult Function(ParsedInstructionSplToken value) splToken,
    required TResult Function(ParsedInstructionMemo value) memo,
    required TResult Function(ParsedInstructionUnsupported value) unsupported,
  }) {
    return unsupported(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParsedInstructionSystem value)? system,
    TResult Function(ParsedInstructionSplToken value)? splToken,
    TResult Function(ParsedInstructionMemo value)? memo,
    TResult Function(ParsedInstructionUnsupported value)? unsupported,
    required TResult orElse(),
  }) {
    if (unsupported != null) {
      return unsupported(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$ParsedInstructionUnsupportedToJson(this)
      ..['program'] = 'unsupported';
  }
}

abstract class ParsedInstructionUnsupported implements ParsedInstruction {
  const factory ParsedInstructionUnsupported({required String program}) =
      _$ParsedInstructionUnsupported;

  factory ParsedInstructionUnsupported.fromJson(Map<String, dynamic> json) =
      _$ParsedInstructionUnsupported.fromJson;

  String get program => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ParsedInstructionUnsupportedCopyWith<ParsedInstructionUnsupported>
      get copyWith => throw _privateConstructorUsedError;
}

ParsedSplTokenInstruction _$ParsedSplTokenInstructionFromJson(
    Map<String, dynamic> json) {
  switch (json['type'] as String) {
    case 'transfer':
      return ParsedSplTokenTransferInstruction.fromJson(json);

    default:
      return ParsedSplTokenUnsupportedInstruction.fromJson(json);
  }
}

/// @nodoc
class _$ParsedSplTokenInstructionTearOff {
  const _$ParsedSplTokenInstructionTearOff();

  ParsedSplTokenTransferInstruction transfer(
      {required ParsedSplTokenTransferInformation info, required String type}) {
    return ParsedSplTokenTransferInstruction(
      info: info,
      type: type,
    );
  }

  ParsedSplTokenUnsupportedInstruction unsupported({required String type}) {
    return ParsedSplTokenUnsupportedInstruction(
      type: type,
    );
  }

  ParsedSplTokenInstruction fromJson(Map<String, Object> json) {
    return ParsedSplTokenInstruction.fromJson(json);
  }
}

/// @nodoc
const $ParsedSplTokenInstruction = _$ParsedSplTokenInstructionTearOff();

/// @nodoc
mixin _$ParsedSplTokenInstruction {
  String get type => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            ParsedSplTokenTransferInformation info, String type)
        transfer,
    required TResult Function(String type) unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParsedSplTokenTransferInformation info, String type)?
        transfer,
    TResult Function(String type)? unsupported,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ParsedSplTokenTransferInstruction value) transfer,
    required TResult Function(ParsedSplTokenUnsupportedInstruction value)
        unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParsedSplTokenTransferInstruction value)? transfer,
    TResult Function(ParsedSplTokenUnsupportedInstruction value)? unsupported,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ParsedSplTokenInstructionCopyWith<ParsedSplTokenInstruction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParsedSplTokenInstructionCopyWith<$Res> {
  factory $ParsedSplTokenInstructionCopyWith(ParsedSplTokenInstruction value,
          $Res Function(ParsedSplTokenInstruction) then) =
      _$ParsedSplTokenInstructionCopyWithImpl<$Res>;
  $Res call({String type});
}

/// @nodoc
class _$ParsedSplTokenInstructionCopyWithImpl<$Res>
    implements $ParsedSplTokenInstructionCopyWith<$Res> {
  _$ParsedSplTokenInstructionCopyWithImpl(this._value, this._then);

  final ParsedSplTokenInstruction _value;
  // ignore: unused_field
  final $Res Function(ParsedSplTokenInstruction) _then;

  @override
  $Res call({
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class $ParsedSplTokenTransferInstructionCopyWith<$Res>
    implements $ParsedSplTokenInstructionCopyWith<$Res> {
  factory $ParsedSplTokenTransferInstructionCopyWith(
          ParsedSplTokenTransferInstruction value,
          $Res Function(ParsedSplTokenTransferInstruction) then) =
      _$ParsedSplTokenTransferInstructionCopyWithImpl<$Res>;
  @override
  $Res call({ParsedSplTokenTransferInformation info, String type});

  $ParsedSplTokenTransferInformationCopyWith<$Res> get info;
}

/// @nodoc
class _$ParsedSplTokenTransferInstructionCopyWithImpl<$Res>
    extends _$ParsedSplTokenInstructionCopyWithImpl<$Res>
    implements $ParsedSplTokenTransferInstructionCopyWith<$Res> {
  _$ParsedSplTokenTransferInstructionCopyWithImpl(
      ParsedSplTokenTransferInstruction _value,
      $Res Function(ParsedSplTokenTransferInstruction) _then)
      : super(_value, (v) => _then(v as ParsedSplTokenTransferInstruction));

  @override
  ParsedSplTokenTransferInstruction get _value =>
      super._value as ParsedSplTokenTransferInstruction;

  @override
  $Res call({
    Object? info = freezed,
    Object? type = freezed,
  }) {
    return _then(ParsedSplTokenTransferInstruction(
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as ParsedSplTokenTransferInformation,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $ParsedSplTokenTransferInformationCopyWith<$Res> get info {
    return $ParsedSplTokenTransferInformationCopyWith<$Res>(_value.info,
        (value) {
      return _then(_value.copyWith(info: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ParsedSplTokenTransferInstruction
    implements ParsedSplTokenTransferInstruction {
  const _$ParsedSplTokenTransferInstruction(
      {required this.info, required this.type});

  factory _$ParsedSplTokenTransferInstruction.fromJson(
          Map<String, dynamic> json) =>
      _$_$ParsedSplTokenTransferInstructionFromJson(json);

  @override
  final ParsedSplTokenTransferInformation info;
  @override
  final String type;

  @override
  String toString() {
    return 'ParsedSplTokenInstruction.transfer(info: $info, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ParsedSplTokenTransferInstruction &&
            (identical(other.info, info) ||
                const DeepCollectionEquality().equals(other.info, info)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(info) ^
      const DeepCollectionEquality().hash(type);

  @JsonKey(ignore: true)
  @override
  $ParsedSplTokenTransferInstructionCopyWith<ParsedSplTokenTransferInstruction>
      get copyWith => _$ParsedSplTokenTransferInstructionCopyWithImpl<
          ParsedSplTokenTransferInstruction>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            ParsedSplTokenTransferInformation info, String type)
        transfer,
    required TResult Function(String type) unsupported,
  }) {
    return transfer(info, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParsedSplTokenTransferInformation info, String type)?
        transfer,
    TResult Function(String type)? unsupported,
    required TResult orElse(),
  }) {
    if (transfer != null) {
      return transfer(info, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ParsedSplTokenTransferInstruction value) transfer,
    required TResult Function(ParsedSplTokenUnsupportedInstruction value)
        unsupported,
  }) {
    return transfer(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParsedSplTokenTransferInstruction value)? transfer,
    TResult Function(ParsedSplTokenUnsupportedInstruction value)? unsupported,
    required TResult orElse(),
  }) {
    if (transfer != null) {
      return transfer(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$ParsedSplTokenTransferInstructionToJson(this)
      ..['type'] = 'transfer';
  }
}

abstract class ParsedSplTokenTransferInstruction
    implements ParsedSplTokenInstruction {
  const factory ParsedSplTokenTransferInstruction(
      {required ParsedSplTokenTransferInformation info,
      required String type}) = _$ParsedSplTokenTransferInstruction;

  factory ParsedSplTokenTransferInstruction.fromJson(
      Map<String, dynamic> json) = _$ParsedSplTokenTransferInstruction.fromJson;

  ParsedSplTokenTransferInformation get info =>
      throw _privateConstructorUsedError;
  @override
  String get type => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $ParsedSplTokenTransferInstructionCopyWith<ParsedSplTokenTransferInstruction>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParsedSplTokenUnsupportedInstructionCopyWith<$Res>
    implements $ParsedSplTokenInstructionCopyWith<$Res> {
  factory $ParsedSplTokenUnsupportedInstructionCopyWith(
          ParsedSplTokenUnsupportedInstruction value,
          $Res Function(ParsedSplTokenUnsupportedInstruction) then) =
      _$ParsedSplTokenUnsupportedInstructionCopyWithImpl<$Res>;
  @override
  $Res call({String type});
}

/// @nodoc
class _$ParsedSplTokenUnsupportedInstructionCopyWithImpl<$Res>
    extends _$ParsedSplTokenInstructionCopyWithImpl<$Res>
    implements $ParsedSplTokenUnsupportedInstructionCopyWith<$Res> {
  _$ParsedSplTokenUnsupportedInstructionCopyWithImpl(
      ParsedSplTokenUnsupportedInstruction _value,
      $Res Function(ParsedSplTokenUnsupportedInstruction) _then)
      : super(_value, (v) => _then(v as ParsedSplTokenUnsupportedInstruction));

  @override
  ParsedSplTokenUnsupportedInstruction get _value =>
      super._value as ParsedSplTokenUnsupportedInstruction;

  @override
  $Res call({
    Object? type = freezed,
  }) {
    return _then(ParsedSplTokenUnsupportedInstruction(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParsedSplTokenUnsupportedInstruction
    implements ParsedSplTokenUnsupportedInstruction {
  const _$ParsedSplTokenUnsupportedInstruction({required this.type});

  factory _$ParsedSplTokenUnsupportedInstruction.fromJson(
          Map<String, dynamic> json) =>
      _$_$ParsedSplTokenUnsupportedInstructionFromJson(json);

  @override
  final String type;

  @override
  String toString() {
    return 'ParsedSplTokenInstruction.unsupported(type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ParsedSplTokenUnsupportedInstruction &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(type);

  @JsonKey(ignore: true)
  @override
  $ParsedSplTokenUnsupportedInstructionCopyWith<
          ParsedSplTokenUnsupportedInstruction>
      get copyWith => _$ParsedSplTokenUnsupportedInstructionCopyWithImpl<
          ParsedSplTokenUnsupportedInstruction>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            ParsedSplTokenTransferInformation info, String type)
        transfer,
    required TResult Function(String type) unsupported,
  }) {
    return unsupported(type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParsedSplTokenTransferInformation info, String type)?
        transfer,
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
    required TResult Function(ParsedSplTokenTransferInstruction value) transfer,
    required TResult Function(ParsedSplTokenUnsupportedInstruction value)
        unsupported,
  }) {
    return unsupported(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParsedSplTokenTransferInstruction value)? transfer,
    TResult Function(ParsedSplTokenUnsupportedInstruction value)? unsupported,
    required TResult orElse(),
  }) {
    if (unsupported != null) {
      return unsupported(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$ParsedSplTokenUnsupportedInstructionToJson(this)
      ..['type'] = 'unsupported';
  }
}

abstract class ParsedSplTokenUnsupportedInstruction
    implements ParsedSplTokenInstruction {
  const factory ParsedSplTokenUnsupportedInstruction({required String type}) =
      _$ParsedSplTokenUnsupportedInstruction;

  factory ParsedSplTokenUnsupportedInstruction.fromJson(
          Map<String, dynamic> json) =
      _$ParsedSplTokenUnsupportedInstruction.fromJson;

  @override
  String get type => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $ParsedSplTokenUnsupportedInstructionCopyWith<
          ParsedSplTokenUnsupportedInstruction>
      get copyWith => throw _privateConstructorUsedError;
}

ParsedSplTokenTransferInformation _$ParsedSplTokenTransferInformationFromJson(
    Map<String, dynamic> json) {
  return _ParsedSplTokenTransferInformation.fromJson(json);
}

/// @nodoc
class _$ParsedSplTokenTransferInformationTearOff {
  const _$ParsedSplTokenTransferInformationTearOff();

  _ParsedSplTokenTransferInformation call(
      {required String amount,
      required String authority,
      required String source,
      required String destination}) {
    return _ParsedSplTokenTransferInformation(
      amount: amount,
      authority: authority,
      source: source,
      destination: destination,
    );
  }

  ParsedSplTokenTransferInformation fromJson(Map<String, Object> json) {
    return ParsedSplTokenTransferInformation.fromJson(json);
  }
}

/// @nodoc
const $ParsedSplTokenTransferInformation =
    _$ParsedSplTokenTransferInformationTearOff();

/// @nodoc
mixin _$ParsedSplTokenTransferInformation {
  String get amount => throw _privateConstructorUsedError;
  String get authority => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  String get destination => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ParsedSplTokenTransferInformationCopyWith<ParsedSplTokenTransferInformation>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParsedSplTokenTransferInformationCopyWith<$Res> {
  factory $ParsedSplTokenTransferInformationCopyWith(
          ParsedSplTokenTransferInformation value,
          $Res Function(ParsedSplTokenTransferInformation) then) =
      _$ParsedSplTokenTransferInformationCopyWithImpl<$Res>;
  $Res call(
      {String amount, String authority, String source, String destination});
}

/// @nodoc
class _$ParsedSplTokenTransferInformationCopyWithImpl<$Res>
    implements $ParsedSplTokenTransferInformationCopyWith<$Res> {
  _$ParsedSplTokenTransferInformationCopyWithImpl(this._value, this._then);

  final ParsedSplTokenTransferInformation _value;
  // ignore: unused_field
  final $Res Function(ParsedSplTokenTransferInformation) _then;

  @override
  $Res call({
    Object? amount = freezed,
    Object? authority = freezed,
    Object? source = freezed,
    Object? destination = freezed,
  }) {
    return _then(_value.copyWith(
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      authority: authority == freezed
          ? _value.authority
          : authority // ignore: cast_nullable_to_non_nullable
              as String,
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
abstract class _$ParsedSplTokenTransferInformationCopyWith<$Res>
    implements $ParsedSplTokenTransferInformationCopyWith<$Res> {
  factory _$ParsedSplTokenTransferInformationCopyWith(
          _ParsedSplTokenTransferInformation value,
          $Res Function(_ParsedSplTokenTransferInformation) then) =
      __$ParsedSplTokenTransferInformationCopyWithImpl<$Res>;
  @override
  $Res call(
      {String amount, String authority, String source, String destination});
}

/// @nodoc
class __$ParsedSplTokenTransferInformationCopyWithImpl<$Res>
    extends _$ParsedSplTokenTransferInformationCopyWithImpl<$Res>
    implements _$ParsedSplTokenTransferInformationCopyWith<$Res> {
  __$ParsedSplTokenTransferInformationCopyWithImpl(
      _ParsedSplTokenTransferInformation _value,
      $Res Function(_ParsedSplTokenTransferInformation) _then)
      : super(_value, (v) => _then(v as _ParsedSplTokenTransferInformation));

  @override
  _ParsedSplTokenTransferInformation get _value =>
      super._value as _ParsedSplTokenTransferInformation;

  @override
  $Res call({
    Object? amount = freezed,
    Object? authority = freezed,
    Object? source = freezed,
    Object? destination = freezed,
  }) {
    return _then(_ParsedSplTokenTransferInformation(
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      authority: authority == freezed
          ? _value.authority
          : authority // ignore: cast_nullable_to_non_nullable
              as String,
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
class _$_ParsedSplTokenTransferInformation
    implements _ParsedSplTokenTransferInformation {
  const _$_ParsedSplTokenTransferInformation(
      {required this.amount,
      required this.authority,
      required this.source,
      required this.destination});

  factory _$_ParsedSplTokenTransferInformation.fromJson(
          Map<String, dynamic> json) =>
      _$_$_ParsedSplTokenTransferInformationFromJson(json);

  @override
  final String amount;
  @override
  final String authority;
  @override
  final String source;
  @override
  final String destination;

  @override
  String toString() {
    return 'ParsedSplTokenTransferInformation(amount: $amount, authority: $authority, source: $source, destination: $destination)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ParsedSplTokenTransferInformation &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.authority, authority) ||
                const DeepCollectionEquality()
                    .equals(other.authority, authority)) &&
            (identical(other.source, source) ||
                const DeepCollectionEquality().equals(other.source, source)) &&
            (identical(other.destination, destination) ||
                const DeepCollectionEquality()
                    .equals(other.destination, destination)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(amount) ^
      const DeepCollectionEquality().hash(authority) ^
      const DeepCollectionEquality().hash(source) ^
      const DeepCollectionEquality().hash(destination);

  @JsonKey(ignore: true)
  @override
  _$ParsedSplTokenTransferInformationCopyWith<
          _ParsedSplTokenTransferInformation>
      get copyWith => __$ParsedSplTokenTransferInformationCopyWithImpl<
          _ParsedSplTokenTransferInformation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ParsedSplTokenTransferInformationToJson(this);
  }
}

abstract class _ParsedSplTokenTransferInformation
    implements ParsedSplTokenTransferInformation {
  const factory _ParsedSplTokenTransferInformation(
      {required String amount,
      required String authority,
      required String source,
      required String destination}) = _$_ParsedSplTokenTransferInformation;

  factory _ParsedSplTokenTransferInformation.fromJson(
          Map<String, dynamic> json) =
      _$_ParsedSplTokenTransferInformation.fromJson;

  @override
  String get amount => throw _privateConstructorUsedError;
  @override
  String get authority => throw _privateConstructorUsedError;
  @override
  String get source => throw _privateConstructorUsedError;
  @override
  String get destination => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ParsedSplTokenTransferInformationCopyWith<
          _ParsedSplTokenTransferInformation>
      get copyWith => throw _privateConstructorUsedError;
}

ParsedSystemInstruction _$ParsedSystemInstructionFromJson(
    Map<String, dynamic> json) {
  switch (json['type'] as String) {
    case 'transfer':
      return ParsedSystemTransferInstruction.fromJson(json);

    default:
      return ParsedSystemUnsupportedInstruction.fromJson(json);
  }
}

/// @nodoc
class _$ParsedSystemInstructionTearOff {
  const _$ParsedSystemInstructionTearOff();

  ParsedSystemTransferInstruction transfer(
      {required ParsedSystemTransferInformation info, required String type}) {
    return ParsedSystemTransferInstruction(
      info: info,
      type: type,
    );
  }

  ParsedSystemUnsupportedInstruction unsupported({required String type}) {
    return ParsedSystemUnsupportedInstruction(
      type: type,
    );
  }

  ParsedSystemInstruction fromJson(Map<String, Object> json) {
    return ParsedSystemInstruction.fromJson(json);
  }
}

/// @nodoc
const $ParsedSystemInstruction = _$ParsedSystemInstructionTearOff();

/// @nodoc
mixin _$ParsedSystemInstruction {
  String get type => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ParsedSystemTransferInformation info, String type)
        transfer,
    required TResult Function(String type) unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParsedSystemTransferInformation info, String type)?
        transfer,
    TResult Function(String type)? unsupported,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ParsedSystemTransferInstruction value) transfer,
    required TResult Function(ParsedSystemUnsupportedInstruction value)
        unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParsedSystemTransferInstruction value)? transfer,
    TResult Function(ParsedSystemUnsupportedInstruction value)? unsupported,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ParsedSystemInstructionCopyWith<ParsedSystemInstruction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParsedSystemInstructionCopyWith<$Res> {
  factory $ParsedSystemInstructionCopyWith(ParsedSystemInstruction value,
          $Res Function(ParsedSystemInstruction) then) =
      _$ParsedSystemInstructionCopyWithImpl<$Res>;
  $Res call({String type});
}

/// @nodoc
class _$ParsedSystemInstructionCopyWithImpl<$Res>
    implements $ParsedSystemInstructionCopyWith<$Res> {
  _$ParsedSystemInstructionCopyWithImpl(this._value, this._then);

  final ParsedSystemInstruction _value;
  // ignore: unused_field
  final $Res Function(ParsedSystemInstruction) _then;

  @override
  $Res call({
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class $ParsedSystemTransferInstructionCopyWith<$Res>
    implements $ParsedSystemInstructionCopyWith<$Res> {
  factory $ParsedSystemTransferInstructionCopyWith(
          ParsedSystemTransferInstruction value,
          $Res Function(ParsedSystemTransferInstruction) then) =
      _$ParsedSystemTransferInstructionCopyWithImpl<$Res>;
  @override
  $Res call({ParsedSystemTransferInformation info, String type});

  $ParsedSystemTransferInformationCopyWith<$Res> get info;
}

/// @nodoc
class _$ParsedSystemTransferInstructionCopyWithImpl<$Res>
    extends _$ParsedSystemInstructionCopyWithImpl<$Res>
    implements $ParsedSystemTransferInstructionCopyWith<$Res> {
  _$ParsedSystemTransferInstructionCopyWithImpl(
      ParsedSystemTransferInstruction _value,
      $Res Function(ParsedSystemTransferInstruction) _then)
      : super(_value, (v) => _then(v as ParsedSystemTransferInstruction));

  @override
  ParsedSystemTransferInstruction get _value =>
      super._value as ParsedSystemTransferInstruction;

  @override
  $Res call({
    Object? info = freezed,
    Object? type = freezed,
  }) {
    return _then(ParsedSystemTransferInstruction(
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as ParsedSystemTransferInformation,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $ParsedSystemTransferInformationCopyWith<$Res> get info {
    return $ParsedSystemTransferInformationCopyWith<$Res>(_value.info, (value) {
      return _then(_value.copyWith(info: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ParsedSystemTransferInstruction
    implements ParsedSystemTransferInstruction {
  const _$ParsedSystemTransferInstruction(
      {required this.info, required this.type});

  factory _$ParsedSystemTransferInstruction.fromJson(
          Map<String, dynamic> json) =>
      _$_$ParsedSystemTransferInstructionFromJson(json);

  @override
  final ParsedSystemTransferInformation info;
  @override
  final String type;

  @override
  String toString() {
    return 'ParsedSystemInstruction.transfer(info: $info, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ParsedSystemTransferInstruction &&
            (identical(other.info, info) ||
                const DeepCollectionEquality().equals(other.info, info)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(info) ^
      const DeepCollectionEquality().hash(type);

  @JsonKey(ignore: true)
  @override
  $ParsedSystemTransferInstructionCopyWith<ParsedSystemTransferInstruction>
      get copyWith => _$ParsedSystemTransferInstructionCopyWithImpl<
          ParsedSystemTransferInstruction>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ParsedSystemTransferInformation info, String type)
        transfer,
    required TResult Function(String type) unsupported,
  }) {
    return transfer(info, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParsedSystemTransferInformation info, String type)?
        transfer,
    TResult Function(String type)? unsupported,
    required TResult orElse(),
  }) {
    if (transfer != null) {
      return transfer(info, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ParsedSystemTransferInstruction value) transfer,
    required TResult Function(ParsedSystemUnsupportedInstruction value)
        unsupported,
  }) {
    return transfer(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParsedSystemTransferInstruction value)? transfer,
    TResult Function(ParsedSystemUnsupportedInstruction value)? unsupported,
    required TResult orElse(),
  }) {
    if (transfer != null) {
      return transfer(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$ParsedSystemTransferInstructionToJson(this)
      ..['type'] = 'transfer';
  }
}

abstract class ParsedSystemTransferInstruction
    implements ParsedSystemInstruction {
  const factory ParsedSystemTransferInstruction(
      {required ParsedSystemTransferInformation info,
      required String type}) = _$ParsedSystemTransferInstruction;

  factory ParsedSystemTransferInstruction.fromJson(Map<String, dynamic> json) =
      _$ParsedSystemTransferInstruction.fromJson;

  ParsedSystemTransferInformation get info =>
      throw _privateConstructorUsedError;
  @override
  String get type => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $ParsedSystemTransferInstructionCopyWith<ParsedSystemTransferInstruction>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParsedSystemUnsupportedInstructionCopyWith<$Res>
    implements $ParsedSystemInstructionCopyWith<$Res> {
  factory $ParsedSystemUnsupportedInstructionCopyWith(
          ParsedSystemUnsupportedInstruction value,
          $Res Function(ParsedSystemUnsupportedInstruction) then) =
      _$ParsedSystemUnsupportedInstructionCopyWithImpl<$Res>;
  @override
  $Res call({String type});
}

/// @nodoc
class _$ParsedSystemUnsupportedInstructionCopyWithImpl<$Res>
    extends _$ParsedSystemInstructionCopyWithImpl<$Res>
    implements $ParsedSystemUnsupportedInstructionCopyWith<$Res> {
  _$ParsedSystemUnsupportedInstructionCopyWithImpl(
      ParsedSystemUnsupportedInstruction _value,
      $Res Function(ParsedSystemUnsupportedInstruction) _then)
      : super(_value, (v) => _then(v as ParsedSystemUnsupportedInstruction));

  @override
  ParsedSystemUnsupportedInstruction get _value =>
      super._value as ParsedSystemUnsupportedInstruction;

  @override
  $Res call({
    Object? type = freezed,
  }) {
    return _then(ParsedSystemUnsupportedInstruction(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParsedSystemUnsupportedInstruction
    implements ParsedSystemUnsupportedInstruction {
  const _$ParsedSystemUnsupportedInstruction({required this.type});

  factory _$ParsedSystemUnsupportedInstruction.fromJson(
          Map<String, dynamic> json) =>
      _$_$ParsedSystemUnsupportedInstructionFromJson(json);

  @override
  final String type;

  @override
  String toString() {
    return 'ParsedSystemInstruction.unsupported(type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ParsedSystemUnsupportedInstruction &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(type);

  @JsonKey(ignore: true)
  @override
  $ParsedSystemUnsupportedInstructionCopyWith<
          ParsedSystemUnsupportedInstruction>
      get copyWith => _$ParsedSystemUnsupportedInstructionCopyWithImpl<
          ParsedSystemUnsupportedInstruction>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ParsedSystemTransferInformation info, String type)
        transfer,
    required TResult Function(String type) unsupported,
  }) {
    return unsupported(type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParsedSystemTransferInformation info, String type)?
        transfer,
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
    required TResult Function(ParsedSystemTransferInstruction value) transfer,
    required TResult Function(ParsedSystemUnsupportedInstruction value)
        unsupported,
  }) {
    return unsupported(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParsedSystemTransferInstruction value)? transfer,
    TResult Function(ParsedSystemUnsupportedInstruction value)? unsupported,
    required TResult orElse(),
  }) {
    if (unsupported != null) {
      return unsupported(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$ParsedSystemUnsupportedInstructionToJson(this)
      ..['type'] = 'unsupported';
  }
}

abstract class ParsedSystemUnsupportedInstruction
    implements ParsedSystemInstruction {
  const factory ParsedSystemUnsupportedInstruction({required String type}) =
      _$ParsedSystemUnsupportedInstruction;

  factory ParsedSystemUnsupportedInstruction.fromJson(
          Map<String, dynamic> json) =
      _$ParsedSystemUnsupportedInstruction.fromJson;

  @override
  String get type => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $ParsedSystemUnsupportedInstructionCopyWith<
          ParsedSystemUnsupportedInstruction>
      get copyWith => throw _privateConstructorUsedError;
}

ParsedSystemTransferInformation _$ParsedSystemTransferInformationFromJson(
    Map<String, dynamic> json) {
  return _ParsedSystemTransferInformation.fromJson(json);
}

/// @nodoc
class _$ParsedSystemTransferInformationTearOff {
  const _$ParsedSystemTransferInformationTearOff();

  _ParsedSystemTransferInformation call(
      {required int lamports,
      required String source,
      required String destination}) {
    return _ParsedSystemTransferInformation(
      lamports: lamports,
      source: source,
      destination: destination,
    );
  }

  ParsedSystemTransferInformation fromJson(Map<String, Object> json) {
    return ParsedSystemTransferInformation.fromJson(json);
  }
}

/// @nodoc
const $ParsedSystemTransferInformation =
    _$ParsedSystemTransferInformationTearOff();

/// @nodoc
mixin _$ParsedSystemTransferInformation {
  int get lamports => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  String get destination => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ParsedSystemTransferInformationCopyWith<ParsedSystemTransferInformation>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParsedSystemTransferInformationCopyWith<$Res> {
  factory $ParsedSystemTransferInformationCopyWith(
          ParsedSystemTransferInformation value,
          $Res Function(ParsedSystemTransferInformation) then) =
      _$ParsedSystemTransferInformationCopyWithImpl<$Res>;
  $Res call({int lamports, String source, String destination});
}

/// @nodoc
class _$ParsedSystemTransferInformationCopyWithImpl<$Res>
    implements $ParsedSystemTransferInformationCopyWith<$Res> {
  _$ParsedSystemTransferInformationCopyWithImpl(this._value, this._then);

  final ParsedSystemTransferInformation _value;
  // ignore: unused_field
  final $Res Function(ParsedSystemTransferInformation) _then;

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
abstract class _$ParsedSystemTransferInformationCopyWith<$Res>
    implements $ParsedSystemTransferInformationCopyWith<$Res> {
  factory _$ParsedSystemTransferInformationCopyWith(
          _ParsedSystemTransferInformation value,
          $Res Function(_ParsedSystemTransferInformation) then) =
      __$ParsedSystemTransferInformationCopyWithImpl<$Res>;
  @override
  $Res call({int lamports, String source, String destination});
}

/// @nodoc
class __$ParsedSystemTransferInformationCopyWithImpl<$Res>
    extends _$ParsedSystemTransferInformationCopyWithImpl<$Res>
    implements _$ParsedSystemTransferInformationCopyWith<$Res> {
  __$ParsedSystemTransferInformationCopyWithImpl(
      _ParsedSystemTransferInformation _value,
      $Res Function(_ParsedSystemTransferInformation) _then)
      : super(_value, (v) => _then(v as _ParsedSystemTransferInformation));

  @override
  _ParsedSystemTransferInformation get _value =>
      super._value as _ParsedSystemTransferInformation;

  @override
  $Res call({
    Object? lamports = freezed,
    Object? source = freezed,
    Object? destination = freezed,
  }) {
    return _then(_ParsedSystemTransferInformation(
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
class _$_ParsedSystemTransferInformation
    implements _ParsedSystemTransferInformation {
  const _$_ParsedSystemTransferInformation(
      {required this.lamports,
      required this.source,
      required this.destination});

  factory _$_ParsedSystemTransferInformation.fromJson(
          Map<String, dynamic> json) =>
      _$_$_ParsedSystemTransferInformationFromJson(json);

  @override
  final int lamports;
  @override
  final String source;
  @override
  final String destination;

  @override
  String toString() {
    return 'ParsedSystemTransferInformation(lamports: $lamports, source: $source, destination: $destination)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ParsedSystemTransferInformation &&
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
  _$ParsedSystemTransferInformationCopyWith<_ParsedSystemTransferInformation>
      get copyWith => __$ParsedSystemTransferInformationCopyWithImpl<
          _ParsedSystemTransferInformation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ParsedSystemTransferInformationToJson(this);
  }
}

abstract class _ParsedSystemTransferInformation
    implements ParsedSystemTransferInformation {
  const factory _ParsedSystemTransferInformation(
      {required int lamports,
      required String source,
      required String destination}) = _$_ParsedSystemTransferInformation;

  factory _ParsedSystemTransferInformation.fromJson(Map<String, dynamic> json) =
      _$_ParsedSystemTransferInformation.fromJson;

  @override
  int get lamports => throw _privateConstructorUsedError;
  @override
  String get source => throw _privateConstructorUsedError;
  @override
  String get destination => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ParsedSystemTransferInformationCopyWith<_ParsedSystemTransferInformation>
      get copyWith => throw _privateConstructorUsedError;
}
