// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parsed_system_instruction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ParsedSystemInstruction _$ParsedSystemInstructionFromJson(
    Map<String, dynamic> json) {
  switch (json['type']) {
    case 'transfer':
      return ParsedSystemTransferInstruction.fromJson(json);
    case 'transferChecked':
      return ParsedSystemTransferCheckedInstruction.fromJson(json);

    default:
      return ParsedSystemUnsupportedInstruction.fromJson(json);
  }
}

/// @nodoc
mixin _$ParsedSystemInstruction {
  String get type => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ParsedSystemTransferInformation info, String type)
        transfer,
    required TResult Function(ParsedSystemTransferInformation info, String type)
        transferChecked,
    required TResult Function(String type) unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ParsedSystemTransferInformation info, String type)?
        transfer,
    TResult? Function(ParsedSystemTransferInformation info, String type)?
        transferChecked,
    TResult? Function(String type)? unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParsedSystemTransferInformation info, String type)?
        transfer,
    TResult Function(ParsedSystemTransferInformation info, String type)?
        transferChecked,
    TResult Function(String type)? unsupported,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ParsedSystemTransferInstruction value) transfer,
    required TResult Function(ParsedSystemTransferCheckedInstruction value)
        transferChecked,
    required TResult Function(ParsedSystemUnsupportedInstruction value)
        unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ParsedSystemTransferInstruction value)? transfer,
    TResult? Function(ParsedSystemTransferCheckedInstruction value)?
        transferChecked,
    TResult? Function(ParsedSystemUnsupportedInstruction value)? unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParsedSystemTransferInstruction value)? transfer,
    TResult Function(ParsedSystemTransferCheckedInstruction value)?
        transferChecked,
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
      _$ParsedSystemInstructionCopyWithImpl<$Res, ParsedSystemInstruction>;
  @useResult
  $Res call({String type});
}

/// @nodoc
class _$ParsedSystemInstructionCopyWithImpl<$Res,
        $Val extends ParsedSystemInstruction>
    implements $ParsedSystemInstructionCopyWith<$Res> {
  _$ParsedSystemInstructionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ParsedSystemTransferInstructionCopyWith<$Res>
    implements $ParsedSystemInstructionCopyWith<$Res> {
  factory _$$ParsedSystemTransferInstructionCopyWith(
          _$ParsedSystemTransferInstruction value,
          $Res Function(_$ParsedSystemTransferInstruction) then) =
      __$$ParsedSystemTransferInstructionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ParsedSystemTransferInformation info, String type});

  $ParsedSystemTransferInformationCopyWith<$Res> get info;
}

/// @nodoc
class __$$ParsedSystemTransferInstructionCopyWithImpl<$Res>
    extends _$ParsedSystemInstructionCopyWithImpl<$Res,
        _$ParsedSystemTransferInstruction>
    implements _$$ParsedSystemTransferInstructionCopyWith<$Res> {
  __$$ParsedSystemTransferInstructionCopyWithImpl(
      _$ParsedSystemTransferInstruction _value,
      $Res Function(_$ParsedSystemTransferInstruction) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
    Object? type = null,
  }) {
    return _then(_$ParsedSystemTransferInstruction(
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as ParsedSystemTransferInformation,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
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
      _$$ParsedSystemTransferInstructionFromJson(json);

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
        (other.runtimeType == runtimeType &&
            other is _$ParsedSystemTransferInstruction &&
            (identical(other.info, info) || other.info == info) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, info, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ParsedSystemTransferInstructionCopyWith<_$ParsedSystemTransferInstruction>
      get copyWith => __$$ParsedSystemTransferInstructionCopyWithImpl<
          _$ParsedSystemTransferInstruction>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ParsedSystemTransferInformation info, String type)
        transfer,
    required TResult Function(ParsedSystemTransferInformation info, String type)
        transferChecked,
    required TResult Function(String type) unsupported,
  }) {
    return transfer(info, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ParsedSystemTransferInformation info, String type)?
        transfer,
    TResult? Function(ParsedSystemTransferInformation info, String type)?
        transferChecked,
    TResult? Function(String type)? unsupported,
  }) {
    return transfer?.call(info, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParsedSystemTransferInformation info, String type)?
        transfer,
    TResult Function(ParsedSystemTransferInformation info, String type)?
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
    required TResult Function(ParsedSystemTransferInstruction value) transfer,
    required TResult Function(ParsedSystemTransferCheckedInstruction value)
        transferChecked,
    required TResult Function(ParsedSystemUnsupportedInstruction value)
        unsupported,
  }) {
    return transfer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ParsedSystemTransferInstruction value)? transfer,
    TResult? Function(ParsedSystemTransferCheckedInstruction value)?
        transferChecked,
    TResult? Function(ParsedSystemUnsupportedInstruction value)? unsupported,
  }) {
    return transfer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParsedSystemTransferInstruction value)? transfer,
    TResult Function(ParsedSystemTransferCheckedInstruction value)?
        transferChecked,
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
    return _$$ParsedSystemTransferInstructionToJson(
      this,
    );
  }
}

