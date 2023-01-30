// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parsed_spl_token_instruction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
mixin _$ParsedSplTokenInstruction {
  dynamic get info => throw _privateConstructorUsedError;
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
    TResult? Function(SplTokenTransferInfo info, String type)? transfer,
    TResult? Function(SplTokenTransferCheckedInfo info, String type)?
        transferChecked,
    TResult? Function(dynamic info, String type)? generic,
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
    TResult? Function(ParsedSplTokenTransferInstruction value)? transfer,
    TResult? Function(ParsedSplTokenTransferCheckedInstruction value)?
        transferChecked,
    TResult? Function(ParsedSplTokenGenericInstruction value)? generic,
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
      _$ParsedSplTokenInstructionCopyWithImpl<$Res, ParsedSplTokenInstruction>;
  @useResult
  $Res call({String type});
}

/// @nodoc
class _$ParsedSplTokenInstructionCopyWithImpl<$Res,
        $Val extends ParsedSplTokenInstruction>
    implements $ParsedSplTokenInstructionCopyWith<$Res> {
  _$ParsedSplTokenInstructionCopyWithImpl(this._value, this._then);

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
abstract class _$$ParsedSplTokenTransferInstructionCopyWith<$Res>
    implements $ParsedSplTokenInstructionCopyWith<$Res> {
  factory _$$ParsedSplTokenTransferInstructionCopyWith(
          _$ParsedSplTokenTransferInstruction value,
          $Res Function(_$ParsedSplTokenTransferInstruction) then) =
      __$$ParsedSplTokenTransferInstructionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SplTokenTransferInfo info, String type});
}

/// @nodoc
class __$$ParsedSplTokenTransferInstructionCopyWithImpl<$Res>
    extends _$ParsedSplTokenInstructionCopyWithImpl<$Res,
        _$ParsedSplTokenTransferInstruction>
    implements _$$ParsedSplTokenTransferInstructionCopyWith<$Res> {
  __$$ParsedSplTokenTransferInstructionCopyWithImpl(
      _$ParsedSplTokenTransferInstruction _value,
      $Res Function(_$ParsedSplTokenTransferInstruction) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
    Object? type = null,
  }) {
    return _then(_$ParsedSplTokenTransferInstruction(
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as SplTokenTransferInfo,
      type: null == type
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
            other is _$ParsedSplTokenTransferInstruction &&
            (identical(other.info, info) || other.info == info) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, info, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ParsedSplTokenTransferInstructionCopyWith<
          _$ParsedSplTokenTransferInstruction>
      get copyWith => __$$ParsedSplTokenTransferInstructionCopyWithImpl<
          _$ParsedSplTokenTransferInstruction>(this, _$identity);

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
    TResult? Function(SplTokenTransferInfo info, String type)? transfer,
    TResult? Function(SplTokenTransferCheckedInfo info, String type)?
        transferChecked,
    TResult? Function(dynamic info, String type)? generic,
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
    TResult? Function(ParsedSplTokenTransferInstruction value)? transfer,
    TResult? Function(ParsedSplTokenTransferCheckedInstruction value)?
        transferChecked,
    TResult? Function(ParsedSplTokenGenericInstruction value)? generic,
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
    return _$$ParsedSplTokenTransferInstructionToJson(
      this,
    );
  }
}

abstract class ParsedSplTokenTransferInstruction
    implements ParsedSplTokenInstruction {
  const factory ParsedSplTokenTransferInstruction(
      {required final SplTokenTransferInfo info,
      required final String type}) = _$ParsedSplTokenTransferInstruction;

  factory ParsedSplTokenTransferInstruction.fromJson(
      Map<String, dynamic> json) = _$ParsedSplTokenTransferInstruction.fromJson;

  @override
  SplTokenTransferInfo get info;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$ParsedSplTokenTransferInstructionCopyWith<
          _$ParsedSplTokenTransferInstruction>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ParsedSplTokenTransferCheckedInstructionCopyWith<$Res>
    implements $ParsedSplTokenInstructionCopyWith<$Res> {
  factory _$$ParsedSplTokenTransferCheckedInstructionCopyWith(
          _$ParsedSplTokenTransferCheckedInstruction value,
          $Res Function(_$ParsedSplTokenTransferCheckedInstruction) then) =
      __$$ParsedSplTokenTransferCheckedInstructionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SplTokenTransferCheckedInfo info, String type});
}

