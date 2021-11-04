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
  switch (json['type'] as String?) {
    case 'transfer':
      return ParsedSplTokenTransferInstruction.fromJson(json);
    case 'transferChecked':
      return ParsedSplTokenTransferCheckedInstruction.fromJson(json);

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

  ParsedSplTokenTransferCheckedInstruction transferChecked(
      {required ParsedSplTokenTransferCheckedInformation info,
      required String type}) {
    return ParsedSplTokenTransferCheckedInstruction(
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
    required TResult Function(
            ParsedSplTokenTransferCheckedInformation info, String type)
        transferChecked,
    required TResult Function(String type) unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ParsedSplTokenTransferInformation info, String type)?
        transfer,
    TResult Function(
            ParsedSplTokenTransferCheckedInformation info, String type)?
        transferChecked,
    TResult Function(String type)? unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParsedSplTokenTransferInformation info, String type)?
        transfer,
    TResult Function(
            ParsedSplTokenTransferCheckedInformation info, String type)?
        transferChecked,
    TResult Function(String type)? unsupported,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ParsedSplTokenTransferInstruction value) transfer,
    required TResult Function(ParsedSplTokenTransferCheckedInstruction value)
        transferChecked,
    required TResult Function(ParsedSplTokenUnsupportedInstruction value)
        unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ParsedSplTokenTransferInstruction value)? transfer,
    TResult Function(ParsedSplTokenTransferCheckedInstruction value)?
        transferChecked,
    TResult Function(ParsedSplTokenUnsupportedInstruction value)? unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParsedSplTokenTransferInstruction value)? transfer,
    TResult Function(ParsedSplTokenTransferCheckedInstruction value)?
        transferChecked,
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
      _$$ParsedSplTokenTransferInstructionFromJson(json);

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
    required TResult Function(
            ParsedSplTokenTransferCheckedInformation info, String type)
        transferChecked,
    required TResult Function(String type) unsupported,
  }) {
    return transfer(info, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ParsedSplTokenTransferInformation info, String type)?
        transfer,
    TResult Function(
            ParsedSplTokenTransferCheckedInformation info, String type)?
        transferChecked,
    TResult Function(String type)? unsupported,
  }) {
    return transfer?.call(info, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParsedSplTokenTransferInformation info, String type)?
        transfer,
    TResult Function(
            ParsedSplTokenTransferCheckedInformation info, String type)?
        transferChecked,
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
    required TResult Function(ParsedSplTokenTransferCheckedInstruction value)
        transferChecked,
    required TResult Function(ParsedSplTokenUnsupportedInstruction value)
        unsupported,
  }) {
    return transfer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ParsedSplTokenTransferInstruction value)? transfer,
    TResult Function(ParsedSplTokenTransferCheckedInstruction value)?
        transferChecked,
    TResult Function(ParsedSplTokenUnsupportedInstruction value)? unsupported,
  }) {
    return transfer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParsedSplTokenTransferInstruction value)? transfer,
    TResult Function(ParsedSplTokenTransferCheckedInstruction value)?
        transferChecked,
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
    return _$$ParsedSplTokenTransferInstructionToJson(this)
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
abstract class $ParsedSplTokenTransferCheckedInstructionCopyWith<$Res>
    implements $ParsedSplTokenInstructionCopyWith<$Res> {
  factory $ParsedSplTokenTransferCheckedInstructionCopyWith(
          ParsedSplTokenTransferCheckedInstruction value,
          $Res Function(ParsedSplTokenTransferCheckedInstruction) then) =
      _$ParsedSplTokenTransferCheckedInstructionCopyWithImpl<$Res>;
  @override
  $Res call({ParsedSplTokenTransferCheckedInformation info, String type});

  $ParsedSplTokenTransferCheckedInformationCopyWith<$Res> get info;
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
              as ParsedSplTokenTransferCheckedInformation,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $ParsedSplTokenTransferCheckedInformationCopyWith<$Res> get info {
    return $ParsedSplTokenTransferCheckedInformationCopyWith<$Res>(_value.info,
        (value) {
      return _then(_value.copyWith(info: value));
    });
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
  final ParsedSplTokenTransferCheckedInformation info;
  @override
  final String type;

  @override
  String toString() {
    return 'ParsedSplTokenInstruction.transferChecked(info: $info, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ParsedSplTokenTransferCheckedInstruction &&
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
  $ParsedSplTokenTransferCheckedInstructionCopyWith<
          ParsedSplTokenTransferCheckedInstruction>
      get copyWith => _$ParsedSplTokenTransferCheckedInstructionCopyWithImpl<
          ParsedSplTokenTransferCheckedInstruction>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            ParsedSplTokenTransferInformation info, String type)
        transfer,
    required TResult Function(
            ParsedSplTokenTransferCheckedInformation info, String type)
        transferChecked,
    required TResult Function(String type) unsupported,
  }) {
    return transferChecked(info, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ParsedSplTokenTransferInformation info, String type)?
        transfer,
    TResult Function(
            ParsedSplTokenTransferCheckedInformation info, String type)?
        transferChecked,
    TResult Function(String type)? unsupported,
  }) {
    return transferChecked?.call(info, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParsedSplTokenTransferInformation info, String type)?
        transfer,
    TResult Function(
            ParsedSplTokenTransferCheckedInformation info, String type)?
        transferChecked,
    TResult Function(String type)? unsupported,
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
    required TResult Function(ParsedSplTokenUnsupportedInstruction value)
        unsupported,
  }) {
    return transferChecked(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ParsedSplTokenTransferInstruction value)? transfer,
    TResult Function(ParsedSplTokenTransferCheckedInstruction value)?
        transferChecked,
    TResult Function(ParsedSplTokenUnsupportedInstruction value)? unsupported,
  }) {
    return transferChecked?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParsedSplTokenTransferInstruction value)? transfer,
    TResult Function(ParsedSplTokenTransferCheckedInstruction value)?
        transferChecked,
    TResult Function(ParsedSplTokenUnsupportedInstruction value)? unsupported,
    required TResult orElse(),
  }) {
    if (transferChecked != null) {
      return transferChecked(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ParsedSplTokenTransferCheckedInstructionToJson(this)
      ..['type'] = 'transferChecked';
  }
}

abstract class ParsedSplTokenTransferCheckedInstruction
    implements ParsedSplTokenInstruction {
  const factory ParsedSplTokenTransferCheckedInstruction(
      {required ParsedSplTokenTransferCheckedInformation info,
      required String type}) = _$ParsedSplTokenTransferCheckedInstruction;

  factory ParsedSplTokenTransferCheckedInstruction.fromJson(
          Map<String, dynamic> json) =
      _$ParsedSplTokenTransferCheckedInstruction.fromJson;

  ParsedSplTokenTransferCheckedInformation get info =>
      throw _privateConstructorUsedError;
  @override
  String get type => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $ParsedSplTokenTransferCheckedInstructionCopyWith<
          ParsedSplTokenTransferCheckedInstruction>
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
      _$$ParsedSplTokenUnsupportedInstructionFromJson(json);

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
    required TResult Function(
            ParsedSplTokenTransferCheckedInformation info, String type)
        transferChecked,
    required TResult Function(String type) unsupported,
  }) {
    return unsupported(type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ParsedSplTokenTransferInformation info, String type)?
        transfer,
    TResult Function(
            ParsedSplTokenTransferCheckedInformation info, String type)?
        transferChecked,
    TResult Function(String type)? unsupported,
  }) {
    return unsupported?.call(type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParsedSplTokenTransferInformation info, String type)?
        transfer,
    TResult Function(
            ParsedSplTokenTransferCheckedInformation info, String type)?
        transferChecked,
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
    required TResult Function(ParsedSplTokenTransferCheckedInstruction value)
        transferChecked,
    required TResult Function(ParsedSplTokenUnsupportedInstruction value)
        unsupported,
  }) {
    return unsupported(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ParsedSplTokenTransferInstruction value)? transfer,
    TResult Function(ParsedSplTokenTransferCheckedInstruction value)?
        transferChecked,
    TResult Function(ParsedSplTokenUnsupportedInstruction value)? unsupported,
  }) {
    return unsupported?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParsedSplTokenTransferInstruction value)? transfer,
    TResult Function(ParsedSplTokenTransferCheckedInstruction value)?
        transferChecked,
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
    return _$$ParsedSplTokenUnsupportedInstructionToJson(this)
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
      required String? mint,
      required String source,
      required String destination}) {
    return _ParsedSplTokenTransferInformation(
      amount: amount,
      authority: authority,
      mint: mint,
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
  String? get mint => throw _privateConstructorUsedError;
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
      {String amount,
      String authority,
      String? mint,
      String source,
      String destination});
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
    Object? mint = freezed,
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
      mint: mint == freezed
          ? _value.mint
          : mint // ignore: cast_nullable_to_non_nullable
              as String?,
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
      {String amount,
      String authority,
      String? mint,
      String source,
      String destination});
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
    Object? mint = freezed,
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
      mint: mint == freezed
          ? _value.mint
          : mint // ignore: cast_nullable_to_non_nullable
              as String?,
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
      required this.mint,
      required this.source,
      required this.destination});

  factory _$_ParsedSplTokenTransferInformation.fromJson(
          Map<String, dynamic> json) =>
      _$$_ParsedSplTokenTransferInformationFromJson(json);

  @override
  final String amount;
  @override
  final String authority;
  @override
  final String? mint;
  @override
  final String source;
  @override
  final String destination;

  @override
  String toString() {
    return 'ParsedSplTokenTransferInformation(amount: $amount, authority: $authority, mint: $mint, source: $source, destination: $destination)';
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
            (identical(other.mint, mint) ||
                const DeepCollectionEquality().equals(other.mint, mint)) &&
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
      const DeepCollectionEquality().hash(mint) ^
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
    return _$$_ParsedSplTokenTransferInformationToJson(this);
  }
}

