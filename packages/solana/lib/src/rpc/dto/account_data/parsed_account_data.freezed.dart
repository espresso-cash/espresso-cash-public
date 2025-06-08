// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parsed_account_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
ParsedAccountData _$ParsedAccountDataFromJson(Map<String, dynamic> json) {
  switch (json['program']) {
    case 'spl-token':
      return ParsedSplTokenProgramAccountData.fromJson(json);
    case 'spl-token-2022':
      return ParsedSplToken2022ProgramAccountData.fromJson(json);
    case 'stake':
      return ParsedStakeProgramAccountData.fromJson(json);

    default:
      return UnsupportedProgramAccountData.fromJson(json);
  }
}

/// @nodoc
mixin _$ParsedAccountData {
  Object get parsed;

  /// Serializes this ParsedAccountData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ParsedAccountData &&
            const DeepCollectionEquality().equals(other.parsed, parsed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(parsed));

  @override
  String toString() {
    return 'ParsedAccountData(parsed: $parsed)';
  }
}

/// @nodoc
class $ParsedAccountDataCopyWith<$Res> {
  $ParsedAccountDataCopyWith(ParsedAccountData _, $Res Function(ParsedAccountData) __);
}

/// @nodoc
@JsonSerializable()
class ParsedSplTokenProgramAccountData implements ParsedAccountData {
  const ParsedSplTokenProgramAccountData(this.parsed, {final String? $type})
    : $type = $type ?? 'spl-token';
  factory ParsedSplTokenProgramAccountData.fromJson(Map<String, dynamic> json) =>
      _$ParsedSplTokenProgramAccountDataFromJson(json);

  @override
  final SplTokenProgramAccountData parsed;

  @JsonKey(name: 'program')
  final String $type;

  /// Create a copy of ParsedAccountData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ParsedSplTokenProgramAccountDataCopyWith<ParsedSplTokenProgramAccountData> get copyWith =>
      _$ParsedSplTokenProgramAccountDataCopyWithImpl<ParsedSplTokenProgramAccountData>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$ParsedSplTokenProgramAccountDataToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ParsedSplTokenProgramAccountData &&
            (identical(other.parsed, parsed) || other.parsed == parsed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, parsed);

  @override
  String toString() {
    return 'ParsedAccountData.splToken(parsed: $parsed)';
  }
}

/// @nodoc
abstract mixin class $ParsedSplTokenProgramAccountDataCopyWith<$Res>
    implements $ParsedAccountDataCopyWith<$Res> {
  factory $ParsedSplTokenProgramAccountDataCopyWith(
    ParsedSplTokenProgramAccountData value,
    $Res Function(ParsedSplTokenProgramAccountData) _then,
  ) = _$ParsedSplTokenProgramAccountDataCopyWithImpl;
  @useResult
  $Res call({SplTokenProgramAccountData parsed});

  $SplTokenProgramAccountDataCopyWith<$Res> get parsed;
}

