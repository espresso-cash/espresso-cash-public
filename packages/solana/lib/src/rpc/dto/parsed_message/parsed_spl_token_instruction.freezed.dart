// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parsed_spl_token_instruction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
ParsedSplTokenInstruction _$ParsedSplTokenInstructionFromJson(Map<String, dynamic> json) {
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
  dynamic get info;
  String get type;

  /// Create a copy of ParsedSplTokenInstruction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ParsedSplTokenInstructionCopyWith<ParsedSplTokenInstruction> get copyWith =>
      _$ParsedSplTokenInstructionCopyWithImpl<ParsedSplTokenInstruction>(
        this as ParsedSplTokenInstruction,
        _$identity,
      );

  /// Serializes this ParsedSplTokenInstruction to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ParsedSplTokenInstruction &&
            const DeepCollectionEquality().equals(other.info, info) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(info), type);

  @override
  String toString() {
    return 'ParsedSplTokenInstruction(info: $info, type: $type)';
  }
}

/// @nodoc
abstract mixin class $ParsedSplTokenInstructionCopyWith<$Res> {
  factory $ParsedSplTokenInstructionCopyWith(
    ParsedSplTokenInstruction value,
    $Res Function(ParsedSplTokenInstruction) _then,
  ) = _$ParsedSplTokenInstructionCopyWithImpl;
  @useResult
  $Res call({String type});
}