/// @nodoc
class __$$ParsedSplTokenTransferCheckedInstructionCopyWithImpl<$Res>
    extends _$ParsedSplTokenInstructionCopyWithImpl<$Res,
        _$ParsedSplTokenTransferCheckedInstruction>
    implements _$$ParsedSplTokenTransferCheckedInstructionCopyWith<$Res> {
  __$$ParsedSplTokenTransferCheckedInstructionCopyWithImpl(
      _$ParsedSplTokenTransferCheckedInstruction _value,
      $Res Function(_$ParsedSplTokenTransferCheckedInstruction) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
    Object? type = null,
  }) {
    return _then(_$ParsedSplTokenTransferCheckedInstruction(
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as SplTokenTransferCheckedInfo,
      type: null == type
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
            other is _$ParsedSplTokenTransferCheckedInstruction &&
            (identical(other.info, info) || other.info == info) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, info, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ParsedSplTokenTransferCheckedInstructionCopyWith<
          _$ParsedSplTokenTransferCheckedInstruction>
      get copyWith => __$$ParsedSplTokenTransferCheckedInstructionCopyWithImpl<
          _$ParsedSplTokenTransferCheckedInstruction>(this, _$identity);

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
    TResult? Function(SplTokenTransferInfo info, String type)? transfer,
    TResult? Function(SplTokenTransferCheckedInfo info, String type)?
        transferChecked,
    TResult? Function(dynamic info, String type)? generic,
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
    TResult? Function(ParsedSplTokenTransferInstruction value)? transfer,
    TResult? Function(ParsedSplTokenTransferCheckedInstruction value)?
        transferChecked,
    TResult? Function(ParsedSplTokenGenericInstruction value)? generic,
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
    return _$$ParsedSplTokenTransferCheckedInstructionToJson(
      this,
    );
  }
}

abstract class ParsedSplTokenTransferCheckedInstruction
    implements ParsedSplTokenInstruction {
  const factory ParsedSplTokenTransferCheckedInstruction(
      {required final SplTokenTransferCheckedInfo info,
      required final String type}) = _$ParsedSplTokenTransferCheckedInstruction;

  factory ParsedSplTokenTransferCheckedInstruction.fromJson(
          Map<String, dynamic> json) =
      _$ParsedSplTokenTransferCheckedInstruction.fromJson;

  @override
  SplTokenTransferCheckedInfo get info;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$ParsedSplTokenTransferCheckedInstructionCopyWith<
          _$ParsedSplTokenTransferCheckedInstruction>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ParsedSplTokenGenericInstructionCopyWith<$Res>
    implements $ParsedSplTokenInstructionCopyWith<$Res> {
  factory _$$ParsedSplTokenGenericInstructionCopyWith(
          _$ParsedSplTokenGenericInstruction value,
          $Res Function(_$ParsedSplTokenGenericInstruction) then) =
      __$$ParsedSplTokenGenericInstructionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({dynamic info, String type});
}

/// @nodoc
class __$$ParsedSplTokenGenericInstructionCopyWithImpl<$Res>
    extends _$ParsedSplTokenInstructionCopyWithImpl<$Res,
        _$ParsedSplTokenGenericInstruction>
    implements _$$ParsedSplTokenGenericInstructionCopyWith<$Res> {
  __$$ParsedSplTokenGenericInstructionCopyWithImpl(
      _$ParsedSplTokenGenericInstruction _value,
      $Res Function(_$ParsedSplTokenGenericInstruction) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = freezed,
    Object? type = null,
  }) {
    return _then(_$ParsedSplTokenGenericInstruction(
      info: freezed == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as dynamic,
      type: null == type
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
            other is _$ParsedSplTokenGenericInstruction &&
            const DeepCollectionEquality().equals(other.info, info) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(info), type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ParsedSplTokenGenericInstructionCopyWith<
          _$ParsedSplTokenGenericInstruction>
      get copyWith => __$$ParsedSplTokenGenericInstructionCopyWithImpl<
          _$ParsedSplTokenGenericInstruction>(this, _$identity);

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
    TResult? Function(SplTokenTransferInfo info, String type)? transfer,
    TResult? Function(SplTokenTransferCheckedInfo info, String type)?
        transferChecked,
    TResult? Function(dynamic info, String type)? generic,
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
    TResult? Function(ParsedSplTokenTransferInstruction value)? transfer,
    TResult? Function(ParsedSplTokenTransferCheckedInstruction value)?
        transferChecked,
    TResult? Function(ParsedSplTokenGenericInstruction value)? generic,
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
    return _$$ParsedSplTokenGenericInstructionToJson(
      this,
    );
  }
}

abstract class ParsedSplTokenGenericInstruction
    implements ParsedSplTokenInstruction {
  const factory ParsedSplTokenGenericInstruction(
      {required final dynamic info,
      required final String type}) = _$ParsedSplTokenGenericInstruction;

  factory ParsedSplTokenGenericInstruction.fromJson(Map<String, dynamic> json) =
      _$ParsedSplTokenGenericInstruction.fromJson;

  @override
  dynamic get info;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$ParsedSplTokenGenericInstructionCopyWith<
          _$ParsedSplTokenGenericInstruction>
      get copyWith => throw _privateConstructorUsedError;
}
