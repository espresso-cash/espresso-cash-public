// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'parsed_spl_token_instruction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
