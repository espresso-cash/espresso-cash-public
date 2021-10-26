// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'parsed_spl_token_account_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ParsedSplTokenAccountData _$ParsedSplTokenAccountDataFromJson(
    Map<String, dynamic> json) {
  switch (json['type'] as String?) {
    case 'mint':
      return ParsedMintAccountData.fromJson(json);

    default:
      return SplTokenAccountData.fromJson(json);
  }
}

/// @nodoc
class _$ParsedSplTokenAccountDataTearOff {
  const _$ParsedSplTokenAccountDataTearOff();

  ParsedMintAccountData mint(
      {required MintAccountDataInfo info, String? accountType}) {
    return ParsedMintAccountData(
      info: info,
      accountType: accountType,
    );
  }

  SplTokenAccountData splToken(
      {required SplTokenAccountDataInfo info, String? accountType}) {
    return SplTokenAccountData(
      info: info,
      accountType: accountType,
    );
  }

  ParsedSplTokenAccountData fromJson(Map<String, Object> json) {
    return ParsedSplTokenAccountData.fromJson(json);
  }
}

/// @nodoc
const $ParsedSplTokenAccountData = _$ParsedSplTokenAccountDataTearOff();

/// @nodoc
mixin _$ParsedSplTokenAccountData {
  String? get accountType => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MintAccountDataInfo info, String? accountType)
        mint,
    required TResult Function(SplTokenAccountDataInfo info, String? accountType)
        splToken,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(MintAccountDataInfo info, String? accountType)? mint,
    TResult Function(SplTokenAccountDataInfo info, String? accountType)?
        splToken,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MintAccountDataInfo info, String? accountType)? mint,
    TResult Function(SplTokenAccountDataInfo info, String? accountType)?
        splToken,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ParsedMintAccountData value) mint,
    required TResult Function(SplTokenAccountData value) splToken,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ParsedMintAccountData value)? mint,
    TResult Function(SplTokenAccountData value)? splToken,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParsedMintAccountData value)? mint,
    TResult Function(SplTokenAccountData value)? splToken,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ParsedSplTokenAccountDataCopyWith<ParsedSplTokenAccountData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParsedSplTokenAccountDataCopyWith<$Res> {
  factory $ParsedSplTokenAccountDataCopyWith(ParsedSplTokenAccountData value,
          $Res Function(ParsedSplTokenAccountData) then) =
      _$ParsedSplTokenAccountDataCopyWithImpl<$Res>;
  $Res call({String? accountType});
}

