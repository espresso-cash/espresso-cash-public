// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'parsed_instruction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ParsedInstruction _$ParsedInstructionFromJson(Map<String, dynamic> json) {
  switch (json['program'] as String?) {
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

  ParsedInstructionUnsupported unsupported({String? program}) {
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
    required TResult Function(String? program) unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String programId, ParsedSystemInstruction parsed)? system,
    TResult Function(ParsedSplTokenInstruction parsed)? splToken,
    TResult Function(@JsonKey(name: 'parsed') String? memo)? memo,
    TResult Function(String? program)? unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String programId, ParsedSystemInstruction parsed)? system,
    TResult Function(ParsedSplTokenInstruction parsed)? splToken,
    TResult Function(@JsonKey(name: 'parsed') String? memo)? memo,
    TResult Function(String? program)? unsupported,
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ParsedInstructionSystem value)? system,
    TResult Function(ParsedInstructionSplToken value)? splToken,
    TResult Function(ParsedInstructionMemo value)? memo,
    TResult Function(ParsedInstructionUnsupported value)? unsupported,
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
      _$$ParsedInstructionSystemFromJson(json);

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
    required TResult Function(String? program) unsupported,
  }) {
    return system(programId, parsed);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String programId, ParsedSystemInstruction parsed)? system,
    TResult Function(ParsedSplTokenInstruction parsed)? splToken,
    TResult Function(@JsonKey(name: 'parsed') String? memo)? memo,
    TResult Function(String? program)? unsupported,
  }) {
    return system?.call(programId, parsed);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String programId, ParsedSystemInstruction parsed)? system,
    TResult Function(ParsedSplTokenInstruction parsed)? splToken,
    TResult Function(@JsonKey(name: 'parsed') String? memo)? memo,
    TResult Function(String? program)? unsupported,
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ParsedInstructionSystem value)? system,
    TResult Function(ParsedInstructionSplToken value)? splToken,
    TResult Function(ParsedInstructionMemo value)? memo,
    TResult Function(ParsedInstructionUnsupported value)? unsupported,
  }) {
    return system?.call(this);
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
    return _$$ParsedInstructionSystemToJson(this)..['program'] = 'system';
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
      _$$ParsedInstructionSplTokenFromJson(json);

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
    required TResult Function(String? program) unsupported,
  }) {
    return splToken(parsed);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String programId, ParsedSystemInstruction parsed)? system,
    TResult Function(ParsedSplTokenInstruction parsed)? splToken,
    TResult Function(@JsonKey(name: 'parsed') String? memo)? memo,
    TResult Function(String? program)? unsupported,
  }) {
    return splToken?.call(parsed);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String programId, ParsedSystemInstruction parsed)? system,
    TResult Function(ParsedSplTokenInstruction parsed)? splToken,
    TResult Function(@JsonKey(name: 'parsed') String? memo)? memo,
    TResult Function(String? program)? unsupported,
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ParsedInstructionSystem value)? system,
    TResult Function(ParsedInstructionSplToken value)? splToken,
    TResult Function(ParsedInstructionMemo value)? memo,
    TResult Function(ParsedInstructionUnsupported value)? unsupported,
  }) {
    return splToken?.call(this);
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
    return _$$ParsedInstructionSplTokenToJson(this)..['program'] = 'spl-token';
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
      _$$ParsedInstructionMemoFromJson(json);

  @override // This ignore is needed until https://github.com/dart-lang/linter/issues/2778 is fixed
// ignore: invalid_annotation_target
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
    required TResult Function(String? program) unsupported,
  }) {
    return memo(this.memo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String programId, ParsedSystemInstruction parsed)? system,
    TResult Function(ParsedSplTokenInstruction parsed)? splToken,
    TResult Function(@JsonKey(name: 'parsed') String? memo)? memo,
    TResult Function(String? program)? unsupported,
  }) {
    return memo?.call(this.memo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String programId, ParsedSystemInstruction parsed)? system,
    TResult Function(ParsedSplTokenInstruction parsed)? splToken,
    TResult Function(@JsonKey(name: 'parsed') String? memo)? memo,
    TResult Function(String? program)? unsupported,
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ParsedInstructionSystem value)? system,
    TResult Function(ParsedInstructionSplToken value)? splToken,
    TResult Function(ParsedInstructionMemo value)? memo,
    TResult Function(ParsedInstructionUnsupported value)? unsupported,
  }) {
    return memo?.call(this);
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
    return _$$ParsedInstructionMemoToJson(this)..['program'] = 'spl-memo';
  }
}

abstract class ParsedInstructionMemo implements ParsedInstruction {
  const factory ParsedInstructionMemo(
          {@JsonKey(name: 'parsed') required String? memo}) =
      _$ParsedInstructionMemo;

  factory ParsedInstructionMemo.fromJson(Map<String, dynamic> json) =
      _$ParsedInstructionMemo.fromJson;

// This ignore is needed until https://github.com/dart-lang/linter/issues/2778 is fixed
// ignore: invalid_annotation_target
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
  $Res call({String? program});
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
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParsedInstructionUnsupported implements ParsedInstructionUnsupported {
  const _$ParsedInstructionUnsupported({this.program});

  factory _$ParsedInstructionUnsupported.fromJson(Map<String, dynamic> json) =>
      _$$ParsedInstructionUnsupportedFromJson(json);

  @override
  final String? program;

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
    required TResult Function(String? program) unsupported,
  }) {
    return unsupported(program);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String programId, ParsedSystemInstruction parsed)? system,
    TResult Function(ParsedSplTokenInstruction parsed)? splToken,
    TResult Function(@JsonKey(name: 'parsed') String? memo)? memo,
    TResult Function(String? program)? unsupported,
  }) {
    return unsupported?.call(program);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String programId, ParsedSystemInstruction parsed)? system,
    TResult Function(ParsedSplTokenInstruction parsed)? splToken,
    TResult Function(@JsonKey(name: 'parsed') String? memo)? memo,
    TResult Function(String? program)? unsupported,
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ParsedInstructionSystem value)? system,
    TResult Function(ParsedInstructionSplToken value)? splToken,
    TResult Function(ParsedInstructionMemo value)? memo,
    TResult Function(ParsedInstructionUnsupported value)? unsupported,
  }) {
    return unsupported?.call(this);
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
    return _$$ParsedInstructionUnsupportedToJson(this)
      ..['program'] = 'unsupported';
  }
}

abstract class ParsedInstructionUnsupported implements ParsedInstruction {
  const factory ParsedInstructionUnsupported({String? program}) =
      _$ParsedInstructionUnsupported;

  factory ParsedInstructionUnsupported.fromJson(Map<String, dynamic> json) =
      _$ParsedInstructionUnsupported.fromJson;

  String? get program => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ParsedInstructionUnsupportedCopyWith<ParsedInstructionUnsupported>
      get copyWith => throw _privateConstructorUsedError;
}
