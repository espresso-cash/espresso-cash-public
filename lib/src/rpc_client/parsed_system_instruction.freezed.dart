// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'parsed_system_instruction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