/// @nodoc
class _$ParsedSplTokenAccountDataCopyWithImpl<$Res>
    implements $ParsedSplTokenAccountDataCopyWith<$Res> {
  _$ParsedSplTokenAccountDataCopyWithImpl(this._value, this._then);

  final ParsedSplTokenAccountData _value;
  // ignore: unused_field
  final $Res Function(ParsedSplTokenAccountData) _then;

  @override
  $Res call({
    Object? accountType = freezed,
  }) {
    return _then(_value.copyWith(
      accountType: accountType == freezed
          ? _value.accountType
          : accountType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class $ParsedMintAccountDataCopyWith<$Res>
    implements $ParsedSplTokenAccountDataCopyWith<$Res> {
  factory $ParsedMintAccountDataCopyWith(ParsedMintAccountData value,
          $Res Function(ParsedMintAccountData) then) =
      _$ParsedMintAccountDataCopyWithImpl<$Res>;
  @override
  $Res call({MintAccountDataInfo info, String? accountType});
}

/// @nodoc
class _$ParsedMintAccountDataCopyWithImpl<$Res>
    extends _$ParsedSplTokenAccountDataCopyWithImpl<$Res>
    implements $ParsedMintAccountDataCopyWith<$Res> {
  _$ParsedMintAccountDataCopyWithImpl(
      ParsedMintAccountData _value, $Res Function(ParsedMintAccountData) _then)
      : super(_value, (v) => _then(v as ParsedMintAccountData));

  @override
  ParsedMintAccountData get _value => super._value as ParsedMintAccountData;

  @override
  $Res call({
    Object? info = freezed,
    Object? accountType = freezed,
  }) {
    return _then(ParsedMintAccountData(
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as MintAccountDataInfo,
      accountType: accountType == freezed
          ? _value.accountType
          : accountType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParsedMintAccountData implements ParsedMintAccountData {
  const _$ParsedMintAccountData({required this.info, this.accountType});

  factory _$ParsedMintAccountData.fromJson(Map<String, dynamic> json) =>
      _$$ParsedMintAccountDataFromJson(json);

  @override
  final MintAccountDataInfo info;
  @override
  final String? accountType;

  @override
  String toString() {
    return 'ParsedSplTokenAccountData.mint(info: $info, accountType: $accountType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ParsedMintAccountData &&
            (identical(other.info, info) ||
                const DeepCollectionEquality().equals(other.info, info)) &&
            (identical(other.accountType, accountType) ||
                const DeepCollectionEquality()
                    .equals(other.accountType, accountType)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(info) ^
      const DeepCollectionEquality().hash(accountType);

  @JsonKey(ignore: true)
  @override
  $ParsedMintAccountDataCopyWith<ParsedMintAccountData> get copyWith =>
      _$ParsedMintAccountDataCopyWithImpl<ParsedMintAccountData>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MintAccountDataInfo info, String? accountType)
        mint,
    required TResult Function(SplTokenAccountDataInfo info, String? accountType)
        splToken,
  }) {
    return mint(info, accountType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(MintAccountDataInfo info, String? accountType)? mint,
    TResult Function(SplTokenAccountDataInfo info, String? accountType)?
        splToken,
  }) {
    return mint?.call(info, accountType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MintAccountDataInfo info, String? accountType)? mint,
    TResult Function(SplTokenAccountDataInfo info, String? accountType)?
        splToken,
    required TResult orElse(),
  }) {
    if (mint != null) {
      return mint(info, accountType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ParsedMintAccountData value) mint,
    required TResult Function(SplTokenAccountData value) splToken,
  }) {
    return mint(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ParsedMintAccountData value)? mint,
    TResult Function(SplTokenAccountData value)? splToken,
  }) {
    return mint?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParsedMintAccountData value)? mint,
    TResult Function(SplTokenAccountData value)? splToken,
    required TResult orElse(),
  }) {
    if (mint != null) {
      return mint(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ParsedMintAccountDataToJson(this)..['type'] = 'mint';
  }
}

abstract class ParsedMintAccountData implements ParsedSplTokenAccountData {
  const factory ParsedMintAccountData(
      {required MintAccountDataInfo info,
      String? accountType}) = _$ParsedMintAccountData;

  factory ParsedMintAccountData.fromJson(Map<String, dynamic> json) =
      _$ParsedMintAccountData.fromJson;

  MintAccountDataInfo get info => throw _privateConstructorUsedError;
  @override
  String? get accountType => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $ParsedMintAccountDataCopyWith<ParsedMintAccountData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SplTokenAccountDataCopyWith<$Res>
    implements $ParsedSplTokenAccountDataCopyWith<$Res> {
  factory $SplTokenAccountDataCopyWith(
          SplTokenAccountData value, $Res Function(SplTokenAccountData) then) =
      _$SplTokenAccountDataCopyWithImpl<$Res>;
  @override
  $Res call({SplTokenAccountDataInfo info, String? accountType});
}

/// @nodoc
class _$SplTokenAccountDataCopyWithImpl<$Res>
    extends _$ParsedSplTokenAccountDataCopyWithImpl<$Res>
    implements $SplTokenAccountDataCopyWith<$Res> {
  _$SplTokenAccountDataCopyWithImpl(
      SplTokenAccountData _value, $Res Function(SplTokenAccountData) _then)
      : super(_value, (v) => _then(v as SplTokenAccountData));

  @override
  SplTokenAccountData get _value => super._value as SplTokenAccountData;

  @override
  $Res call({
    Object? info = freezed,
    Object? accountType = freezed,
  }) {
    return _then(SplTokenAccountData(
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as SplTokenAccountDataInfo,
      accountType: accountType == freezed
          ? _value.accountType
          : accountType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SplTokenAccountData implements SplTokenAccountData {
  const _$SplTokenAccountData({required this.info, this.accountType});

  factory _$SplTokenAccountData.fromJson(Map<String, dynamic> json) =>
      _$$SplTokenAccountDataFromJson(json);

  @override
  final SplTokenAccountDataInfo info;
  @override
  final String? accountType;

  @override
  String toString() {
    return 'ParsedSplTokenAccountData.splToken(info: $info, accountType: $accountType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SplTokenAccountData &&
            (identical(other.info, info) ||
                const DeepCollectionEquality().equals(other.info, info)) &&
            (identical(other.accountType, accountType) ||
                const DeepCollectionEquality()
                    .equals(other.accountType, accountType)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(info) ^
      const DeepCollectionEquality().hash(accountType);

  @JsonKey(ignore: true)
  @override
  $SplTokenAccountDataCopyWith<SplTokenAccountData> get copyWith =>
      _$SplTokenAccountDataCopyWithImpl<SplTokenAccountData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MintAccountDataInfo info, String? accountType)
        mint,
    required TResult Function(SplTokenAccountDataInfo info, String? accountType)
        splToken,
  }) {
    return splToken(info, accountType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(MintAccountDataInfo info, String? accountType)? mint,
    TResult Function(SplTokenAccountDataInfo info, String? accountType)?
        splToken,
  }) {
    return splToken?.call(info, accountType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MintAccountDataInfo info, String? accountType)? mint,
    TResult Function(SplTokenAccountDataInfo info, String? accountType)?
        splToken,
    required TResult orElse(),
  }) {
    if (splToken != null) {
      return splToken(info, accountType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ParsedMintAccountData value) mint,
    required TResult Function(SplTokenAccountData value) splToken,
  }) {
    return splToken(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ParsedMintAccountData value)? mint,
    TResult Function(SplTokenAccountData value)? splToken,
  }) {
    return splToken?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParsedMintAccountData value)? mint,
    TResult Function(SplTokenAccountData value)? splToken,
    required TResult orElse(),
  }) {
    if (splToken != null) {
      return splToken(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SplTokenAccountDataToJson(this)..['type'] = 'splToken';
  }
}

abstract class SplTokenAccountData implements ParsedSplTokenAccountData {
  const factory SplTokenAccountData(
      {required SplTokenAccountDataInfo info,
      String? accountType}) = _$SplTokenAccountData;

  factory SplTokenAccountData.fromJson(Map<String, dynamic> json) =
      _$SplTokenAccountData.fromJson;

  SplTokenAccountDataInfo get info => throw _privateConstructorUsedError;
  @override
  String? get accountType => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $SplTokenAccountDataCopyWith<SplTokenAccountData> get copyWith =>
      throw _privateConstructorUsedError;
}
