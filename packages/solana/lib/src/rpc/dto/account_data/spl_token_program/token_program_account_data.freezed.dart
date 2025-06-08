// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_program_account_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
SplTokenProgramAccountData _$SplTokenProgramAccountDataFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'account':
      return TokenAccountData.fromJson(json);
    case 'mint':
      return MintAccountData.fromJson(json);

    default:
      return UnknownAccountData.fromJson(json);
  }
}

/// @nodoc
mixin _$SplTokenProgramAccountData {
  String get type;

  /// Create a copy of SplTokenProgramAccountData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SplTokenProgramAccountDataCopyWith<SplTokenProgramAccountData> get copyWith =>
      _$SplTokenProgramAccountDataCopyWithImpl<SplTokenProgramAccountData>(
        this as SplTokenProgramAccountData,
        _$identity,
      );

  /// Serializes this SplTokenProgramAccountData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SplTokenProgramAccountData &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type);

  @override
  String toString() {
    return 'SplTokenProgramAccountData(type: $type)';
  }
}

/// @nodoc
abstract mixin class $SplTokenProgramAccountDataCopyWith<$Res> {
  factory $SplTokenProgramAccountDataCopyWith(
    SplTokenProgramAccountData value,
    $Res Function(SplTokenProgramAccountData) _then,
  ) = _$SplTokenProgramAccountDataCopyWithImpl;
  @useResult
  $Res call({String type});
}

/// @nodoc
class _$SplTokenProgramAccountDataCopyWithImpl<$Res>
    implements $SplTokenProgramAccountDataCopyWith<$Res> {
  _$SplTokenProgramAccountDataCopyWithImpl(this._self, this._then);

  final SplTokenProgramAccountData _self;
  final $Res Function(SplTokenProgramAccountData) _then;

  /// Create a copy of SplTokenProgramAccountData
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
class TokenAccountData implements SplTokenProgramAccountData {
  const TokenAccountData({required this.info, required this.type, this.accountType});
  factory TokenAccountData.fromJson(Map<String, dynamic> json) => _$TokenAccountDataFromJson(json);

  final SplTokenAccountDataInfo info;
  @override
  final String type;
  final String? accountType;

  /// Create a copy of SplTokenProgramAccountData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TokenAccountDataCopyWith<TokenAccountData> get copyWith =>
      _$TokenAccountDataCopyWithImpl<TokenAccountData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TokenAccountDataToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenAccountData &&
            (identical(other.info, info) || other.info == info) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.accountType, accountType) || other.accountType == accountType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, info, type, accountType);

  @override
  String toString() {
    return 'SplTokenProgramAccountData.account(info: $info, type: $type, accountType: $accountType)';
  }
}

/// @nodoc
abstract mixin class $TokenAccountDataCopyWith<$Res>
    implements $SplTokenProgramAccountDataCopyWith<$Res> {
  factory $TokenAccountDataCopyWith(TokenAccountData value, $Res Function(TokenAccountData) _then) =
      _$TokenAccountDataCopyWithImpl;
  @override
  @useResult
  $Res call({SplTokenAccountDataInfo info, String type, String? accountType});
}

/// @nodoc
class _$TokenAccountDataCopyWithImpl<$Res> implements $TokenAccountDataCopyWith<$Res> {
  _$TokenAccountDataCopyWithImpl(this._self, this._then);

  final TokenAccountData _self;
  final $Res Function(TokenAccountData) _then;

  /// Create a copy of SplTokenProgramAccountData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? info = null, Object? type = null, Object? accountType = freezed}) {
    return _then(
      TokenAccountData(
        info:
            null == info
                ? _self.info
                : info // ignore: cast_nullable_to_non_nullable
                    as SplTokenAccountDataInfo,
        type:
            null == type
                ? _self.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String,
        accountType:
            freezed == accountType
                ? _self.accountType
                : accountType // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class MintAccountData implements SplTokenProgramAccountData {
  const MintAccountData({required this.info, required this.type, this.accountType});
  factory MintAccountData.fromJson(Map<String, dynamic> json) => _$MintAccountDataFromJson(json);

  final MintAccountDataInfo info;
  @override
  final String type;
  final String? accountType;

  /// Create a copy of SplTokenProgramAccountData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MintAccountDataCopyWith<MintAccountData> get copyWith =>
      _$MintAccountDataCopyWithImpl<MintAccountData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MintAccountDataToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MintAccountData &&
            (identical(other.info, info) || other.info == info) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.accountType, accountType) || other.accountType == accountType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, info, type, accountType);

  @override
  String toString() {
    return 'SplTokenProgramAccountData.mint(info: $info, type: $type, accountType: $accountType)';
  }
}

/// @nodoc
abstract mixin class $MintAccountDataCopyWith<$Res>
    implements $SplTokenProgramAccountDataCopyWith<$Res> {
  factory $MintAccountDataCopyWith(MintAccountData value, $Res Function(MintAccountData) _then) =
      _$MintAccountDataCopyWithImpl;
  @override
  @useResult
  $Res call({MintAccountDataInfo info, String type, String? accountType});
}

/// @nodoc
class _$MintAccountDataCopyWithImpl<$Res> implements $MintAccountDataCopyWith<$Res> {
  _$MintAccountDataCopyWithImpl(this._self, this._then);

  final MintAccountData _self;
  final $Res Function(MintAccountData) _then;

  /// Create a copy of SplTokenProgramAccountData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? info = null, Object? type = null, Object? accountType = freezed}) {
    return _then(
      MintAccountData(
        info:
            null == info
                ? _self.info
                : info // ignore: cast_nullable_to_non_nullable
                    as MintAccountDataInfo,
        type:
            null == type
                ? _self.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String,
        accountType:
            freezed == accountType
                ? _self.accountType
                : accountType // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class UnknownAccountData implements SplTokenProgramAccountData {
  const UnknownAccountData({required this.type});
  factory UnknownAccountData.fromJson(Map<String, dynamic> json) =>
      _$UnknownAccountDataFromJson(json);

  @override
  final String type;

  /// Create a copy of SplTokenProgramAccountData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnknownAccountDataCopyWith<UnknownAccountData> get copyWith =>
      _$UnknownAccountDataCopyWithImpl<UnknownAccountData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnknownAccountDataToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnknownAccountData &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type);

  @override
  String toString() {
    return 'SplTokenProgramAccountData.unknown(type: $type)';
  }
}

/// @nodoc
abstract mixin class $UnknownAccountDataCopyWith<$Res>
    implements $SplTokenProgramAccountDataCopyWith<$Res> {
  factory $UnknownAccountDataCopyWith(
    UnknownAccountData value,
    $Res Function(UnknownAccountData) _then,
  ) = _$UnknownAccountDataCopyWithImpl;
  @override
  @useResult
  $Res call({String type});
}

/// @nodoc
class _$UnknownAccountDataCopyWithImpl<$Res> implements $UnknownAccountDataCopyWith<$Res> {
  _$UnknownAccountDataCopyWithImpl(this._self, this._then);

  final UnknownAccountData _self;
  final $Res Function(UnknownAccountData) _then;

  /// Create a copy of SplTokenProgramAccountData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? type = null}) {
    return _then(
      UnknownAccountData(
        type:
            null == type
                ? _self.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}