/// @nodoc
class _$ParsedSplTokenInstructionCopyWithImpl<$Res>
    implements $ParsedSplTokenInstructionCopyWith<$Res> {
  _$ParsedSplTokenInstructionCopyWithImpl(this._self, this._then);

  final ParsedSplTokenInstruction _self;
  final $Res Function(ParsedSplTokenInstruction) _then;

  /// Create a copy of ParsedSplTokenInstruction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? type = null}) {
    return _then(
      _self.copyWith(
        type:
            null == type
                ? _self.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class ParsedSplTokenTransferInstruction implements ParsedSplTokenInstruction {
  const ParsedSplTokenTransferInstruction({required this.info, required this.type});
  factory ParsedSplTokenTransferInstruction.fromJson(Map<String, dynamic> json) =>
      _$ParsedSplTokenTransferInstructionFromJson(json);

  @override
  final SplTokenTransferInfo info;
  @override
  final String type;

  /// Create a copy of ParsedSplTokenInstruction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ParsedSplTokenTransferInstructionCopyWith<ParsedSplTokenTransferInstruction> get copyWith =>
      _$ParsedSplTokenTransferInstructionCopyWithImpl<ParsedSplTokenTransferInstruction>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$ParsedSplTokenTransferInstructionToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ParsedSplTokenTransferInstruction &&
            (identical(other.info, info) || other.info == info) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, info, type);

  @override
  String toString() {
    return 'ParsedSplTokenInstruction.transfer(info: $info, type: $type)';
  }
}

/// @nodoc
abstract mixin class $ParsedSplTokenTransferInstructionCopyWith<$Res>
    implements $ParsedSplTokenInstructionCopyWith<$Res> {
  factory $ParsedSplTokenTransferInstructionCopyWith(
    ParsedSplTokenTransferInstruction value,
    $Res Function(ParsedSplTokenTransferInstruction) _then,
  ) = _$ParsedSplTokenTransferInstructionCopyWithImpl;
  @override
  @useResult
  $Res call({SplTokenTransferInfo info, String type});
}

/// @nodoc
class _$ParsedSplTokenTransferInstructionCopyWithImpl<$Res>
    implements $ParsedSplTokenTransferInstructionCopyWith<$Res> {
  _$ParsedSplTokenTransferInstructionCopyWithImpl(this._self, this._then);

  final ParsedSplTokenTransferInstruction _self;
  final $Res Function(ParsedSplTokenTransferInstruction) _then;

  /// Create a copy of ParsedSplTokenInstruction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? info = null, Object? type = null}) {
    return _then(
      ParsedSplTokenTransferInstruction(
        info:
            null == info
                ? _self.info
                : info // ignore: cast_nullable_to_non_nullable
                    as SplTokenTransferInfo,
        type:
            null == type
                ? _self.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class ParsedSplTokenTransferCheckedInstruction implements ParsedSplTokenInstruction {
  const ParsedSplTokenTransferCheckedInstruction({required this.info, required this.type});
  factory ParsedSplTokenTransferCheckedInstruction.fromJson(Map<String, dynamic> json) =>
      _$ParsedSplTokenTransferCheckedInstructionFromJson(json);

  @override
  final SplTokenTransferCheckedInfo info;
  @override
  final String type;

  /// Create a copy of ParsedSplTokenInstruction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ParsedSplTokenTransferCheckedInstructionCopyWith<ParsedSplTokenTransferCheckedInstruction>
  get copyWith => _$ParsedSplTokenTransferCheckedInstructionCopyWithImpl<
    ParsedSplTokenTransferCheckedInstruction
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ParsedSplTokenTransferCheckedInstructionToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ParsedSplTokenTransferCheckedInstruction &&
            (identical(other.info, info) || other.info == info) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, info, type);

  @override
  String toString() {
    return 'ParsedSplTokenInstruction.transferChecked(info: $info, type: $type)';
  }
}

/// @nodoc
abstract mixin class $ParsedSplTokenTransferCheckedInstructionCopyWith<$Res>
    implements $ParsedSplTokenInstructionCopyWith<$Res> {
  factory $ParsedSplTokenTransferCheckedInstructionCopyWith(
    ParsedSplTokenTransferCheckedInstruction value,
    $Res Function(ParsedSplTokenTransferCheckedInstruction) _then,
  ) = _$ParsedSplTokenTransferCheckedInstructionCopyWithImpl;
  @override
  @useResult
  $Res call({SplTokenTransferCheckedInfo info, String type});
}

/// @nodoc
class _$ParsedSplTokenTransferCheckedInstructionCopyWithImpl<$Res>
    implements $ParsedSplTokenTransferCheckedInstructionCopyWith<$Res> {
  _$ParsedSplTokenTransferCheckedInstructionCopyWithImpl(this._self, this._then);

  final ParsedSplTokenTransferCheckedInstruction _self;
  final $Res Function(ParsedSplTokenTransferCheckedInstruction) _then;

  /// Create a copy of ParsedSplTokenInstruction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? info = null, Object? type = null}) {
    return _then(
      ParsedSplTokenTransferCheckedInstruction(
        info:
            null == info
                ? _self.info
                : info // ignore: cast_nullable_to_non_nullable
                    as SplTokenTransferCheckedInfo,
        type:
            null == type
                ? _self.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class ParsedSplTokenGenericInstruction implements ParsedSplTokenInstruction {
  const ParsedSplTokenGenericInstruction({required this.info, required this.type});
  factory ParsedSplTokenGenericInstruction.fromJson(Map<String, dynamic> json) =>
      _$ParsedSplTokenGenericInstructionFromJson(json);

  @override
  final dynamic info;
  @override
  final String type;

  /// Create a copy of ParsedSplTokenInstruction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ParsedSplTokenGenericInstructionCopyWith<ParsedSplTokenGenericInstruction> get copyWith =>
      _$ParsedSplTokenGenericInstructionCopyWithImpl<ParsedSplTokenGenericInstruction>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$ParsedSplTokenGenericInstructionToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ParsedSplTokenGenericInstruction &&
            const DeepCollectionEquality().equals(other.info, info) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(info), type);

  @override
  String toString() {
    return 'ParsedSplTokenInstruction.generic(info: $info, type: $type)';
  }
}

/// @nodoc
abstract mixin class $ParsedSplTokenGenericInstructionCopyWith<$Res>
    implements $ParsedSplTokenInstructionCopyWith<$Res> {
  factory $ParsedSplTokenGenericInstructionCopyWith(
    ParsedSplTokenGenericInstruction value,
    $Res Function(ParsedSplTokenGenericInstruction) _then,
  ) = _$ParsedSplTokenGenericInstructionCopyWithImpl;
  @override
  @useResult
  $Res call({dynamic info, String type});
}

/// @nodoc
class _$ParsedSplTokenGenericInstructionCopyWithImpl<$Res>
    implements $ParsedSplTokenGenericInstructionCopyWith<$Res> {
  _$ParsedSplTokenGenericInstructionCopyWithImpl(this._self, this._then);

  final ParsedSplTokenGenericInstruction _self;
  final $Res Function(ParsedSplTokenGenericInstruction) _then;

  /// Create a copy of ParsedSplTokenInstruction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? info = freezed, Object? type = null}) {
    return _then(
      ParsedSplTokenGenericInstruction(
        info:
            freezed == info
                ? _self.info
                : info // ignore: cast_nullable_to_non_nullable
                    as dynamic,
        type:
            null == type
                ? _self.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}