/// @nodoc
class _$ParsedSplTokenProgramAccountDataCopyWithImpl<$Res>
    implements $ParsedSplTokenProgramAccountDataCopyWith<$Res> {
  _$ParsedSplTokenProgramAccountDataCopyWithImpl(this._self, this._then);

  final ParsedSplTokenProgramAccountData _self;
  final $Res Function(ParsedSplTokenProgramAccountData) _then;

  /// Create a copy of ParsedAccountData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? parsed = null}) {
    return _then(
      ParsedSplTokenProgramAccountData(
        null == parsed
            ? _self.parsed
            : parsed // ignore: cast_nullable_to_non_nullable
                as SplTokenProgramAccountData,
      ),
    );
  }

  /// Create a copy of ParsedAccountData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SplTokenProgramAccountDataCopyWith<$Res> get parsed {
    return $SplTokenProgramAccountDataCopyWith<$Res>(_self.parsed, (value) {
      return _then(_self.copyWith(parsed: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class ParsedSplToken2022ProgramAccountData implements ParsedAccountData {
  const ParsedSplToken2022ProgramAccountData(this.parsed, {final String? $type})
    : $type = $type ?? 'spl-token-2022';
  factory ParsedSplToken2022ProgramAccountData.fromJson(Map<String, dynamic> json) =>
      _$ParsedSplToken2022ProgramAccountDataFromJson(json);

  @override
  final SplTokenProgramAccountData parsed;

  @JsonKey(name: 'program')
  final String $type;

  /// Create a copy of ParsedAccountData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ParsedSplToken2022ProgramAccountDataCopyWith<ParsedSplToken2022ProgramAccountData>
  get copyWith =>
      _$ParsedSplToken2022ProgramAccountDataCopyWithImpl<ParsedSplToken2022ProgramAccountData>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$ParsedSplToken2022ProgramAccountDataToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ParsedSplToken2022ProgramAccountData &&
            (identical(other.parsed, parsed) || other.parsed == parsed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, parsed);

  @override
  String toString() {
    return 'ParsedAccountData.token2022(parsed: $parsed)';
  }
}

/// @nodoc
abstract mixin class $ParsedSplToken2022ProgramAccountDataCopyWith<$Res>
    implements $ParsedAccountDataCopyWith<$Res> {
  factory $ParsedSplToken2022ProgramAccountDataCopyWith(
    ParsedSplToken2022ProgramAccountData value,
    $Res Function(ParsedSplToken2022ProgramAccountData) _then,
  ) = _$ParsedSplToken2022ProgramAccountDataCopyWithImpl;
  @useResult
  $Res call({SplTokenProgramAccountData parsed});

  $SplTokenProgramAccountDataCopyWith<$Res> get parsed;
}

/// @nodoc
class _$ParsedSplToken2022ProgramAccountDataCopyWithImpl<$Res>
    implements $ParsedSplToken2022ProgramAccountDataCopyWith<$Res> {
  _$ParsedSplToken2022ProgramAccountDataCopyWithImpl(this._self, this._then);

  final ParsedSplToken2022ProgramAccountData _self;
  final $Res Function(ParsedSplToken2022ProgramAccountData) _then;

  /// Create a copy of ParsedAccountData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? parsed = null}) {
    return _then(
      ParsedSplToken2022ProgramAccountData(
        null == parsed
            ? _self.parsed
            : parsed // ignore: cast_nullable_to_non_nullable
                as SplTokenProgramAccountData,
      ),
    );
  }

  /// Create a copy of ParsedAccountData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SplTokenProgramAccountDataCopyWith<$Res> get parsed {
    return $SplTokenProgramAccountDataCopyWith<$Res>(_self.parsed, (value) {
      return _then(_self.copyWith(parsed: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class ParsedStakeProgramAccountData implements ParsedAccountData {
  const ParsedStakeProgramAccountData(this.parsed, {final String? $type})
    : $type = $type ?? 'stake';
  factory ParsedStakeProgramAccountData.fromJson(Map<String, dynamic> json) =>
      _$ParsedStakeProgramAccountDataFromJson(json);

  @override
  final StakeProgramAccountData parsed;

  @JsonKey(name: 'program')
  final String $type;

  /// Create a copy of ParsedAccountData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ParsedStakeProgramAccountDataCopyWith<ParsedStakeProgramAccountData> get copyWith =>
      _$ParsedStakeProgramAccountDataCopyWithImpl<ParsedStakeProgramAccountData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ParsedStakeProgramAccountDataToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ParsedStakeProgramAccountData &&
            (identical(other.parsed, parsed) || other.parsed == parsed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, parsed);

  @override
  String toString() {
    return 'ParsedAccountData.stake(parsed: $parsed)';
  }
}

/// @nodoc
abstract mixin class $ParsedStakeProgramAccountDataCopyWith<$Res>
    implements $ParsedAccountDataCopyWith<$Res> {
  factory $ParsedStakeProgramAccountDataCopyWith(
    ParsedStakeProgramAccountData value,
    $Res Function(ParsedStakeProgramAccountData) _then,
  ) = _$ParsedStakeProgramAccountDataCopyWithImpl;
  @useResult
  $Res call({StakeProgramAccountData parsed});

  $StakeProgramAccountDataCopyWith<$Res> get parsed;
}

/// @nodoc
class _$ParsedStakeProgramAccountDataCopyWithImpl<$Res>
    implements $ParsedStakeProgramAccountDataCopyWith<$Res> {
  _$ParsedStakeProgramAccountDataCopyWithImpl(this._self, this._then);

  final ParsedStakeProgramAccountData _self;
  final $Res Function(ParsedStakeProgramAccountData) _then;

  /// Create a copy of ParsedAccountData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? parsed = null}) {
    return _then(
      ParsedStakeProgramAccountData(
        null == parsed
            ? _self.parsed
            : parsed // ignore: cast_nullable_to_non_nullable
                as StakeProgramAccountData,
      ),
    );
  }

  /// Create a copy of ParsedAccountData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StakeProgramAccountDataCopyWith<$Res> get parsed {
    return $StakeProgramAccountDataCopyWith<$Res>(_self.parsed, (value) {
      return _then(_self.copyWith(parsed: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class UnsupportedProgramAccountData implements ParsedAccountData {
  const UnsupportedProgramAccountData(final Map<String, dynamic> parsed, {final String? $type})
    : _parsed = parsed,
      $type = $type ?? 'unsupported';
  factory UnsupportedProgramAccountData.fromJson(Map<String, dynamic> json) =>
      _$UnsupportedProgramAccountDataFromJson(json);

  final Map<String, dynamic> _parsed;
  @override
  Map<String, dynamic> get parsed {
    if (_parsed is EqualUnmodifiableMapView) return _parsed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_parsed);
  }

  @JsonKey(name: 'program')
  final String $type;

  /// Create a copy of ParsedAccountData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnsupportedProgramAccountDataCopyWith<UnsupportedProgramAccountData> get copyWith =>
      _$UnsupportedProgramAccountDataCopyWithImpl<UnsupportedProgramAccountData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnsupportedProgramAccountDataToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnsupportedProgramAccountData &&
            const DeepCollectionEquality().equals(other._parsed, _parsed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(_parsed));

  @override
  String toString() {
    return 'ParsedAccountData.unsupported(parsed: $parsed)';
  }
}

/// @nodoc
abstract mixin class $UnsupportedProgramAccountDataCopyWith<$Res>
    implements $ParsedAccountDataCopyWith<$Res> {
  factory $UnsupportedProgramAccountDataCopyWith(
    UnsupportedProgramAccountData value,
    $Res Function(UnsupportedProgramAccountData) _then,
  ) = _$UnsupportedProgramAccountDataCopyWithImpl;
  @useResult
  $Res call({Map<String, dynamic> parsed});
}

/// @nodoc
class _$UnsupportedProgramAccountDataCopyWithImpl<$Res>
    implements $UnsupportedProgramAccountDataCopyWith<$Res> {
  _$UnsupportedProgramAccountDataCopyWithImpl(this._self, this._then);

  final UnsupportedProgramAccountData _self;
  final $Res Function(UnsupportedProgramAccountData) _then;

  /// Create a copy of ParsedAccountData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? parsed = null}) {
    return _then(
      UnsupportedProgramAccountData(
        null == parsed
            ? _self._parsed
            : parsed // ignore: cast_nullable_to_non_nullable
                as Map<String, dynamic>,
      ),
    );
  }
}