abstract class ParsedSystemTransferInstruction
    implements ParsedSystemInstruction {
  const factory ParsedSystemTransferInstruction(
      {required final ParsedSystemTransferInformation info,
      required final String type}) = _$ParsedSystemTransferInstruction;

  factory ParsedSystemTransferInstruction.fromJson(Map<String, dynamic> json) =
      _$ParsedSystemTransferInstruction.fromJson;

  ParsedSystemTransferInformation get info;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$ParsedSystemTransferInstructionCopyWith<_$ParsedSystemTransferInstruction>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ParsedSystemTransferCheckedInstructionCopyWith<$Res>
    implements $ParsedSystemInstructionCopyWith<$Res> {
  factory _$$ParsedSystemTransferCheckedInstructionCopyWith(
          _$ParsedSystemTransferCheckedInstruction value,
          $Res Function(_$ParsedSystemTransferCheckedInstruction) then) =
      __$$ParsedSystemTransferCheckedInstructionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ParsedSystemTransferInformation info, String type});

  $ParsedSystemTransferInformationCopyWith<$Res> get info;
}

/// @nodoc
class __$$ParsedSystemTransferCheckedInstructionCopyWithImpl<$Res>
    extends _$ParsedSystemInstructionCopyWithImpl<$Res,
        _$ParsedSystemTransferCheckedInstruction>
    implements _$$ParsedSystemTransferCheckedInstructionCopyWith<$Res> {
  __$$ParsedSystemTransferCheckedInstructionCopyWithImpl(
      _$ParsedSystemTransferCheckedInstruction _value,
      $Res Function(_$ParsedSystemTransferCheckedInstruction) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
    Object? type = null,
  }) {
    return _then(_$ParsedSystemTransferCheckedInstruction(
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as ParsedSystemTransferInformation,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ParsedSystemTransferInformationCopyWith<$Res> get info {
    return $ParsedSystemTransferInformationCopyWith<$Res>(_value.info, (value) {
      return _then(_value.copyWith(info: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ParsedSystemTransferCheckedInstruction
    implements ParsedSystemTransferCheckedInstruction {
  const _$ParsedSystemTransferCheckedInstruction(
      {required this.info, required this.type});

  factory _$ParsedSystemTransferCheckedInstruction.fromJson(
          Map<String, dynamic> json) =>
      _$$ParsedSystemTransferCheckedInstructionFromJson(json);

  @override
  final ParsedSystemTransferInformation info;
  @override
  final String type;

  @override
  String toString() {
    return 'ParsedSystemInstruction.transferChecked(info: $info, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParsedSystemTransferCheckedInstruction &&
            (identical(other.info, info) || other.info == info) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, info, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ParsedSystemTransferCheckedInstructionCopyWith<
          _$ParsedSystemTransferCheckedInstruction>
      get copyWith => __$$ParsedSystemTransferCheckedInstructionCopyWithImpl<
          _$ParsedSystemTransferCheckedInstruction>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ParsedSystemTransferInformation info, String type)
        transfer,
    required TResult Function(ParsedSystemTransferInformation info, String type)
        transferChecked,
    required TResult Function(String type) unsupported,
  }) {
    return transferChecked(info, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ParsedSystemTransferInformation info, String type)?
        transfer,
    TResult? Function(ParsedSystemTransferInformation info, String type)?
        transferChecked,
    TResult? Function(String type)? unsupported,
  }) {
    return transferChecked?.call(info, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParsedSystemTransferInformation info, String type)?
        transfer,
    TResult Function(ParsedSystemTransferInformation info, String type)?
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
    required TResult Function(ParsedSystemTransferInstruction value) transfer,
    required TResult Function(ParsedSystemTransferCheckedInstruction value)
        transferChecked,
    required TResult Function(ParsedSystemUnsupportedInstruction value)
        unsupported,
  }) {
    return transferChecked(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ParsedSystemTransferInstruction value)? transfer,
    TResult? Function(ParsedSystemTransferCheckedInstruction value)?
        transferChecked,
    TResult? Function(ParsedSystemUnsupportedInstruction value)? unsupported,
  }) {
    return transferChecked?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParsedSystemTransferInstruction value)? transfer,
    TResult Function(ParsedSystemTransferCheckedInstruction value)?
        transferChecked,
    TResult Function(ParsedSystemUnsupportedInstruction value)? unsupported,
    required TResult orElse(),
  }) {
    if (transferChecked != null) {
      return transferChecked(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ParsedSystemTransferCheckedInstructionToJson(
      this,
    );
  }
}

abstract class ParsedSystemTransferCheckedInstruction
    implements ParsedSystemInstruction {
  const factory ParsedSystemTransferCheckedInstruction(
      {required final ParsedSystemTransferInformation info,
      required final String type}) = _$ParsedSystemTransferCheckedInstruction;

  factory ParsedSystemTransferCheckedInstruction.fromJson(
          Map<String, dynamic> json) =
      _$ParsedSystemTransferCheckedInstruction.fromJson;

  ParsedSystemTransferInformation get info;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$ParsedSystemTransferCheckedInstructionCopyWith<
          _$ParsedSystemTransferCheckedInstruction>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ParsedSystemUnsupportedInstructionCopyWith<$Res>
    implements $ParsedSystemInstructionCopyWith<$Res> {
  factory _$$ParsedSystemUnsupportedInstructionCopyWith(
          _$ParsedSystemUnsupportedInstruction value,
          $Res Function(_$ParsedSystemUnsupportedInstruction) then) =
      __$$ParsedSystemUnsupportedInstructionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type});
}

/// @nodoc
class __$$ParsedSystemUnsupportedInstructionCopyWithImpl<$Res>
    extends _$ParsedSystemInstructionCopyWithImpl<$Res,
        _$ParsedSystemUnsupportedInstruction>
    implements _$$ParsedSystemUnsupportedInstructionCopyWith<$Res> {
  __$$ParsedSystemUnsupportedInstructionCopyWithImpl(
      _$ParsedSystemUnsupportedInstruction _value,
      $Res Function(_$ParsedSystemUnsupportedInstruction) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
  }) {
    return _then(_$ParsedSystemUnsupportedInstruction(
      type: null == type
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
      _$$ParsedSystemUnsupportedInstructionFromJson(json);

  @override
  final String type;

  @override
  String toString() {
    return 'ParsedSystemInstruction.unsupported(type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParsedSystemUnsupportedInstruction &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ParsedSystemUnsupportedInstructionCopyWith<
          _$ParsedSystemUnsupportedInstruction>
      get copyWith => __$$ParsedSystemUnsupportedInstructionCopyWithImpl<
          _$ParsedSystemUnsupportedInstruction>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ParsedSystemTransferInformation info, String type)
        transfer,
    required TResult Function(ParsedSystemTransferInformation info, String type)
        transferChecked,
    required TResult Function(String type) unsupported,
  }) {
    return unsupported(type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ParsedSystemTransferInformation info, String type)?
        transfer,
    TResult? Function(ParsedSystemTransferInformation info, String type)?
        transferChecked,
    TResult? Function(String type)? unsupported,
  }) {
    return unsupported?.call(type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParsedSystemTransferInformation info, String type)?
        transfer,
    TResult Function(ParsedSystemTransferInformation info, String type)?
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
    required TResult Function(ParsedSystemTransferInstruction value) transfer,
    required TResult Function(ParsedSystemTransferCheckedInstruction value)
        transferChecked,
    required TResult Function(ParsedSystemUnsupportedInstruction value)
        unsupported,
  }) {
    return unsupported(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ParsedSystemTransferInstruction value)? transfer,
    TResult? Function(ParsedSystemTransferCheckedInstruction value)?
        transferChecked,
    TResult? Function(ParsedSystemUnsupportedInstruction value)? unsupported,
  }) {
    return unsupported?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParsedSystemTransferInstruction value)? transfer,
    TResult Function(ParsedSystemTransferCheckedInstruction value)?
        transferChecked,
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
    return _$$ParsedSystemUnsupportedInstructionToJson(
      this,
    );
  }
}

