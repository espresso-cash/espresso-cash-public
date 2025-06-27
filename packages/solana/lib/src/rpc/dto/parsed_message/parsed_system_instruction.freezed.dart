// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parsed_system_instruction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
ParsedSystemInstruction _$ParsedSystemInstructionFromJson(Map<String, dynamic> json) {
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
  String get type;

  /// Create a copy of ParsedSystemInstruction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ParsedSystemInstructionCopyWith<ParsedSystemInstruction> get copyWith =>
      _$ParsedSystemInstructionCopyWithImpl<ParsedSystemInstruction>(
        this as ParsedSystemInstruction,
        _$identity,
      );

  /// Serializes this ParsedSystemInstruction to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ParsedSystemInstruction &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type);

  @override
  String toString() {
    return 'ParsedSystemInstruction(type: $type)';
  }
}

/// @nodoc
abstract mixin class $ParsedSystemInstructionCopyWith<$Res> {
  factory $ParsedSystemInstructionCopyWith(
    ParsedSystemInstruction value,
    $Res Function(ParsedSystemInstruction) _then,
  ) = _$ParsedSystemInstructionCopyWithImpl;
  @useResult
  $Res call({String type});
}

/// @nodoc
class _$ParsedSystemInstructionCopyWithImpl<$Res>
    implements $ParsedSystemInstructionCopyWith<$Res> {
  _$ParsedSystemInstructionCopyWithImpl(this._self, this._then);

  final ParsedSystemInstruction _self;
  final $Res Function(ParsedSystemInstruction) _then;

  /// Create a copy of ParsedSystemInstruction
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
class ParsedSystemTransferInstruction implements ParsedSystemInstruction {
  const ParsedSystemTransferInstruction({required this.info, required this.type});
  factory ParsedSystemTransferInstruction.fromJson(Map<String, dynamic> json) =>
      _$ParsedSystemTransferInstructionFromJson(json);

  final ParsedSystemTransferInformation info;
  @override
  final String type;

  /// Create a copy of ParsedSystemInstruction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ParsedSystemTransferInstructionCopyWith<ParsedSystemTransferInstruction> get copyWith =>
      _$ParsedSystemTransferInstructionCopyWithImpl<ParsedSystemTransferInstruction>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$ParsedSystemTransferInstructionToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ParsedSystemTransferInstruction &&
            (identical(other.info, info) || other.info == info) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, info, type);

  @override
  String toString() {
    return 'ParsedSystemInstruction.transfer(info: $info, type: $type)';
  }
}

/// @nodoc
abstract mixin class $ParsedSystemTransferInstructionCopyWith<$Res>
    implements $ParsedSystemInstructionCopyWith<$Res> {
  factory $ParsedSystemTransferInstructionCopyWith(
    ParsedSystemTransferInstruction value,
    $Res Function(ParsedSystemTransferInstruction) _then,
  ) = _$ParsedSystemTransferInstructionCopyWithImpl;
  @override
  @useResult
  $Res call({ParsedSystemTransferInformation info, String type});

  $ParsedSystemTransferInformationCopyWith<$Res> get info;
}

