// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parsed_instruction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ParsedInstruction _$ParsedInstructionFromJson(Map<String, dynamic> json) {
  switch (json['program']) {
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
    TResult? Function(String programId, ParsedSystemInstruction parsed)? system,
    TResult? Function(ParsedSplTokenInstruction parsed)? splToken,
    TResult? Function(@JsonKey(name: 'parsed') String? memo)? memo,
    TResult? Function(String? program)? unsupported,
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
    TResult? Function(ParsedInstructionSystem value)? system,
    TResult? Function(ParsedInstructionSplToken value)? splToken,
    TResult? Function(ParsedInstructionMemo value)? memo,
    TResult? Function(ParsedInstructionUnsupported value)? unsupported,
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
      _$ParsedInstructionCopyWithImpl<$Res, ParsedInstruction>;
}

/// @nodoc
class _$ParsedInstructionCopyWithImpl<$Res, $Val extends ParsedInstruction>
    implements $ParsedInstructionCopyWith<$Res> {
  _$ParsedInstructionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ParsedInstructionSystemCopyWith<$Res> {
  factory _$$ParsedInstructionSystemCopyWith(_$ParsedInstructionSystem value,
          $Res Function(_$ParsedInstructionSystem) then) =
      __$$ParsedInstructionSystemCopyWithImpl<$Res>;
  @useResult
  $Res call({String programId, ParsedSystemInstruction parsed});

  $ParsedSystemInstructionCopyWith<$Res> get parsed;
}

/// @nodoc
class __$$ParsedInstructionSystemCopyWithImpl<$Res>
    extends _$ParsedInstructionCopyWithImpl<$Res, _$ParsedInstructionSystem>
    implements _$$ParsedInstructionSystemCopyWith<$Res> {
  __$$ParsedInstructionSystemCopyWithImpl(_$ParsedInstructionSystem _value,
      $Res Function(_$ParsedInstructionSystem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? programId = null,
    Object? parsed = null,
  }) {
    return _then(_$ParsedInstructionSystem(
      programId: null == programId
          ? _value.programId
          : programId // ignore: cast_nullable_to_non_nullable
              as String,
      parsed: null == parsed
          ? _value.parsed
          : parsed // ignore: cast_nullable_to_non_nullable
              as ParsedSystemInstruction,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
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
      {required this.programId, required this.parsed, final String? $type})
      : $type = $type ?? 'system';

  factory _$ParsedInstructionSystem.fromJson(Map<String, dynamic> json) =>
      _$$ParsedInstructionSystemFromJson(json);

  @override
  final String programId;
  @override
  final ParsedSystemInstruction parsed;

  @JsonKey(name: 'program')
  final String $type;

  @override
  String toString() {
    return 'ParsedInstruction.system(programId: $programId, parsed: $parsed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParsedInstructionSystem &&
            (identical(other.programId, programId) ||
                other.programId == programId) &&
            (identical(other.parsed, parsed) || other.parsed == parsed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, programId, parsed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ParsedInstructionSystemCopyWith<_$ParsedInstructionSystem> get copyWith =>
      __$$ParsedInstructionSystemCopyWithImpl<_$ParsedInstructionSystem>(
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
    TResult? Function(String programId, ParsedSystemInstruction parsed)? system,
    TResult? Function(ParsedSplTokenInstruction parsed)? splToken,
    TResult? Function(@JsonKey(name: 'parsed') String? memo)? memo,
    TResult? Function(String? program)? unsupported,
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
    TResult? Function(ParsedInstructionSystem value)? system,
    TResult? Function(ParsedInstructionSplToken value)? splToken,
    TResult? Function(ParsedInstructionMemo value)? memo,
    TResult? Function(ParsedInstructionUnsupported value)? unsupported,
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
    return _$$ParsedInstructionSystemToJson(
      this,
    );
  }
}

abstract class ParsedInstructionSystem implements ParsedInstruction {
  const factory ParsedInstructionSystem(
          {required final String programId,
          required final ParsedSystemInstruction parsed}) =
      _$ParsedInstructionSystem;

  factory ParsedInstructionSystem.fromJson(Map<String, dynamic> json) =
      _$ParsedInstructionSystem.fromJson;

  String get programId;
  ParsedSystemInstruction get parsed;
  @JsonKey(ignore: true)
  _$$ParsedInstructionSystemCopyWith<_$ParsedInstructionSystem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ParsedInstructionSplTokenCopyWith<$Res> {
  factory _$$ParsedInstructionSplTokenCopyWith(
          _$ParsedInstructionSplToken value,
          $Res Function(_$ParsedInstructionSplToken) then) =
      __$$ParsedInstructionSplTokenCopyWithImpl<$Res>;
  @useResult
  $Res call({ParsedSplTokenInstruction parsed});

  $ParsedSplTokenInstructionCopyWith<$Res> get parsed;
}

/// @nodoc
class __$$ParsedInstructionSplTokenCopyWithImpl<$Res>
    extends _$ParsedInstructionCopyWithImpl<$Res, _$ParsedInstructionSplToken>
    implements _$$ParsedInstructionSplTokenCopyWith<$Res> {
  __$$ParsedInstructionSplTokenCopyWithImpl(_$ParsedInstructionSplToken _value,
      $Res Function(_$ParsedInstructionSplToken) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? parsed = null,
  }) {
    return _then(_$ParsedInstructionSplToken(
      parsed: null == parsed
          ? _value.parsed
          : parsed // ignore: cast_nullable_to_non_nullable
              as ParsedSplTokenInstruction,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ParsedSplTokenInstructionCopyWith<$Res> get parsed {
    return $ParsedSplTokenInstructionCopyWith<$Res>(_value.parsed, (value) {
      return _then(_value.copyWith(parsed: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ParsedInstructionSplToken implements ParsedInstructionSplToken {
  const _$ParsedInstructionSplToken({required this.parsed, final String? $type})
      : $type = $type ?? 'spl-token';

  factory _$ParsedInstructionSplToken.fromJson(Map<String, dynamic> json) =>
      _$$ParsedInstructionSplTokenFromJson(json);

  @override
  final ParsedSplTokenInstruction parsed;

  @JsonKey(name: 'program')
  final String $type;

  @override
  String toString() {
    return 'ParsedInstruction.splToken(parsed: $parsed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParsedInstructionSplToken &&
            (identical(other.parsed, parsed) || other.parsed == parsed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, parsed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ParsedInstructionSplTokenCopyWith<_$ParsedInstructionSplToken>
      get copyWith => __$$ParsedInstructionSplTokenCopyWithImpl<
          _$ParsedInstructionSplToken>(this, _$identity);

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
    TResult? Function(String programId, ParsedSystemInstruction parsed)? system,
    TResult? Function(ParsedSplTokenInstruction parsed)? splToken,
    TResult? Function(@JsonKey(name: 'parsed') String? memo)? memo,
    TResult? Function(String? program)? unsupported,
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
    TResult? Function(ParsedInstructionSystem value)? system,
    TResult? Function(ParsedInstructionSplToken value)? splToken,
    TResult? Function(ParsedInstructionMemo value)? memo,
    TResult? Function(ParsedInstructionUnsupported value)? unsupported,
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
    return _$$ParsedInstructionSplTokenToJson(
      this,
    );
  }
}

abstract class ParsedInstructionSplToken implements ParsedInstruction {
  const factory ParsedInstructionSplToken(
          {required final ParsedSplTokenInstruction parsed}) =
      _$ParsedInstructionSplToken;

  factory ParsedInstructionSplToken.fromJson(Map<String, dynamic> json) =
      _$ParsedInstructionSplToken.fromJson;

  ParsedSplTokenInstruction get parsed;
  @JsonKey(ignore: true)
  _$$ParsedInstructionSplTokenCopyWith<_$ParsedInstructionSplToken>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ParsedInstructionMemoCopyWith<$Res> {
  factory _$$ParsedInstructionMemoCopyWith(_$ParsedInstructionMemo value,
          $Res Function(_$ParsedInstructionMemo) then) =
      __$$ParsedInstructionMemoCopyWithImpl<$Res>;
  @useResult
  $Res call({@JsonKey(name: 'parsed') String? memo});
}

/// @nodoc
class __$$ParsedInstructionMemoCopyWithImpl<$Res>
    extends _$ParsedInstructionCopyWithImpl<$Res, _$ParsedInstructionMemo>
    implements _$$ParsedInstructionMemoCopyWith<$Res> {
  __$$ParsedInstructionMemoCopyWithImpl(_$ParsedInstructionMemo _value,
      $Res Function(_$ParsedInstructionMemo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memo = freezed,
  }) {
    return _then(_$ParsedInstructionMemo(
      memo: freezed == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParsedInstructionMemo implements ParsedInstructionMemo {
  const _$ParsedInstructionMemo(
      {@JsonKey(name: 'parsed') required this.memo, final String? $type})
      : $type = $type ?? 'spl-memo';

  factory _$ParsedInstructionMemo.fromJson(Map<String, dynamic> json) =>
      _$$ParsedInstructionMemoFromJson(json);

// This ignore is needed until https://github.com/dart-lang/linter/issues/2778 is fixed
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'parsed')
  final String? memo;

  @JsonKey(name: 'program')
  final String $type;

  @override
  String toString() {
    return 'ParsedInstruction.memo(memo: $memo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParsedInstructionMemo &&
            (identical(other.memo, memo) || other.memo == memo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, memo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ParsedInstructionMemoCopyWith<_$ParsedInstructionMemo> get copyWith =>
      __$$ParsedInstructionMemoCopyWithImpl<_$ParsedInstructionMemo>(
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
    TResult? Function(String programId, ParsedSystemInstruction parsed)? system,
    TResult? Function(ParsedSplTokenInstruction parsed)? splToken,
    TResult? Function(@JsonKey(name: 'parsed') String? memo)? memo,
    TResult? Function(String? program)? unsupported,
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
    TResult? Function(ParsedInstructionSystem value)? system,
    TResult? Function(ParsedInstructionSplToken value)? splToken,
    TResult? Function(ParsedInstructionMemo value)? memo,
    TResult? Function(ParsedInstructionUnsupported value)? unsupported,
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
    return _$$ParsedInstructionMemoToJson(
      this,
    );
  }
}

abstract class ParsedInstructionMemo implements ParsedInstruction {
  const factory ParsedInstructionMemo(
          {@JsonKey(name: 'parsed') required final String? memo}) =
      _$ParsedInstructionMemo;

  factory ParsedInstructionMemo.fromJson(Map<String, dynamic> json) =
      _$ParsedInstructionMemo.fromJson;

// This ignore is needed until https://github.com/dart-lang/linter/issues/2778 is fixed
// ignore: invalid_annotation_target
  @JsonKey(name: 'parsed')
  String? get memo;
  @JsonKey(ignore: true)
  _$$ParsedInstructionMemoCopyWith<_$ParsedInstructionMemo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ParsedInstructionUnsupportedCopyWith<$Res> {
  factory _$$ParsedInstructionUnsupportedCopyWith(
          _$ParsedInstructionUnsupported value,
          $Res Function(_$ParsedInstructionUnsupported) then) =
      __$$ParsedInstructionUnsupportedCopyWithImpl<$Res>;
  @useResult
  $Res call({String? program});
}

/// @nodoc
class __$$ParsedInstructionUnsupportedCopyWithImpl<$Res>
    extends _$ParsedInstructionCopyWithImpl<$Res,
        _$ParsedInstructionUnsupported>
    implements _$$ParsedInstructionUnsupportedCopyWith<$Res> {
  __$$ParsedInstructionUnsupportedCopyWithImpl(
      _$ParsedInstructionUnsupported _value,
      $Res Function(_$ParsedInstructionUnsupported) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? program = freezed,
  }) {
    return _then(_$ParsedInstructionUnsupported(
      program: freezed == program
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
        (other.runtimeType == runtimeType &&
            other is _$ParsedInstructionUnsupported &&
            (identical(other.program, program) || other.program == program));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, program);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ParsedInstructionUnsupportedCopyWith<_$ParsedInstructionUnsupported>
      get copyWith => __$$ParsedInstructionUnsupportedCopyWithImpl<
          _$ParsedInstructionUnsupported>(this, _$identity);

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
    TResult? Function(String programId, ParsedSystemInstruction parsed)? system,
    TResult? Function(ParsedSplTokenInstruction parsed)? splToken,
    TResult? Function(@JsonKey(name: 'parsed') String? memo)? memo,
    TResult? Function(String? program)? unsupported,
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
    TResult? Function(ParsedInstructionSystem value)? system,
    TResult? Function(ParsedInstructionSplToken value)? splToken,
    TResult? Function(ParsedInstructionMemo value)? memo,
    TResult? Function(ParsedInstructionUnsupported value)? unsupported,
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
    return _$$ParsedInstructionUnsupportedToJson(
      this,
    );
  }
}

abstract class ParsedInstructionUnsupported implements ParsedInstruction {
  const factory ParsedInstructionUnsupported({final String? program}) =
      _$ParsedInstructionUnsupported;

  factory ParsedInstructionUnsupported.fromJson(Map<String, dynamic> json) =
      _$ParsedInstructionUnsupported.fromJson;

  String? get program;
  @JsonKey(ignore: true)
  _$$ParsedInstructionUnsupportedCopyWith<_$ParsedInstructionUnsupported>
      get copyWith => throw _privateConstructorUsedError;
}
