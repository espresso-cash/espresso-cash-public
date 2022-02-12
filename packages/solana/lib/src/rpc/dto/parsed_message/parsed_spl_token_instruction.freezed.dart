// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'parsed_spl_token_instruction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ParsedSplTokenInstruction _$ParsedSplTokenInstructionFromJson(
    Map<String, dynamic> json) {
  switch (json['type']) {
    case 'transfer':
      return ParsedSplTokenTransferInstruction.fromJson(json);
    case 'transferChecked':
      return ParsedSplTokenTransferCheckedInstruction.fromJson(json);

    default:
      return ParsedSplTokenGenericInstruction.fromJson(json);
  }
}

/// @nodoc
class _$ParsedSplTokenInstructionTearOff {
  const _$ParsedSplTokenInstructionTearOff();

  ParsedSplTokenTransferInstruction transfer(
      {required SplTokenTransferInfo info, required String type}) {
    return ParsedSplTokenTransferInstruction(
      info: info,
      type: type,
    );
  }

  ParsedSplTokenTransferCheckedInstruction transferChecked(
      {required SplTokenTransferCheckedInfo info, required String type}) {
    return ParsedSplTokenTransferCheckedInstruction(
      info: info,
      type: type,
    );
  }

  ParsedSplTokenGenericInstruction generic(
      {required dynamic info, required String type}) {
    return ParsedSplTokenGenericInstruction(
      info: info,
      type: type,
    );
  }