/// @nodoc
class _$ParsedSystemTransferInstructionCopyWithImpl<$Res>
    implements $ParsedSystemTransferInstructionCopyWith<$Res> {
  _$ParsedSystemTransferInstructionCopyWithImpl(this._self, this._then);

  final ParsedSystemTransferInstruction _self;
  final $Res Function(ParsedSystemTransferInstruction) _then;

  /// Create a copy of ParsedSystemInstruction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? info = null, Object? type = null}) {
    return _then(
      ParsedSystemTransferInstruction(
        info:
            null == info
                ? _self.info
                : info // ignore: cast_nullable_to_non_nullable
                    as ParsedSystemTransferInformation,
        type:
            null == type
                ? _self.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }

  /// Create a copy of ParsedSystemInstruction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ParsedSystemTransferInformationCopyWith<$Res> get info {
    return $ParsedSystemTransferInformationCopyWith<$Res>(_self.info, (value) {
      return _then(_self.copyWith(info: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class ParsedSystemTransferCheckedInstruction implements ParsedSystemInstruction {
  const ParsedSystemTransferCheckedInstruction({required this.info, required this.type});
  factory ParsedSystemTransferCheckedInstruction.fromJson(Map<String, dynamic> json) =>
      _$ParsedSystemTransferCheckedInstructionFromJson(json);

  final ParsedSystemTransferInformation info;
  @override
  final String type;

  /// Create a copy of ParsedSystemInstruction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ParsedSystemTransferCheckedInstructionCopyWith<ParsedSystemTransferCheckedInstruction>
  get copyWith =>
      _$ParsedSystemTransferCheckedInstructionCopyWithImpl<ParsedSystemTransferCheckedInstruction>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$ParsedSystemTransferCheckedInstructionToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ParsedSystemTransferCheckedInstruction &&
            (identical(other.info, info) || other.info == info) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, info, type);

  @override
  String toString() {
    return 'ParsedSystemInstruction.transferChecked(info: $info, type: $type)';
  }
}

/// @nodoc
abstract mixin class $ParsedSystemTransferCheckedInstructionCopyWith<$Res>
    implements $ParsedSystemInstructionCopyWith<$Res> {
  factory $ParsedSystemTransferCheckedInstructionCopyWith(
    ParsedSystemTransferCheckedInstruction value,
    $Res Function(ParsedSystemTransferCheckedInstruction) _then,
  ) = _$ParsedSystemTransferCheckedInstructionCopyWithImpl;
  @override
  @useResult
  $Res call({ParsedSystemTransferInformation info, String type});

  $ParsedSystemTransferInformationCopyWith<$Res> get info;
}

/// @nodoc
class _$ParsedSystemTransferCheckedInstructionCopyWithImpl<$Res>
    implements $ParsedSystemTransferCheckedInstructionCopyWith<$Res> {
  _$ParsedSystemTransferCheckedInstructionCopyWithImpl(this._self, this._then);

  final ParsedSystemTransferCheckedInstruction _self;
  final $Res Function(ParsedSystemTransferCheckedInstruction) _then;

  /// Create a copy of ParsedSystemInstruction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? info = null, Object? type = null}) {
    return _then(
      ParsedSystemTransferCheckedInstruction(
        info:
            null == info
                ? _self.info
                : info // ignore: cast_nullable_to_non_nullable
                    as ParsedSystemTransferInformation,
        type:
            null == type
                ? _self.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }

  /// Create a copy of ParsedSystemInstruction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ParsedSystemTransferInformationCopyWith<$Res> get info {
    return $ParsedSystemTransferInformationCopyWith<$Res>(_self.info, (value) {
      return _then(_self.copyWith(info: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class ParsedSystemUnsupportedInstruction implements ParsedSystemInstruction {
  const ParsedSystemUnsupportedInstruction({required this.type});
  factory ParsedSystemUnsupportedInstruction.fromJson(Map<String, dynamic> json) =>
      _$ParsedSystemUnsupportedInstructionFromJson(json);

  @override
  final String type;

  /// Create a copy of ParsedSystemInstruction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ParsedSystemUnsupportedInstructionCopyWith<ParsedSystemUnsupportedInstruction> get copyWith =>
      _$ParsedSystemUnsupportedInstructionCopyWithImpl<ParsedSystemUnsupportedInstruction>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$ParsedSystemUnsupportedInstructionToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ParsedSystemUnsupportedInstruction &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type);

  @override
  String toString() {
    return 'ParsedSystemInstruction.unsupported(type: $type)';
  }
}

/// @nodoc
abstract mixin class $ParsedSystemUnsupportedInstructionCopyWith<$Res>
    implements $ParsedSystemInstructionCopyWith<$Res> {
  factory $ParsedSystemUnsupportedInstructionCopyWith(
    ParsedSystemUnsupportedInstruction value,
    $Res Function(ParsedSystemUnsupportedInstruction) _then,
  ) = _$ParsedSystemUnsupportedInstructionCopyWithImpl;
  @override
  @useResult
  $Res call({String type});
}

/// @nodoc
class _$ParsedSystemUnsupportedInstructionCopyWithImpl<$Res>
    implements $ParsedSystemUnsupportedInstructionCopyWith<$Res> {
  _$ParsedSystemUnsupportedInstructionCopyWithImpl(this._self, this._then);

  final ParsedSystemUnsupportedInstruction _self;
  final $Res Function(ParsedSystemUnsupportedInstruction) _then;

  /// Create a copy of ParsedSystemInstruction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? type = null}) {
    return _then(
      ParsedSystemUnsupportedInstruction(
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
mixin _$ParsedSystemTransferInformation {
  int get lamports;
  String get source;
  String get destination;

  /// Create a copy of ParsedSystemTransferInformation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ParsedSystemTransferInformationCopyWith<ParsedSystemTransferInformation> get copyWith =>
      _$ParsedSystemTransferInformationCopyWithImpl<ParsedSystemTransferInformation>(
        this as ParsedSystemTransferInformation,
        _$identity,
      );

  /// Serializes this ParsedSystemTransferInformation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ParsedSystemTransferInformation &&
            (identical(other.lamports, lamports) || other.lamports == lamports) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.destination, destination) || other.destination == destination));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lamports, source, destination);

  @override
  String toString() {
    return 'ParsedSystemTransferInformation(lamports: $lamports, source: $source, destination: $destination)';
  }
}

/// @nodoc
abstract mixin class $ParsedSystemTransferInformationCopyWith<$Res> {
  factory $ParsedSystemTransferInformationCopyWith(
    ParsedSystemTransferInformation value,
    $Res Function(ParsedSystemTransferInformation) _then,
  ) = _$ParsedSystemTransferInformationCopyWithImpl;
  @useResult
  $Res call({int lamports, String source, String destination});
}

/// @nodoc
class _$ParsedSystemTransferInformationCopyWithImpl<$Res>
    implements $ParsedSystemTransferInformationCopyWith<$Res> {
  _$ParsedSystemTransferInformationCopyWithImpl(this._self, this._then);

  final ParsedSystemTransferInformation _self;
  final $Res Function(ParsedSystemTransferInformation) _then;

  /// Create a copy of ParsedSystemTransferInformation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? lamports = null, Object? source = null, Object? destination = null}) {
    return _then(
      _self.copyWith(
        lamports:
            null == lamports
                ? _self.lamports
                : lamports // ignore: cast_nullable_to_non_nullable
                    as int,
        source:
            null == source
                ? _self.source
                : source // ignore: cast_nullable_to_non_nullable
                    as String,
        destination:
            null == destination
                ? _self.destination
                : destination // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _ParsedSystemTransferInformation implements ParsedSystemTransferInformation {
  const _ParsedSystemTransferInformation({
    required this.lamports,
    required this.source,
    required this.destination,
  });
  factory _ParsedSystemTransferInformation.fromJson(Map<String, dynamic> json) =>
      _$ParsedSystemTransferInformationFromJson(json);

  @override
  final int lamports;
  @override
  final String source;
  @override
  final String destination;

  /// Create a copy of ParsedSystemTransferInformation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ParsedSystemTransferInformationCopyWith<_ParsedSystemTransferInformation> get copyWith =>
      __$ParsedSystemTransferInformationCopyWithImpl<_ParsedSystemTransferInformation>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$ParsedSystemTransferInformationToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ParsedSystemTransferInformation &&
            (identical(other.lamports, lamports) || other.lamports == lamports) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.destination, destination) || other.destination == destination));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lamports, source, destination);

  @override
  String toString() {
    return 'ParsedSystemTransferInformation(lamports: $lamports, source: $source, destination: $destination)';
  }
}

/// @nodoc
abstract mixin class _$ParsedSystemTransferInformationCopyWith<$Res>
    implements $ParsedSystemTransferInformationCopyWith<$Res> {
  factory _$ParsedSystemTransferInformationCopyWith(
    _ParsedSystemTransferInformation value,
    $Res Function(_ParsedSystemTransferInformation) _then,
  ) = __$ParsedSystemTransferInformationCopyWithImpl;
  @override
  @useResult
  $Res call({int lamports, String source, String destination});
}

/// @nodoc
class __$ParsedSystemTransferInformationCopyWithImpl<$Res>
    implements _$ParsedSystemTransferInformationCopyWith<$Res> {
  __$ParsedSystemTransferInformationCopyWithImpl(this._self, this._then);

  final _ParsedSystemTransferInformation _self;
  final $Res Function(_ParsedSystemTransferInformation) _then;

  /// Create a copy of ParsedSystemTransferInformation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? lamports = null, Object? source = null, Object? destination = null}) {
    return _then(
      _ParsedSystemTransferInformation(
        lamports:
            null == lamports
                ? _self.lamports
                : lamports // ignore: cast_nullable_to_non_nullable
                    as int,
        source:
            null == source
                ? _self.source
                : source // ignore: cast_nullable_to_non_nullable
                    as String,
        destination:
            null == destination
                ? _self.destination
                : destination // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}
