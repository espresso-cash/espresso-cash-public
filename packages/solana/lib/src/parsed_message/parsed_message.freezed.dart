// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'parsed_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ParsedMessage _$ParsedMessageFromJson(Map<String, dynamic> json) {
  return _ParsedMessage.fromJson(json);
}

/// @nodoc
class _$ParsedMessageTearOff {
  const _$ParsedMessageTearOff();

  _ParsedMessage call(
      {required List<AccountKey> accountKeys,
      required ParsedMessageHeader? header,
      required String recentBlockhash,
      required List<ParsedInstruction> instructions}) {
    return _ParsedMessage(
      accountKeys: accountKeys,
      header: header,
      recentBlockhash: recentBlockhash,
      instructions: instructions,
    );
  }

  ParsedMessage fromJson(Map<String, Object> json) {
    return ParsedMessage.fromJson(json);
  }
}

/// @nodoc
const $ParsedMessage = _$ParsedMessageTearOff();

/// @nodoc
mixin _$ParsedMessage {
  List<AccountKey> get accountKeys => throw _privateConstructorUsedError;
  ParsedMessageHeader? get header => throw _privateConstructorUsedError;
  String get recentBlockhash => throw _privateConstructorUsedError;
  List<ParsedInstruction> get instructions =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ParsedMessageCopyWith<ParsedMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParsedMessageCopyWith<$Res> {
  factory $ParsedMessageCopyWith(
          ParsedMessage value, $Res Function(ParsedMessage) then) =
      _$ParsedMessageCopyWithImpl<$Res>;
  $Res call(
      {List<AccountKey> accountKeys,
      ParsedMessageHeader? header,
      String recentBlockhash,
      List<ParsedInstruction> instructions});

  $ParsedMessageHeaderCopyWith<$Res>? get header;
}

/// @nodoc
class _$ParsedMessageCopyWithImpl<$Res>
    implements $ParsedMessageCopyWith<$Res> {
  _$ParsedMessageCopyWithImpl(this._value, this._then);

  final ParsedMessage _value;
  // ignore: unused_field
  final $Res Function(ParsedMessage) _then;

  @override
  $Res call({
    Object? accountKeys = freezed,
    Object? header = freezed,
    Object? recentBlockhash = freezed,
    Object? instructions = freezed,
  }) {
    return _then(_value.copyWith(
      accountKeys: accountKeys == freezed
          ? _value.accountKeys
          : accountKeys // ignore: cast_nullable_to_non_nullable
              as List<AccountKey>,
      header: header == freezed
          ? _value.header
          : header // ignore: cast_nullable_to_non_nullable
              as ParsedMessageHeader?,
      recentBlockhash: recentBlockhash == freezed
          ? _value.recentBlockhash
          : recentBlockhash // ignore: cast_nullable_to_non_nullable
              as String,
      instructions: instructions == freezed
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as List<ParsedInstruction>,
    ));
  }

  @override
  $ParsedMessageHeaderCopyWith<$Res>? get header {
    if (_value.header == null) {
      return null;
    }

    return $ParsedMessageHeaderCopyWith<$Res>(_value.header!, (value) {
      return _then(_value.copyWith(header: value));
    });
  }
}

/// @nodoc
abstract class _$ParsedMessageCopyWith<$Res>
    implements $ParsedMessageCopyWith<$Res> {
  factory _$ParsedMessageCopyWith(
          _ParsedMessage value, $Res Function(_ParsedMessage) then) =
      __$ParsedMessageCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<AccountKey> accountKeys,
      ParsedMessageHeader? header,
      String recentBlockhash,
      List<ParsedInstruction> instructions});

  @override
  $ParsedMessageHeaderCopyWith<$Res>? get header;
}

/// @nodoc
class __$ParsedMessageCopyWithImpl<$Res>
    extends _$ParsedMessageCopyWithImpl<$Res>
    implements _$ParsedMessageCopyWith<$Res> {
  __$ParsedMessageCopyWithImpl(
      _ParsedMessage _value, $Res Function(_ParsedMessage) _then)
      : super(_value, (v) => _then(v as _ParsedMessage));

  @override
  _ParsedMessage get _value => super._value as _ParsedMessage;

  @override
  $Res call({
    Object? accountKeys = freezed,
    Object? header = freezed,
    Object? recentBlockhash = freezed,
    Object? instructions = freezed,
  }) {
    return _then(_ParsedMessage(
      accountKeys: accountKeys == freezed
          ? _value.accountKeys
          : accountKeys // ignore: cast_nullable_to_non_nullable
              as List<AccountKey>,
      header: header == freezed
          ? _value.header
          : header // ignore: cast_nullable_to_non_nullable
              as ParsedMessageHeader?,
      recentBlockhash: recentBlockhash == freezed
          ? _value.recentBlockhash
          : recentBlockhash // ignore: cast_nullable_to_non_nullable
              as String,
      instructions: instructions == freezed
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as List<ParsedInstruction>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ParsedMessage implements _ParsedMessage {
  const _$_ParsedMessage(
      {required this.accountKeys,
      required this.header,
      required this.recentBlockhash,
      required this.instructions});

  factory _$_ParsedMessage.fromJson(Map<String, dynamic> json) =>
      _$$_ParsedMessageFromJson(json);

  @override
  final List<AccountKey> accountKeys;
  @override
  final ParsedMessageHeader? header;
  @override
  final String recentBlockhash;
  @override
  final List<ParsedInstruction> instructions;

  @override
  String toString() {
    return 'ParsedMessage(accountKeys: $accountKeys, header: $header, recentBlockhash: $recentBlockhash, instructions: $instructions)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ParsedMessage &&
            (identical(other.accountKeys, accountKeys) ||
                const DeepCollectionEquality()
                    .equals(other.accountKeys, accountKeys)) &&
            (identical(other.header, header) ||
                const DeepCollectionEquality().equals(other.header, header)) &&
            (identical(other.recentBlockhash, recentBlockhash) ||
                const DeepCollectionEquality()
                    .equals(other.recentBlockhash, recentBlockhash)) &&
            (identical(other.instructions, instructions) ||
                const DeepCollectionEquality()
                    .equals(other.instructions, instructions)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(accountKeys) ^
      const DeepCollectionEquality().hash(header) ^
      const DeepCollectionEquality().hash(recentBlockhash) ^
      const DeepCollectionEquality().hash(instructions);

  @JsonKey(ignore: true)
  @override
  _$ParsedMessageCopyWith<_ParsedMessage> get copyWith =>
      __$ParsedMessageCopyWithImpl<_ParsedMessage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ParsedMessageToJson(this);
  }
}

abstract class _ParsedMessage implements ParsedMessage {
  const factory _ParsedMessage(
      {required List<AccountKey> accountKeys,
      required ParsedMessageHeader? header,
      required String recentBlockhash,
      required List<ParsedInstruction> instructions}) = _$_ParsedMessage;

  factory _ParsedMessage.fromJson(Map<String, dynamic> json) =
      _$_ParsedMessage.fromJson;

  @override
  List<AccountKey> get accountKeys => throw _privateConstructorUsedError;
  @override
  ParsedMessageHeader? get header => throw _privateConstructorUsedError;
  @override
  String get recentBlockhash => throw _privateConstructorUsedError;
  @override
  List<ParsedInstruction> get instructions =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ParsedMessageCopyWith<_ParsedMessage> get copyWith =>
      throw _privateConstructorUsedError;
}