  ParsedSplTokenInstruction fromJson(Map<String, Object?> json) {
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
    required TResult Function(SplTokenTransferInfo info, String type) transfer,
    required TResult Function(SplTokenTransferCheckedInfo info, String type)
        transferChecked,
    required TResult Function(dynamic info, String type) generic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(SplTokenTransferInfo info, String type)? transfer,
    TResult Function(SplTokenTransferCheckedInfo info, String type)?
        transferChecked,
    TResult Function(dynamic info, String type)? generic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SplTokenTransferInfo info, String type)? transfer,
    TResult Function(SplTokenTransferCheckedInfo info, String type)?
        transferChecked,
    TResult Function(dynamic info, String type)? generic,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ParsedSplTokenTransferInstruction value) transfer,
    required TResult Function(ParsedSplTokenTransferCheckedInstruction value)
        transferChecked,
    required TResult Function(ParsedSplTokenGenericInstruction value) generic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ParsedSplTokenTransferInstruction value)? transfer,
    TResult Function(ParsedSplTokenTransferCheckedInstruction value)?
        transferChecked,
    TResult Function(ParsedSplTokenGenericInstruction value)? generic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParsedSplTokenTransferInstruction value)? transfer,
    TResult Function(ParsedSplTokenTransferCheckedInstruction value)?
        transferChecked,
    TResult Function(ParsedSplTokenGenericInstruction value)? generic,
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
  $Res call({SplTokenTransferInfo info, String type});
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
              as SplTokenTransferInfo,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
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
      _$$ParsedSplTokenTransferInstructionFromJson(json);

  @override
  final SplTokenTransferInfo info;
  @override
  final String type;

  @override
  String toString() {
    return 'ParsedSplTokenInstruction.transfer(info: $info, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ParsedSplTokenTransferInstruction &&
            const DeepCollectionEquality().equals(other.info, info) &&
            const DeepCollectionEquality().equals(other.type, type));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(info),
      const DeepCollectionEquality().hash(type));

  @JsonKey(ignore: true)
  @override
  $ParsedSplTokenTransferInstructionCopyWith<ParsedSplTokenTransferInstruction>
      get copyWith => _$ParsedSplTokenTransferInstructionCopyWithImpl<
          ParsedSplTokenTransferInstruction>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SplTokenTransferInfo info, String type) transfer,
    required TResult Function(SplTokenTransferCheckedInfo info, String type)
        transferChecked,
    required TResult Function(dynamic info, String type) generic,
  }) {
    return transfer(info, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(SplTokenTransferInfo info, String type)? transfer,
    TResult Function(SplTokenTransferCheckedInfo info, String type)?
        transferChecked,
    TResult Function(dynamic info, String type)? generic,
  }) {
    return transfer?.call(info, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SplTokenTransferInfo info, String type)? transfer,
    TResult Function(SplTokenTransferCheckedInfo info, String type)?
        transferChecked,
    TResult Function(dynamic info, String type)? generic,
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
    required TResult Function(ParsedSplTokenTransferCheckedInstruction value)
        transferChecked,
    required TResult Function(ParsedSplTokenGenericInstruction value) generic,
  }) {
    return transfer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ParsedSplTokenTransferInstruction value)? transfer,
    TResult Function(ParsedSplTokenTransferCheckedInstruction value)?
        transferChecked,
    TResult Function(ParsedSplTokenGenericInstruction value)? generic,
  }) {
    return transfer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParsedSplTokenTransferInstruction value)? transfer,
    TResult Function(ParsedSplTokenTransferCheckedInstruction value)?
        transferChecked,
    TResult Function(ParsedSplTokenGenericInstruction value)? generic,
    required TResult orElse(),
  }) {
    if (transfer != null) {
      return transfer(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ParsedSplTokenTransferInstructionToJson(this);
  }
}

abstract class ParsedSplTokenTransferInstruction
    implements ParsedSplTokenInstruction {
  const factory ParsedSplTokenTransferInstruction(
      {required SplTokenTransferInfo info,
      required String type}) = _$ParsedSplTokenTransferInstruction;

  factory ParsedSplTokenTransferInstruction.fromJson(
      Map<String, dynamic> json) = _$ParsedSplTokenTransferInstruction.fromJson;

  SplTokenTransferInfo get info;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  $ParsedSplTokenTransferInstructionCopyWith<ParsedSplTokenTransferInstruction>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParsedSplTokenTransferCheckedInstructionCopyWith<$Res>
    implements $ParsedSplTokenInstructionCopyWith<$Res> {
  factory $ParsedSplTokenTransferCheckedInstructionCopyWith(
          ParsedSplTokenTransferCheckedInstruction value,
          $Res Function(ParsedSplTokenTransferCheckedInstruction) then) =
      _$ParsedSplTokenTransferCheckedInstructionCopyWithImpl<$Res>;
  @override
  $Res call({SplTokenTransferCheckedInfo info, String type});
}

/// @nodoc
class _$ParsedSplTokenTransferCheckedInstructionCopyWithImpl<$Res>
    extends _$ParsedSplTokenInstructionCopyWithImpl<$Res>
    implements $ParsedSplTokenTransferCheckedInstructionCopyWith<$Res> {
  _$ParsedSplTokenTransferCheckedInstructionCopyWithImpl(
      ParsedSplTokenTransferCheckedInstruction _value,
      $Res Function(ParsedSplTokenTransferCheckedInstruction) _then)
      : super(_value,
            (v) => _then(v as ParsedSplTokenTransferCheckedInstruction));

  @override
  ParsedSplTokenTransferCheckedInstruction get _value =>
      super._value as ParsedSplTokenTransferCheckedInstruction;

  @override
  $Res call({
    Object? info = freezed,
    Object? type = freezed,
  }) {
    return _then(ParsedSplTokenTransferCheckedInstruction(
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as SplTokenTransferCheckedInfo,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParsedSplTokenTransferCheckedInstruction
    implements ParsedSplTokenTransferCheckedInstruction {
  const _$ParsedSplTokenTransferCheckedInstruction(
      {required this.info, required this.type});

  factory _$ParsedSplTokenTransferCheckedInstruction.fromJson(
          Map<String, dynamic> json) =>
      _$$ParsedSplTokenTransferCheckedInstructionFromJson(json);

  @override
  final SplTokenTransferCheckedInfo info;
  @override
  final String type;

  @override
  String toString() {
    return 'ParsedSplTokenInstruction.transferChecked(info: $info, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ParsedSplTokenTransferCheckedInstruction &&
            const DeepCollectionEquality().equals(other.info, info) &&
            const DeepCollectionEquality().equals(other.type, type));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(info),
      const DeepCollectionEquality().hash(type));

  @JsonKey(ignore: true)
  @override
  $ParsedSplTokenTransferCheckedInstructionCopyWith<
          ParsedSplTokenTransferCheckedInstruction>
      get copyWith => _$ParsedSplTokenTransferCheckedInstructionCopyWithImpl<
          ParsedSplTokenTransferCheckedInstruction>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SplTokenTransferInfo info, String type) transfer,
    required TResult Function(SplTokenTransferCheckedInfo info, String type)
        transferChecked,
    required TResult Function(dynamic info, String type) generic,
  }) {
    return transferChecked(info, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(SplTokenTransferInfo info, String type)? transfer,
    TResult Function(SplTokenTransferCheckedInfo info, String type)?
        transferChecked,
    TResult Function(dynamic info, String type)? generic,
  }) {
    return transferChecked?.call(info, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SplTokenTransferInfo info, String type)? transfer,
    TResult Function(SplTokenTransferCheckedInfo info, String type)?
        transferChecked,
    TResult Function(dynamic info, String type)? generic,
    required TResult orElse(),
  }) {
    if (transferChecked != null) {
      return transferChecked(info, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ParsedSplTokenTransferInstruction value) transfer,
    required TResult Function(ParsedSplTokenTransferCheckedInstruction value)
        transferChecked,
    required TResult Function(ParsedSplTokenGenericInstruction value) generic,
  }) {
    return transferChecked(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ParsedSplTokenTransferInstruction value)? transfer,
    TResult Function(ParsedSplTokenTransferCheckedInstruction value)?
        transferChecked,
    TResult Function(ParsedSplTokenGenericInstruction value)? generic,
  }) {
    return transferChecked?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParsedSplTokenTransferInstruction value)? transfer,
    TResult Function(ParsedSplTokenTransferCheckedInstruction value)?
        transferChecked,
    TResult Function(ParsedSplTokenGenericInstruction value)? generic,
    required TResult orElse(),
  }) {
    if (transferChecked != null) {
      return transferChecked(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ParsedSplTokenTransferCheckedInstructionToJson(this);
  }
}

abstract class ParsedSplTokenTransferCheckedInstruction
    implements ParsedSplTokenInstruction {
  const factory ParsedSplTokenTransferCheckedInstruction(
      {required SplTokenTransferCheckedInfo info,
      required String type}) = _$ParsedSplTokenTransferCheckedInstruction;

  factory ParsedSplTokenTransferCheckedInstruction.fromJson(
          Map<String, dynamic> json) =
      _$ParsedSplTokenTransferCheckedInstruction.fromJson;

  SplTokenTransferCheckedInfo get info;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  $ParsedSplTokenTransferCheckedInstructionCopyWith<
          ParsedSplTokenTransferCheckedInstruction>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParsedSplTokenGenericInstructionCopyWith<$Res>
    implements $ParsedSplTokenInstructionCopyWith<$Res> {
  factory $ParsedSplTokenGenericInstructionCopyWith(
          ParsedSplTokenGenericInstruction value,
          $Res Function(ParsedSplTokenGenericInstruction) then) =
      _$ParsedSplTokenGenericInstructionCopyWithImpl<$Res>;
  @override
  $Res call({dynamic info, String type});
}

/// @nodoc
class _$ParsedSplTokenGenericInstructionCopyWithImpl<$Res>
    extends _$ParsedSplTokenInstructionCopyWithImpl<$Res>
    implements $ParsedSplTokenGenericInstructionCopyWith<$Res> {
  _$ParsedSplTokenGenericInstructionCopyWithImpl(
      ParsedSplTokenGenericInstruction _value,
      $Res Function(ParsedSplTokenGenericInstruction) _then)
      : super(_value, (v) => _then(v as ParsedSplTokenGenericInstruction));

  @override
  ParsedSplTokenGenericInstruction get _value =>
      super._value as ParsedSplTokenGenericInstruction;

  @override
  $Res call({
    Object? info = freezed,
    Object? type = freezed,
  }) {
    return _then(ParsedSplTokenGenericInstruction(
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as dynamic,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParsedSplTokenGenericInstruction
    implements ParsedSplTokenGenericInstruction {
  const _$ParsedSplTokenGenericInstruction(
      {required this.info, required this.type});

  factory _$ParsedSplTokenGenericInstruction.fromJson(
          Map<String, dynamic> json) =>
      _$$ParsedSplTokenGenericInstructionFromJson(json);

  @override
  final dynamic info;
  @override
  final String type;

  @override
  String toString() {
    return 'ParsedSplTokenInstruction.generic(info: $info, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ParsedSplTokenGenericInstruction &&
            const DeepCollectionEquality().equals(other.info, info) &&
            const DeepCollectionEquality().equals(other.type, type));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(info),
      const DeepCollectionEquality().hash(type));

  @JsonKey(ignore: true)
  @override
  $ParsedSplTokenGenericInstructionCopyWith<ParsedSplTokenGenericInstruction>
      get copyWith => _$ParsedSplTokenGenericInstructionCopyWithImpl<
          ParsedSplTokenGenericInstruction>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SplTokenTransferInfo info, String type) transfer,
    required TResult Function(SplTokenTransferCheckedInfo info, String type)
        transferChecked,
    required TResult Function(dynamic info, String type) generic,
  }) {
    return generic(info, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(SplTokenTransferInfo info, String type)? transfer,
    TResult Function(SplTokenTransferCheckedInfo info, String type)?
        transferChecked,
    TResult Function(dynamic info, String type)? generic,
  }) {
    return generic?.call(info, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SplTokenTransferInfo info, String type)? transfer,
    TResult Function(SplTokenTransferCheckedInfo info, String type)?
        transferChecked,
    TResult Function(dynamic info, String type)? generic,
    required TResult orElse(),
  }) {
    if (generic != null) {
      return generic(info, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ParsedSplTokenTransferInstruction value) transfer,
    required TResult Function(ParsedSplTokenTransferCheckedInstruction value)
        transferChecked,
    required TResult Function(ParsedSplTokenGenericInstruction value) generic,
  }) {
    return generic(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ParsedSplTokenTransferInstruction value)? transfer,
    TResult Function(ParsedSplTokenTransferCheckedInstruction value)?
        transferChecked,
    TResult Function(ParsedSplTokenGenericInstruction value)? generic,
  }) {
    return generic?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParsedSplTokenTransferInstruction value)? transfer,
    TResult Function(ParsedSplTokenTransferCheckedInstruction value)?
        transferChecked,
    TResult Function(ParsedSplTokenGenericInstruction value)? generic,
    required TResult orElse(),
  }) {
    if (generic != null) {
      return generic(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ParsedSplTokenGenericInstructionToJson(this);
  }
}

abstract class ParsedSplTokenGenericInstruction
    implements ParsedSplTokenInstruction {
  const factory ParsedSplTokenGenericInstruction(
      {required dynamic info,
      required String type}) = _$ParsedSplTokenGenericInstruction;

  factory ParsedSplTokenGenericInstruction.fromJson(Map<String, dynamic> json) =
      _$ParsedSplTokenGenericInstruction.fromJson;

  dynamic get info;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  $ParsedSplTokenGenericInstructionCopyWith<ParsedSplTokenGenericInstruction>
      get copyWith => throw _privateConstructorUsedError;
}