abstract class ParsedSystemUnsupportedInstruction
    implements ParsedSystemInstruction {
  const factory ParsedSystemUnsupportedInstruction(
      {required final String type}) = _$ParsedSystemUnsupportedInstruction;

  factory ParsedSystemUnsupportedInstruction.fromJson(
          Map<String, dynamic> json) =
      _$ParsedSystemUnsupportedInstruction.fromJson;

  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$ParsedSystemUnsupportedInstructionCopyWith<
          _$ParsedSystemUnsupportedInstruction>
      get copyWith => throw _privateConstructorUsedError;
}

ParsedSystemTransferInformation _$ParsedSystemTransferInformationFromJson(
    Map<String, dynamic> json) {
  return _ParsedSystemTransferInformation.fromJson(json);
}

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
      _$ParsedSystemTransferInformationCopyWithImpl<$Res,
          ParsedSystemTransferInformation>;
  @useResult
  $Res call({int lamports, String source, String destination});
}

/// @nodoc
class _$ParsedSystemTransferInformationCopyWithImpl<$Res,
        $Val extends ParsedSystemTransferInformation>
    implements $ParsedSystemTransferInformationCopyWith<$Res> {
  _$ParsedSystemTransferInformationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lamports = null,
    Object? source = null,
    Object? destination = null,
  }) {
    return _then(_value.copyWith(
      lamports: null == lamports
          ? _value.lamports
          : lamports // ignore: cast_nullable_to_non_nullable
              as int,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ParsedSystemTransferInformationCopyWith<$Res>
    implements $ParsedSystemTransferInformationCopyWith<$Res> {
  factory _$$_ParsedSystemTransferInformationCopyWith(
          _$_ParsedSystemTransferInformation value,
          $Res Function(_$_ParsedSystemTransferInformation) then) =
      __$$_ParsedSystemTransferInformationCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int lamports, String source, String destination});
}

/// @nodoc
class __$$_ParsedSystemTransferInformationCopyWithImpl<$Res>
    extends _$ParsedSystemTransferInformationCopyWithImpl<$Res,
        _$_ParsedSystemTransferInformation>
    implements _$$_ParsedSystemTransferInformationCopyWith<$Res> {
  __$$_ParsedSystemTransferInformationCopyWithImpl(
      _$_ParsedSystemTransferInformation _value,
      $Res Function(_$_ParsedSystemTransferInformation) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lamports = null,
    Object? source = null,
    Object? destination = null,
  }) {
    return _then(_$_ParsedSystemTransferInformation(
      lamports: null == lamports
          ? _value.lamports
          : lamports // ignore: cast_nullable_to_non_nullable
              as int,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      destination: null == destination
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
      _$$_ParsedSystemTransferInformationFromJson(json);

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
        (other.runtimeType == runtimeType &&
            other is _$_ParsedSystemTransferInformation &&
            (identical(other.lamports, lamports) ||
                other.lamports == lamports) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.destination, destination) ||
                other.destination == destination));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, lamports, source, destination);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ParsedSystemTransferInformationCopyWith<
          _$_ParsedSystemTransferInformation>
      get copyWith => __$$_ParsedSystemTransferInformationCopyWithImpl<
          _$_ParsedSystemTransferInformation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ParsedSystemTransferInformationToJson(
      this,
    );
  }
}

abstract class _ParsedSystemTransferInformation
    implements ParsedSystemTransferInformation {
  const factory _ParsedSystemTransferInformation(
      {required final int lamports,
      required final String source,
      required final String destination}) = _$_ParsedSystemTransferInformation;

  factory _ParsedSystemTransferInformation.fromJson(Map<String, dynamic> json) =
      _$_ParsedSystemTransferInformation.fromJson;

  @override
  int get lamports;
  @override
  String get source;
  @override
  String get destination;
  @override
  @JsonKey(ignore: true)
  _$$_ParsedSystemTransferInformationCopyWith<
          _$_ParsedSystemTransferInformation>
      get copyWith => throw _privateConstructorUsedError;
}