abstract class _ParsedSplTokenTransferInformation
    implements ParsedSplTokenTransferInformation {
  const factory _ParsedSplTokenTransferInformation(
      {required String amount,
      required String authority,
      required String? mint,
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
  String? get mint => throw _privateConstructorUsedError;
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

ParsedSplTokenTransferCheckedInformation
    _$ParsedSplTokenTransferCheckedInformationFromJson(
        Map<String, dynamic> json) {
  return _ParsedSplTokenTransferCheckedInformation.fromJson(json);
}

/// @nodoc
class _$ParsedSplTokenTransferCheckedInformationTearOff {
  const _$ParsedSplTokenTransferCheckedInformationTearOff();

  _ParsedSplTokenTransferCheckedInformation call(
      {required TokenAmount tokenAmount,
      required String authority,
      required String? mint,
      required String source,
      required String destination}) {
    return _ParsedSplTokenTransferCheckedInformation(
      tokenAmount: tokenAmount,
      authority: authority,
      mint: mint,
      source: source,
      destination: destination,
    );
  }

  ParsedSplTokenTransferCheckedInformation fromJson(Map<String, Object> json) {
    return ParsedSplTokenTransferCheckedInformation.fromJson(json);
  }
}

/// @nodoc
const $ParsedSplTokenTransferCheckedInformation =
    _$ParsedSplTokenTransferCheckedInformationTearOff();

/// @nodoc
mixin _$ParsedSplTokenTransferCheckedInformation {
  TokenAmount get tokenAmount => throw _privateConstructorUsedError;
  String get authority => throw _privateConstructorUsedError;
  String? get mint => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  String get destination => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ParsedSplTokenTransferCheckedInformationCopyWith<
          ParsedSplTokenTransferCheckedInformation>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParsedSplTokenTransferCheckedInformationCopyWith<$Res> {
  factory $ParsedSplTokenTransferCheckedInformationCopyWith(
          ParsedSplTokenTransferCheckedInformation value,
          $Res Function(ParsedSplTokenTransferCheckedInformation) then) =
      _$ParsedSplTokenTransferCheckedInformationCopyWithImpl<$Res>;
  $Res call(
      {TokenAmount tokenAmount,
      String authority,
      String? mint,
      String source,
      String destination});
}

/// @nodoc
class _$ParsedSplTokenTransferCheckedInformationCopyWithImpl<$Res>
    implements $ParsedSplTokenTransferCheckedInformationCopyWith<$Res> {
  _$ParsedSplTokenTransferCheckedInformationCopyWithImpl(
      this._value, this._then);

  final ParsedSplTokenTransferCheckedInformation _value;
  // ignore: unused_field
  final $Res Function(ParsedSplTokenTransferCheckedInformation) _then;

  @override
  $Res call({
    Object? tokenAmount = freezed,
    Object? authority = freezed,
    Object? mint = freezed,
    Object? source = freezed,
    Object? destination = freezed,
  }) {
    return _then(_value.copyWith(
      tokenAmount: tokenAmount == freezed
          ? _value.tokenAmount
          : tokenAmount // ignore: cast_nullable_to_non_nullable
              as TokenAmount,
      authority: authority == freezed
          ? _value.authority
          : authority // ignore: cast_nullable_to_non_nullable
              as String,
      mint: mint == freezed
          ? _value.mint
          : mint // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$ParsedSplTokenTransferCheckedInformationCopyWith<$Res>
    implements $ParsedSplTokenTransferCheckedInformationCopyWith<$Res> {
  factory _$ParsedSplTokenTransferCheckedInformationCopyWith(
          _ParsedSplTokenTransferCheckedInformation value,
          $Res Function(_ParsedSplTokenTransferCheckedInformation) then) =
      __$ParsedSplTokenTransferCheckedInformationCopyWithImpl<$Res>;
  @override
  $Res call(
      {TokenAmount tokenAmount,
      String authority,
      String? mint,
      String source,
      String destination});
}

/// @nodoc
class __$ParsedSplTokenTransferCheckedInformationCopyWithImpl<$Res>
    extends _$ParsedSplTokenTransferCheckedInformationCopyWithImpl<$Res>
    implements _$ParsedSplTokenTransferCheckedInformationCopyWith<$Res> {
  __$ParsedSplTokenTransferCheckedInformationCopyWithImpl(
      _ParsedSplTokenTransferCheckedInformation _value,
      $Res Function(_ParsedSplTokenTransferCheckedInformation) _then)
      : super(_value,
            (v) => _then(v as _ParsedSplTokenTransferCheckedInformation));

  @override
  _ParsedSplTokenTransferCheckedInformation get _value =>
      super._value as _ParsedSplTokenTransferCheckedInformation;

  @override
  $Res call({
    Object? tokenAmount = freezed,
    Object? authority = freezed,
    Object? mint = freezed,
    Object? source = freezed,
    Object? destination = freezed,
  }) {
    return _then(_ParsedSplTokenTransferCheckedInformation(
      tokenAmount: tokenAmount == freezed
          ? _value.tokenAmount
          : tokenAmount // ignore: cast_nullable_to_non_nullable
              as TokenAmount,
      authority: authority == freezed
          ? _value.authority
          : authority // ignore: cast_nullable_to_non_nullable
              as String,
      mint: mint == freezed
          ? _value.mint
          : mint // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$_ParsedSplTokenTransferCheckedInformation
    implements _ParsedSplTokenTransferCheckedInformation {
  const _$_ParsedSplTokenTransferCheckedInformation(
      {required this.tokenAmount,
      required this.authority,
      required this.mint,
      required this.source,
      required this.destination});

  factory _$_ParsedSplTokenTransferCheckedInformation.fromJson(
          Map<String, dynamic> json) =>
      _$$_ParsedSplTokenTransferCheckedInformationFromJson(json);

  @override
  final TokenAmount tokenAmount;
  @override
  final String authority;
  @override
  final String? mint;
  @override
  final String source;
  @override
  final String destination;

  @override
  String toString() {
    return 'ParsedSplTokenTransferCheckedInformation(tokenAmount: $tokenAmount, authority: $authority, mint: $mint, source: $source, destination: $destination)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ParsedSplTokenTransferCheckedInformation &&
            (identical(other.tokenAmount, tokenAmount) ||
                const DeepCollectionEquality()
                    .equals(other.tokenAmount, tokenAmount)) &&
            (identical(other.authority, authority) ||
                const DeepCollectionEquality()
                    .equals(other.authority, authority)) &&
            (identical(other.mint, mint) ||
                const DeepCollectionEquality().equals(other.mint, mint)) &&
            (identical(other.source, source) ||
                const DeepCollectionEquality().equals(other.source, source)) &&
            (identical(other.destination, destination) ||
                const DeepCollectionEquality()
                    .equals(other.destination, destination)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(tokenAmount) ^
      const DeepCollectionEquality().hash(authority) ^
      const DeepCollectionEquality().hash(mint) ^
      const DeepCollectionEquality().hash(source) ^
      const DeepCollectionEquality().hash(destination);

  @JsonKey(ignore: true)
  @override
  _$ParsedSplTokenTransferCheckedInformationCopyWith<
          _ParsedSplTokenTransferCheckedInformation>
      get copyWith => __$ParsedSplTokenTransferCheckedInformationCopyWithImpl<
          _ParsedSplTokenTransferCheckedInformation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ParsedSplTokenTransferCheckedInformationToJson(this);
  }
}

abstract class _ParsedSplTokenTransferCheckedInformation
    implements ParsedSplTokenTransferCheckedInformation {
  const factory _ParsedSplTokenTransferCheckedInformation(
          {required TokenAmount tokenAmount,
          required String authority,
          required String? mint,
          required String source,
          required String destination}) =
      _$_ParsedSplTokenTransferCheckedInformation;

  factory _ParsedSplTokenTransferCheckedInformation.fromJson(
          Map<String, dynamic> json) =
      _$_ParsedSplTokenTransferCheckedInformation.fromJson;

  @override
  TokenAmount get tokenAmount => throw _privateConstructorUsedError;
  @override
  String get authority => throw _privateConstructorUsedError;
  @override
  String? get mint => throw _privateConstructorUsedError;
  @override
  String get source => throw _privateConstructorUsedError;
  @override
  String get destination => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ParsedSplTokenTransferCheckedInformationCopyWith<
          _ParsedSplTokenTransferCheckedInformation>
      get copyWith => throw _privateConstructorUsedError;
}
